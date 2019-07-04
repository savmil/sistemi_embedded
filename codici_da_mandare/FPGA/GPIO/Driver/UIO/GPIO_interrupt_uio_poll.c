#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <sys/types.h> 
#include <sys/stat.h> 
#include <fcntl.h>
#include <sys/mman.h>
#include <poll.h>
#include "GPIO_interrupt_uio_poll.h"
/**
 * @file GPIO_interrupt_uio_poll.c
 * @brief permette la gestione del GPIO utilizzando 
 * un driver di tipo UIO
 */
#define	DIR_OFF    	    0  // DIRECTION
#define	WRITE_OFF	    4  // WRITE
#define READ_OFF		8  // READ
#define GLOBAL_INTR_EN  12 // GLOBAL INTERRUPT ENABLE
#define INTR_EN         16 // LOCAL INTERRUPT ENABLE
#define INTR_ACK_PEND   28 // PENDING/ACK REGISTER

#define GPIO_0_BASE_ADDR	0x43C00000
#define GPIO_1_BASE_ADDR	0x43C10000
#define GPIO_2_BASE_ADDR	0x43C20000

#define INTR_MASK 15

#define TIMEOUT 2000

typedef u_int8_t u8;
typedef u_int32_t u32;
/**
 * @brief Utilizzata per scrivere un valore all'interno di un registro della periferica, specificando l'indirizzo base virtuale e l'offset del registro in cui scrivere.
 *
 * @param addr, puntatore all' indirizzo da voler scrivere
 * @param offset, offset a partire dall' indirizzo a cui vogliamo scrivere
 * @param value, valore da voler scrivere 
 */
void write_reg(void *addr, unsigned int offset, unsigned int value)
{
	*((unsigned*)(addr + offset)) = value;
}
/**
 * @brief Utilizzata per leggere un valore da un registro della periferica, specificando l'indirizzo base virtuale e l'offset del registro da cui leggere.
 *
 * @param addr, puntatore all' indirizzo da voler leggere
 * @param offset, offset a partire dall' indirizzo a cui vogliamo scrivere
 */
unsigned int read_reg(void *addr, unsigned int offset)
{
	return *((unsigned*)(addr + offset));
}

/**
 * @brief Attende l'arrivo di un interrupt tramite chiamate a poll 
 *
 * @param fd0, valore del file descriptor del primo GPIO
 * @param fd1, valore del file descriptor del secondo GPIO
 * @param fd2, valore del file descriptor del terzo GPIO
 * @param addr_0, indirizzo base della prima periferica GPIO
 * @param addr_1, indirizzo base della seconda periferica GPIO
 * @param addr_2, indirizzo base della terza periferica GPIO
 */
void wait_for_interrupt(int fd0, int fd1, int fd2, void *addr_0, void *addr_1, void *addr_2)
{

	int pending = 0;
	int reenable = 1;
	u32 read_value;
	struct pollfd poll_fds [3];
	int ret;

	printf("Waiting for interrupts....\n");

	poll_fds[0].fd = fd0;
	poll_fds[0].events = POLLIN;  //The field events is an input parameter, a bit mask specifying the
       							  //events the application is interested in for the file descriptor fd. 
							      //Means that we are interested at the event: there is data to read.
	poll_fds[1].fd = fd1;
	poll_fds[1].events = POLLIN;
	
	poll_fds[2].fd = fd2;
	poll_fds[2].events = POLLIN;
	
	// non blocking wait for an interrupt on file descriptors specified in the pollfd structure*/
	ret = poll(poll_fds, 3, TIMEOUT); //timeout of TIMEOUT ms
	if (ret > 0){
			if(poll_fds[0].revents && POLLIN){
				
				read(fd0, (void *)&pending, sizeof(int));
				write_reg(addr_0, GLOBAL_INTR_EN, 0); //disabilito interruzioni
				printf("**********ISR SWITCH***********\n");
				read_value = read_reg(addr_0, READ_OFF);
				printf("Read value: %08x\n", read_value);
				write_reg(addr_0, INTR_ACK_PEND, INTR_MASK); //ACK
				sleep(1);
				write_reg(addr_0, INTR_ACK_PEND, 0); //ACK
				write_reg(addr_0, GLOBAL_INTR_EN, 1); //abiito interruzioni
				write(fd0, (void *)&reenable, sizeof(int));
				
			}
			if(poll_fds[1].revents && POLLIN){
				
				read(fd1, (void *)&pending, sizeof(int));
				write_reg(addr_1, GLOBAL_INTR_EN, 0); //disabilito interruzioni
				printf("**********ISR BUTTON***********\n");
				read_value = read_reg(addr_1, READ_OFF);
				printf("Read value: %08x\n", read_value);
				write_reg(addr_1, INTR_ACK_PEND, INTR_MASK); //ACK
				sleep(1);
				write_reg(addr_1, INTR_ACK_PEND, 0); //ACK
				write_reg(addr_1, GLOBAL_INTR_EN, 1); //abiito interruzioni
				write(fd1, (void *)&reenable, sizeof(int));
				
			}
			if(poll_fds[2].revents && POLLIN){
				
				read(fd2, (void *)&pending, sizeof(int));
				write_reg(addr_2, GLOBAL_INTR_EN, 0); //disabilito interruzioni
				printf("**********ISR LED***********\n");
				read_value = read_reg(addr_2, READ_OFF);
				printf("Read value: %08x\n", read_value);
				write_reg(addr_2, INTR_ACK_PEND, INTR_MASK); //ACK
				sleep(1);
				write_reg(addr_2, INTR_ACK_PEND, 0); //ACK
				write_reg(addr_2, GLOBAL_INTR_EN, 1); //abiito interruzioni
				write(fd2, (void *)&reenable, sizeof(int));
				
			}
	}
	
}

