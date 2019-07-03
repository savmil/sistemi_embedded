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

#define	DATA_IN    0
#define	RX_REG     12

#define SEEK_SET   0
#define SEEK_CUR   1
#define SEEK_END   2

int main(int argc, char *argv[]){

	int i;
	int DIM = strlen(argv[1]);
	char * buf_tx;
	char * buf_rx;
	
	buf_tx = malloc(sizeof(char)*DIM);
	buf_tx = argv[1];
	buf_rx = malloc(sizeof(char)*DIM);

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
	printf("L'utente ha chiesto di mandare la stringa: %s, di %d caratteri. \n", buf_tx, DIM);
	
	for(i=0; i<DIM; i++){
		
		write(tx_file_descr, &buf_tx[i], sizeof(char));
		
		read(rx_file_descr, &buf_rx[i], sizeof(char));

		usleep(100000);
	}
	
	printf("Valore ricevuto: %s\n",buf_rx);
			
	free(buf_rx);

	close(rx_file_descr);
	close(tx_file_descr);
}
