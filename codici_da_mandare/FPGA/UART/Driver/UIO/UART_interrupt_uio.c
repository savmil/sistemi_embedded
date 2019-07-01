#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <sys/types.h> 
#include <sys/stat.h> 
#include <fcntl.h>
#include <sys/mman.h>
#include <string.h> 
#include "UART_interrupt_uio.h"
/**
 * @file UART_interrupt_uio.c
 * @brief permette la gestione della periferica UART utilizzando un driver di tipo UIO
 */
#define	DATA_IN   		0	// DATA TO SEND
#define	TX_EN	        4	// TRANSFER ENABLE (0)
#define	STATUS_REG      8   // OE(0) FE(1) DE(2) RDA(3) TX_BUSY(4) 
#define	RX_REG	        12 	// DATA RECEIVED
#define GLOBAL_INTR_EN  16 	// GLOBAL INTERRUPT ENABLE
#define INTR_EN         20 	// LOCAL INTERRUPT ENABLE
#define INTR_ACK_PEND   28 	// PENDING/ACK REGISTER

#define TX				1	
#define RX				2

#define INTR_MASK 3
/**
 * @file UART_interrupt_uio.c
 * @page driver_UART_UIO
 * @brief funzioni per gestire la trasmissione e la ricezione dei
 * 	      dati utilizzando il protocollo UART
 */

int tx_count, rx_count =0;
int buffer_size = 0;
char * buffer_tx;
char * buffer_rx;

/**
 *
 * @brief	Utilizzata per scrivere un valore all'interno di un registro
 *			della periferica, specificando l'indirizzo base virtuale e 
 *			l'offset del registro in cui scrivere
 *
 * @param	addr indirizzo virtuale della periferica
 * @param	offset offset del registro a cui scrivere
 * @param	valore da scrivere
 *	
 *
 *
 */
void write_reg(void *addr, unsigned int offset, unsigned int value)
{
	*((unsigned*)(addr + offset)) = value;
}
/**
 *
 * @brief	Utilizzata per leggere un valore da un registro
 *		della periferica, specificando l'indirizzo base virtuale e 
 *		l'offset del registro da cui leggere
 *
 * @param	addr indirizzo virtuale della periferica
 * @param	offset offset del registro a cui leggere
 *
 * @return	valore presente all'interno del registro
 *
 *
 */
unsigned int read_reg(void *addr, unsigned int offset)
{
	return *((unsigned*)(addr + offset));
}

/**
 *
 * @brief	Attende l' arrivo di un interrupt utilizzando la read 
 *			su un device UIO
 *
 * @param	file_descr descrittore del UIO driver
 * @param	addr indirizzo virtuale della periferica
 *
 *
 */
void wait_for_interrupt(int file_descr, void *addr)
{
	
	printf("Waiting for interrupts......");
	
	int i = 0;
	int pending = 0;
	int reenable = 1;
	u_int32_t pending_reg = 0;
	u_int32_t reg_sent_data = 0;
	u_int32_t reg_received_data = 0;
	
/* Attesa sul file descriptor in attesa di ricevere un'interruzione*/
	read(file_descr, (void *)&pending, sizeof(int));
/* Interruzione ricevuta*/

/* Disasserisce il transfer enable e disabilita le interruzioni */
	write_reg(addr, TX_EN, 0); 
	write_reg(addr, GLOBAL_INTR_EN, 0); 
	
	printf("IRQ detected!\n");
	
	pending_reg = read_reg(addr, INTR_ACK_PEND);
//	printf("Pending reg: %08x\n", pending_reg); // STAMPA DEBUG
	
	if((pending_reg & 0x00000002) == 0x00000002){

		printf("---ISR RX---\n");
		
		if(rx_count <= buffer_size){
			rx_count++;
			reg_received_data = read_reg(addr, RX_REG);
			printf("ISR RX - value received: %c\n", reg_received_data);
			buffer_rx[rx_count] = reg_received_data;

			
			if(rx_count == buffer_size){
				printf("Trasmissione/Ricezione completata, valore ricevuto: ");
				for(i=0; i<=rx_count; i++)
					printf("%c",buffer_rx[i]);
				printf("\n");
			}
		}
/* ACK ricezione */	
		write_reg(addr, INTR_ACK_PEND, RX); 
		write_reg(addr, INTR_ACK_PEND, 0); 
		
/* Riabilitazione interruzioni*/
		write_reg(addr, GLOBAL_INTR_EN, 1); 
	}	
	else if((pending_reg & 0x00000001) == 0x00000001){

		printf("---ISR TX---\n");
		tx_count++;
		
		if(tx_count < buffer_size){
			
			reg_sent_data = read_reg(addr, DATA_IN);
			printf("ISR TX - value sent: %c\n", reg_sent_data);
			printf("ISR TX - start sending next value: %c\n", buffer_tx[tx_count]);
			write_reg(addr, DATA_IN, buffer_tx[tx_count]);
			
/* ACK trasmissione*/		
			write_reg(addr, INTR_ACK_PEND, TX); 		 
/* Riabilitazione interruzioni*/
			write_reg(addr, INTR_ACK_PEND, 0); 
			write_reg(addr, GLOBAL_INTR_EN, 1); 
/* Abilitazione del trasferimento */
			write_reg(addr, TX_EN, 1); 
		}
		else{
			write_reg(addr, INTR_ACK_PEND, TX); 
			write_reg(addr, INTR_ACK_PEND, 0); 
			write_reg(addr, GLOBAL_INTR_EN, 1); 
		}
	}	
	
/* Riabilita l'interrupt nell'interrupt controller attraverso il sottosistema UIO */
	
	int ret = write(file_descr, (void *)&reenable, sizeof(int));
	
}

int main(int argc, char *argv[]){
	
	int j;
	void *uart_ptr;
	
	int DIM = strlen(argv[1]);
	buffer_size = DIM;	
	buffer_tx = malloc(sizeof(char)*DIM);
	buffer_rx = malloc(sizeof(char)*DIM);
	
	buffer_tx = argv[1];
	
	int file_descr = open("/dev/uio0", O_RDWR);
	if (file_descr < 1){
		printf("Errore nell'accesso al device UIO.\n");
		return -1;
	}
	
	unsigned dimensione_pag = sysconf(_SC_PAGESIZE);

	uart_ptr = mmap(NULL, dimensione_pag, PROT_READ|PROT_WRITE, MAP_SHARED, file_descr, 0);
	
	printf("L'utente ha chiesto di mandare la stringa: %s, di %d caratteri.", buffer_tx, DIM);
	
/* Abilitazione interruzioni globali */
	write_reg(uart_ptr, GLOBAL_INTR_EN, 1); 
	
/* Abilitazione interruzioni */
	write_reg(uart_ptr, INTR_EN, INTR_MASK); 
	
/* Settaggio del primo carattere da mandare */
	write_reg(uart_ptr, DATA_IN, buffer_tx[0]);
	
/* Abilitazione del trasferimento */
	write_reg(uart_ptr, TX_EN, 1); 
	
	while(tx_count < buffer_size){
		wait_for_interrupt(file_descr, uart_ptr);
	}

/* Fa l'unmap del device UART */
	munmap(uart_ptr, dimensione_pag);
	
	free(buffer_rx);
	return 0;
	
}