int main(int argc, char *argv[]){
	
	void *gpio_0_ptr;
	void *gpio_1_ptr;
	void *gpio_2_ptr;
	
	//---------------------MAPPING GPIO_0---------------------//
	
	int fd_gpio_0 = open("/dev/uio0", O_RDWR);
	if (fd_gpio_0 < 1){
		printf("Errore nell'accesso al device UIO0.\n");
		return -1;
	}
	
	unsigned dimensione_pag = sysconf(_SC_PAGESIZE);
	
	gpio_0_ptr = mmap(NULL, dimensione_pag, PROT_READ|PROT_WRITE, MAP_SHARED, fd_gpio_0, 0);
	
	write_reg(gpio_0_ptr, GLOBAL_INTR_EN, 1); // abilitazione interruzioni globali
	write_reg(gpio_0_ptr, INTR_EN, INTR_MASK); // abilitazione interruzioni 
	
	//---------------------MAPPING GPIO_1---------------------//
	
	int fd_gpio_1 = open("/dev/uio1", O_RDWR);
	if (fd_gpio_1 < 1){
		printf("Errore nell'accesso al device UIO1.\n");
		return -1;
	}
	
	gpio_1_ptr = mmap(NULL, dimensione_pag, PROT_READ|PROT_WRITE, MAP_SHARED, fd_gpio_1, 0);
	
	write_reg(gpio_1_ptr, GLOBAL_INTR_EN, 1); // abilitazione interruzioni globali
	write_reg(gpio_1_ptr, INTR_EN, INTR_MASK); // abilitazione interruzioni 
		
	//---------------------MAPPING GPIO_2---------------------//

	int fd_gpio_2 = open("/dev/uio2", O_RDWR);
	if (fd_gpio_2 < 1){
		printf("Errore nell'accesso al device UIO2.\n");
		return -1;
	}

	gpio_2_ptr = mmap(NULL, dimensione_pag, PROT_READ|PROT_WRITE, MAP_SHARED, fd_gpio_2, 0);
	
	write_reg(gpio_2_ptr, GLOBAL_INTR_EN, 1); // abilitazione interruzioni globali
	write_reg(gpio_2_ptr, INTR_EN, INTR_MASK); // abilitazione interruzioni 
	
	
	
	while (1) {
		printf("Calling function wait_for_interrupt: ");
		wait_for_interrupt(fd_gpio_0, fd_gpio_1, fd_gpio_2, gpio_0_ptr, gpio_1_ptr, gpio_2_ptr);
	}

	// unmap the gpio device
	munmap(gpio_0_ptr, dimensione_pag);
	munmap(gpio_1_ptr, dimensione_pag);
	munmap(gpio_2_ptr, dimensione_pag);
	
	return 0;
	
}
