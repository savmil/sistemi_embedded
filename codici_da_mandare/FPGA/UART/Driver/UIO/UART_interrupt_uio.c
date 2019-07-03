#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <sys/types.h> 
#include <sys/stat.h> 
#include <fcntl.h>
#include <sys/mman.h>
#include <string.h> 
#include <poll.h>
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

#define TIMEOUT			5000

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
struct pollfd poll_fds [2];

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
 * @param	poll_fds struct contenente i due descrittori del file per 
 *			i due device UART
 * @param	uart_rx_ptr indirizzo virtuale della periferica UART utilizzata 
 *			in ricezione
 * @param   uart_tx_ptr indirizzo virtuale della periferica UART utilizzata 
 *			in trasmissione
 *
 */
void wait_for_interrupt(struct pollfd * poll_fds, void *uart_rx_ptr, void *uart_tx_ptr)
{
	int pending =0;
	int reenable = 1;
	u_int32_t pending_reg = 0;
	u_int32_t reg_sent_data = 0;
	u_int32_t reg_received_data = 0;
	
	int ret = poll(poll_fds, 2, TIMEOUT);
	if (ret > 0){
			
/** Se vi è un'interruzione sul device UIO0 associato all'UART per la ricezione */
		if(poll_fds[0].revents && POLLIN){ 

			read(poll_fds[0].fd, (void *)&pending, sizeof(int));
			
/* Disabilita le interruzioni */ 
			write_reg(uart_rx_ptr, GLOBAL_INTR_EN, 0); 
		
			pending_reg = read_reg(uart_rx_ptr, INTR_ACK_PEND);
					
			if((pending_reg & RX) == RX){

				printf("ISR RX detected!\n");

				if(rx_count <= buffer_size){
					rx_count++;
					reg_received_data = read_reg(uart_rx_ptr, RX_REG);
					printf("ISR RX - value received: %c\n", reg_received_data);
					buffer_rx[rx_count] = reg_received_data;
				}
/* ACK ricezione */	
				write_reg(uart_rx_ptr, INTR_ACK_PEND, RX);
				write_reg(uart_rx_ptr, INTR_ACK_PEND, 0); 
/* Riabilitazione interruzioni*/
				write_reg(uart_rx_ptr, GLOBAL_INTR_EN, 1); 
			}	
/* Riabilita l'interrupt nell'interrupt controller attraverso il sottosistema UIO */
			write(poll_fds[0].fd, (void *)&reenable, sizeof(int));
		}
		
/** Se vi è un'interruzione sul device UIO0 associato all'UART per la trasmissione */
		if(poll_fds[1].revents && POLLIN){
			
			read(poll_fds[1].fd, (void *)&pending, sizeof(int));

/* Disasserisce il transfer enable e disabilita le interruzioni */
			write_reg(uart_tx_ptr, TX_EN, 0); 
			write_reg(uart_tx_ptr, GLOBAL_INTR_EN, 0); 
		
			pending_reg = read_reg(uart_tx_ptr, INTR_ACK_PEND);
			
			if((pending_reg & TX) == TX){

				printf("ISR TX Detected\n");
				tx_count++;

				if(tx_count <= buffer_size){

					reg_sent_data = read_reg(uart_tx_ptr, DATA_IN);
					printf("ISR TX - value sent: %c\n", reg_sent_data);
					
/* ACK trasmissione*/		
					write_reg(uart_tx_ptr, INTR_ACK_PEND, TX); 		 
					write_reg(uart_tx_ptr, INTR_ACK_PEND, 0); 
					
/* Riabilitazione interruzioni*/
					write_reg(uart_tx_ptr, GLOBAL_INTR_EN, 1); 

/* Abilitazione del trasferimento nuovo carattere */
					if(tx_count != buffer_size){
						printf("ISR TX - start sending next value: %c\n", buffer_tx[tx_count]);
						write_reg(uart_tx_ptr, DATA_IN, buffer_tx[tx_count]);	
						write_reg(uart_tx_ptr, TX_EN, 1); 
					}
				}	

		}
/* Riabilita l'interrupt nell'interrupt controller attraverso il sottosistema UIO */
		write(poll_fds[1].fd, (void *)&reenable, sizeof(int));
	}
}
}	
int main(int argc, char *argv[]){
	
	int j,i;
	void * uart_rx_ptr;
	void * uart_tx_ptr;
	
	int DIM = strlen(argv[1]);
	buffer_size = DIM;	
	buffer_tx = malloc(sizeof(char)*DIM);
	buffer_rx = malloc(sizeof(char)*DIM);
	
	buffer_tx = argv[1];
	
	int rx_file_descr = open("/dev/uio0", O_RDWR);
	if (rx_file_descr < 1){
		printf("Errore nell'accesso al device UIO.\n");
		return -1;
	}
	
	unsigned dimensione_pag = sysconf(_SC_PAGESIZE);
	uart_rx_ptr = mmap(NULL, dimensione_pag, PROT_READ|PROT_WRITE, MAP_SHARED, rx_file_descr, 0);
	
	int tx_file_descr = open("/dev/uio1", O_RDWR);
	if (tx_file_descr < 1){
		printf("Errore nell'accesso al device UIO.\n");
		return -1;
	}

	uart_tx_ptr = mmap(NULL, dimensione_pag, PROT_READ|PROT_WRITE, MAP_SHARED, tx_file_descr, 0);
	
	printf("L'utente ha chiesto di mandare la stringa: %s, di %d caratteri.\n", buffer_tx, DIM);
	
/* Abilitazione interruzioni globali */
	write_reg(uart_rx_ptr, GLOBAL_INTR_EN, 1); 	
/* Abilitazione interruzioni */
	write_reg(uart_rx_ptr, INTR_EN, RX); 
	
/* Abilitazione interruzioni globali */
	write_reg(uart_tx_ptr, GLOBAL_INTR_EN, 1); 
/* Abilitazione interruzioni */
	write_reg(uart_tx_ptr, INTR_EN, TX); 	
	
/* Settaggio del primo carattere da mandare */
	write_reg(uart_tx_ptr, DATA_IN, buffer_tx[0]);
	
/* Abilitazione del trasferimento */
	write_reg(uart_tx_ptr, TX_EN, 1); 
	
	poll_fds[0].fd = rx_file_descr;
	poll_fds[0].events = POLLIN;  
	
	poll_fds[1].fd = tx_file_descr;
	poll_fds[1].events = POLLIN;
	
	while(tx_count < buffer_size){
		 printf("Waiting for interrupts...... ");
		//sleep(1);
		wait_for_interrupt(poll_fds, uart_rx_ptr, uart_tx_ptr);
	}

	printf("Trasmissione/Ricezione completata, valore ricevuto: ");
	for(i=0; i<=rx_count; i++)
		printf("%c",buffer_rx[i]);
	
	printf("\n");
/* Fa l'unmap dei device UART */
	munmap(uart_tx_ptr, dimensione_pag);
	munmap(uart_rx_ptr, dimensione_pag);

	close(tx_file_descr);
	close(rx_file_descr);	
	
	free(buffer_rx);
	return 0;
	
}
