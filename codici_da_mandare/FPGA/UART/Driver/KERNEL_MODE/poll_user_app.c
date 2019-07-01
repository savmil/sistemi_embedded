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

#define TIMEOUT    2000

int main(int argc, char *argv[]){

	int i;
	int DIM = strlen(argv[1]);
	char * buf;
	char * read_value;
	
	buf = malloc(sizeof(char)*DIM);
	buf = argv[1];
	read_value = malloc(sizeof(char)*DIM);

	int file_descr = open("/dev/UART0", O_RDWR);
	if (file_descr < 1){
		printf("Errore nell'accesso al device.\n");
		return -1;
	}
	
	struct pollfd * poll_fds;

    poll_fds = (struct pollfd *) malloc(sizeof(struct pollfd));

    poll_fds->fd = file_descr;
    poll_fds->events = POLLIN | POLLRDNORM;
	
	for(i=0; i<5; i++){
		
		if(i==4){
			
			printf("L'utente ha chiesto di mandare la stringa: %s, di %d caratteri.\n", buf, DIM);
			write(file_descr, buf, sizeof(char)*DIM);	
		}
			
		int ret = poll(poll_fds, 1, TIMEOUT);
	
		if(ret>0){
		
			read(file_descr, read_value, sizeof(char)*DIM);

			printf("Interrupt occurred!\n");

			printf("Valore ricevuto:\n");

			printf("%s\n",read_value);
		
		}else
			printf("Non ci sono nuovi valori da leggere => la read sarà bloccante.\n");
	
	}
		
	free(read_value);
	free(poll_fds);
	
	close(file_descr);
}
