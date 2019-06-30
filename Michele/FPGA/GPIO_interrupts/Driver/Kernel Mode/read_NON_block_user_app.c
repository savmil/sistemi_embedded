#include <unistd.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <sys/types.h> 
#include <sys/stat.h> 
#include <fcntl.h>
#include <sys/mman.h>

#define READ_OFFSET 8

#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2

#define TIMEOUT 1000

int main(int argc, char *argv[]){

	
	int scelta;
	char * GPIO_selected; 
	uint32_t read_value = 0;
	
	while ((scelta = getopt(argc, argv, "bls")) != -1) {
               switch (scelta) {
               case 'b':
				   GPIO_selected = "/dev/GPIO1";   
				   printf("Apertura GPIO0, BUTTON\n");
                   break;
               case 'l':
		           GPIO_selected = "/dev/GPIO2";
				   printf("Apertura GPIO2, LED\n");
                   break;
			   case 's':
		           GPIO_selected = "/dev/GPIO0";
				   printf("Apertura GPIO0, SWITCHES\n");
                   break;	   
               default:
                   printf("Valore non riconosciuto.\n");
                   return -1;
               }
           }
	
	
	int file_descr = open(GPIO_selected, O_RDWR | O_NONBLOCK);
	if (file_descr < 1){
		printf("Errore nell'accesso al device.\n");
		return -1;
	}

	lseek(file_descr, READ_OFFSET, SEEK_SET);
	
	while(1)
	{
		
		sleep(TIMEOUT);
		
		printf("Waiting for interrupt...");
		
		read(file_descr, &read_value, sizeof(uint32_t));

		printf("Interrupt occurred!\n");
		
		printf("Valore ricevuto: %08x\n", read_value);
	}
	
	close(file_descr);
}
