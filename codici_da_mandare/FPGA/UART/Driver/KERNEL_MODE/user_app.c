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

	printf("L'utente ha chiesto di mandare la stringa: %s, di %d caratteri. ", buf, DIM);
		
	write(file_descr, buf, sizeof(char)*DIM);
	
	printf("Waiting for interrupt...");

	read(file_descr, read_value, sizeof(char)*DIM);

	printf("Interrupt occurred!\n");

	printf("Valore ricevuto: ");
	
	printf("%s\n",read_value);
		
	free(read_value);

	close(file_descr);
}
