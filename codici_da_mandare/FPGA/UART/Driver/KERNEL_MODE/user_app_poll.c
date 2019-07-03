#include <unistd.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <sys/types.h> 
#include <sys/stat.h> 
#include <fcntl.h>
#include <sys/mman.h>
#include <string.h> 
#include <poll.h>

#define	DATA_IN    0
#define	RX_REG     12

#define SEEK_SET   0
#define SEEK_CUR   1
#define SEEK_END   2

#define TIMEOUT   1000

int main(int argc, char *argv[]){

	int i;
	int DIM = strlen(argv[1]);
	char * buf_tx;
	char * buf_rx;
	struct pollfd * poll_fds;
	
	buf_tx = malloc(sizeof(char));
	buf_tx = argv[1];
	buf_rx = malloc(sizeof(char));

	int tx_file_descr = open("/dev/UART1", O_RDWR);
    if (tx_file_descr < 1){
    	printf("Errore nell'accesso al device.\n");
    	return -1;
    }

    int rx_file_descr = open("/dev/UART0", O_RDWR);
    if (rx_file_descr < 1){
    	printf("Errore nell'accesso al device.\n");
    	return -1;
    }

    poll_fds = (struct pollfd *) malloc(sizeof(struct pollfd));

    poll_fds->fd = rx_file_descr;
    poll_fds->events = POLLIN | POLLRDNORM;
	
	for(i=0; i<5; i++){
		
		if(i==4){
			printf("L'utente ha chiesto di mandare il carattere: %c \n", buf_tx[0]);	
			write(tx_file_descr, buf_tx, sizeof(char));
		}
	
		int ret = poll(poll_fds, 1, TIMEOUT);
	
		if(ret>0){
			
			if(poll_fds[0].revents && POLLIN){
			
				read(rx_file_descr, buf_rx, sizeof(char));
				printf("Interrupt occurred!\n");
				printf("Valore ricevuto: %s\n",buf_rx);
			}
		}else
			printf("Non ci sono nuovi valori da leggere, una chiamata a read sarà bloccante.\n");
		
		usleep(1000);
	}
		
	free(buf_rx);

	close(rx_file_descr);
	close(tx_file_descr);
}
