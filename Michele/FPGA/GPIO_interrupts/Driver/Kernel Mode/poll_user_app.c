#include <unistd.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <sys/types.h> 
#include <sys/stat.h> 
#include <fcntl.h>
#include <sys/mman.h>
#include <poll.h>

#define READ_OFFSET 8

#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2

#define TIMEOUT 3000

int main(int argc, char *argv[]){

	
	int scelta;
	char * GPIO_selected; 
	
	while ((scelta = getopt(argc, argv, "bls")) != -1) {
               switch (scelta) {
               case 'b':
				   GPIO_selected = "/dev/GPIO1";   
				   printf("Apertura GPIO0, BUTTON.\n");
                   break;
               case 'l':
		           GPIO_selected = "/dev/GPIO2";
				   printf("Apertura GPIO2, LED.\n");
                   break;
			   case 's':
		           GPIO_selected = "/dev/GPIO0";
				   printf("Apertura GPIO0, SWITCHES.\n");
                   break;	   
               default:
                   printf("Valore non riconosciuto.");
                   return -1;
               }
           }
	
	
	int file_descr = open(GPIO_selected, O_RDWR);
	if (file_descr < 1){
		printf("Errore nell'accesso al device.\n");
		return -1;
	}

	uint32_t read_value = 0;

	struct pollfd * poll_fds;

        poll_fds = (struct pollfd *) malloc(sizeof(struct pollfd));

        poll_fds->fd = file_descr;
        poll_fds->events = POLLIN | POLLRDNORM;
	
	int ret = poll(poll_fds, 1, TIMEOUT);

if(ret > 0)
	{
		printf("Puoi effettuare la read, non sarà bloccante.\n");	
		lseek(file_descr, READ_OFFSET, SEEK_SET);
		read(file_descr, &read_value, sizeof(uint32_t));

		printf("Valore ricevuto: %08x\n", read_value);
	}
	else
		printf("La read sarà bloccante.\n");
	
	close(file_descr);
}
