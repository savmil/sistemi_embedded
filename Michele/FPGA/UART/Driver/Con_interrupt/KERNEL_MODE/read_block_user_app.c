#include <unistd.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <sys/types.h> 
#include <sys/stat.h> 
#include <fcntl.h>
#include <sys/mman.h>

#define	DATA_IN    0				
#define	RX_REG     12 

#define SEEK_SET   0
#define SEEK_CUR   1
#define SEEK_END   2

#define DIM 7

int main(int argc, char *argv[]){

	int i=0;
	char read_value [DIM];
	char buf [DIM] = "diocane";

	int file_descr = open("/dev/UART0", O_RDWR);
	if (file_descr < 1){
		printf("Errore nell'accesso al device.\n");
		return -1;
	}
	
	write(file_descr, buf, DIM);
	
	
	printf("Waiting for interrupt...");
		
	read(file_descr, &read_value, sizeof(char)*DIM);

	printf("Interrupt occurred!\n");
		
	printf("Valore ricevuto:\n");
		
	for(i=0; i<DIM; i++){
		
		printf("%c",read_value[i]);
	
	}
	
	close(file_descr);
}
