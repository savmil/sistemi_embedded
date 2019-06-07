#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <sys/types.h> 
#include <sys/stat.h> 
#include <fcntl.h>
#include <sys/mman.h>
#include "UART_interrupt_uio.h"

#define	DATA_IN    0 // DATA TO SEND
#define	TX_EN	   4 // TRANSFER ENABLE (0)
#define	STATUS_REG 8 // OE (0)  FE(1) DE(2) RDA(3) TX_BUSY(4) 
#define	RX_REG	   12 // DATA RECEIVED
#define GLOBAL_INTR_EN 16 // GLOBAL INTERRUPT ENABLE
#define INTR_EN        20 // LOCAL INTERRUPT ENABLE
#define INTR_ACK_PEND  28 // PENDING/ACK REGISTER

#define BASE_ADDR	0x43C00000

#define INTR_MASK 3
/**
 * @file UART_interrupt_uio.c
 * @page driver_UART_UIO
 * @brief funzioni per gestire la trasmissione e la ricezione dei
 * 	  dati utilizzando il protocollo UART
 */
typedef u_int8_t u8;
typedef u_int32_t u32;

u8 buffer[4];
int tx_count, rx_count, buffer_size = 0;
u32 rx_total_reg = 0;

/**
 *
 * @brief	Permette la scrittura in un registro
 *
 * @param	addr indirizzo virtuale della periferica
 * @param	offset offset del registro a cui scrivere
 * @param	valore da scrivere
 *
 * @return	
 *
 * @note
 *
 */
void write_reg(void *addr, unsigned int offset, unsigned int value)
{
	*((unsigned*)(addr + offset)) = value;
}
/**
 *
 * @brief	Permette la lettura in un registro
 *
 * @param	addr indirizzo virtuale della periferica
 * @param	offset offset del registro a cui scrivere
 *
 * @return	
 *
 * @note
 *
 */
unsigned int read_reg(void *addr, unsigned int offset)
{
	return *((unsigned*)(addr + offset));
}

/**
 *
 * @brief	Attende l' arrivo di un interrupt utilizzando la read 
 *		su un device UIO
 *
 * @param	file_descr descrittore del UIO driver
 * @param	addr indirizzo virtuale della periferica
 *
 * @return	
 *
 * @note
 *
 */
void wait_for_interrupt(int file_descr, void *addr)
{
	
	printf("Waiting for interrupts......\n");
	
	int pending = 0;
	int reenable = 1;
	unsigned int reg;
	u32 pending_reg = 0;
	u32 reg_sent_data = 0;
	u32 reg_received_data = 0;
	
	// block on the file waiting for an interrupt */
	read(file_descr, (void *)&pending, sizeof(int));
	// interrupt received
	
	write_reg(addr, TX_EN, 0); // abbasso il TX_EN
	write_reg(addr, GLOBAL_INTR_EN, 0); //disabilito interruzioni
	
	printf("IRQ detected!\n");
	
	pending_reg = read_reg(addr, INTR_ACK_PEND);
	printf("Pending reg: %08x\n", pending_reg);
	
	if((pending_reg & 0x00000002) == 0x00000002){
		/*---ISR RX---*/
		printf("ISR RX...\n");
		rx_count++;
		
		printf("ISR RX - Confronto [rx_count = %d] e [buffer_size = %d]\n", rx_count, buffer_size);
		if(rx_count <= buffer_size){
			reg_received_data = read_reg(addr, RX_REG);
			printf("ISR RX - value received: %02x\n", reg_received_data);
			rx_total_reg = rx_total_reg | (reg_received_data << (rx_count-1)*8);
			printf("ISR RX - total value received: %02x\n", rx_total_reg);
		}
		
		write_reg(addr, INTR_ACK_PEND, 2); //ACK
		sleep(1);
		write_reg(addr, INTR_ACK_PEND, 0); //ACK
		write_reg(addr, GLOBAL_INTR_EN, 1); //abiito interruzioni
		printf("ISR RX - ACK sent.\n");
	}	
	else if((pending_reg & 0x00000001) == 0x00000001){
		/*---ISR TX---*/
		printf("ISR TX...\n");
		tx_count++;
		
		printf("ISR TX - Confronto [tx_count = %d] e [buffer_size = %d]\n", tx_count, buffer_size);
		if(tx_count < buffer_size){
			reg_sent_data = read_reg(addr, DATA_IN);
			printf("ISR TX - value sent: %02x\n", reg_sent_data);
			printf("ISR TX - start sending next value: %02x\n", buffer[tx_count]);
			write_reg(addr, DATA_IN, buffer[tx_count]);
			
			write_reg(addr, INTR_ACK_PEND, 1); //ACK
			sleep(1);
			write_reg(addr, INTR_ACK_PEND, 0); //ACK
			write_reg(addr, GLOBAL_INTR_EN, 1); //abiito interruzioni
			write_reg(addr, TX_EN, 1); //ebilito il trasferimento
			printf("ISR TX - ACK sent.\n");
		}
		else{
			write_reg(addr, INTR_ACK_PEND, 1); //ACK
			sleep(1);
			write_reg(addr, INTR_ACK_PEND, 0); //ACK
			write_reg(addr, GLOBAL_INTR_EN, 1); //abiito interruzioni
			printf("ISR TX - ACK sent.\n");
		}
	}	
	
	// re-enable the interrupt in the interrupt controller thru the
	// the UIO subsystem now that it's been handled

	int ret = write(file_descr, (void *)&reenable, sizeof(int));
	printf("RISULTATO write: %d\n",ret);
	
}

int main(int argc, char *argv[]){
	
	int j;
	void *uart_ptr;
	
	int file_descr = open("/dev/uio0", O_RDWR);
	if (file_descr < 1){
		printf("Errore nell'accesso al device UIO.\n");
		return -1;
	}
	
	unsigned dimensione_pag = sysconf(_SC_PAGESIZE);

	uart_ptr = mmap(NULL, dimensione_pag, PROT_READ|PROT_WRITE, MAP_SHARED, file_descr, 0);
	
	u32 data_to_send = 65514;
	u8 chunk;
	buffer_size = 0;

	printf("Valore iniziale da mandare: %u | HEX %08x\n", data_to_send, data_to_send);

	for(j=0; j<4; j++){

		chunk = (data_to_send >> j*8) & 255;

		if(chunk == 0){
			buffer_size = j;
			goto skip;
		}

		buffer[j] = chunk;
		buffer_size ++;

		printf("Buffer[%d]= %u | HEX %02x\n",j, buffer[j], buffer[j]);
	}

	skip:
	
	printf("Buffer size: %d\n", buffer_size);
	
	write_reg(uart_ptr, GLOBAL_INTR_EN, 1); // abilitazione interruzioni globali
	write_reg(uart_ptr, INTR_EN, INTR_MASK); // abilitazione interruzioni 
	
	write_reg(uart_ptr, DATA_IN, buffer[0]); // setto il dato
	write_reg(uart_ptr, TX_EN, 1); //ebilito il trasferimento
	
	while (1) {
		wait_for_interrupt(file_descr, uart_ptr);
	}

	// unmap the UART device
	munmap(uart_ptr, dimensione_pag);
	return 0;
	
}
