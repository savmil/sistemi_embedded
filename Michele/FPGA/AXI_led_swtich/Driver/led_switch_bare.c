#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <sys/types.h> 
#include <sys/stat.h> 
#include <fcntl.h>
#include <sys/mman.h>

#define INPUT 1
#define OUTPUT 2
#define SWC_OFFSET 0
#define LED_OFFSET 4

int main(int argc, char *argv[]){

	void *Ptr;
	
	int scelta;
	int direzione = 0; 
	int valore = 0;
	
	while ((scelta = getopt(argc, argv, "io:")) != -1) {
               switch (scelta) {
               case 'i':
                   direzione = INPUT;
                   break;
               case 'o':
		           direzione = OUTPUT;
                   valore = atoi(optarg);
                   break;
               default:
                   printf("Valore non riconosciuto.");
                   return -1;
               }
           }
	
	int file_descr = open("/dev/mem", O_RDWR);
	if (file_descr < 1){
		printf("Errore nell'accesso in memoria\n");
		return -1;
	}
	
	unsigned dimensione_pag = sysconf(_SC_PAGESIZE);
	unsigned indirizzo_periferica = 0x43C00000;
	unsigned indirizzo_pag = (indirizzo_periferica & (~(dimensione_pag-1)));
	unsigned offset_pag = indirizzo_periferica - indirizzo_pag;
	
	Ptr = mmap(NULL, dimensione_pag, PROT_READ|PROT_WRITE, MAP_SHARED, file_descr, indirizzo_pag);
	
	switch(direzione){
		case INPUT:
			valore = *((unsigned*)(Ptr + offset_pag + SWC_OFFSET));
			printf("Valore di input: %08x\n", valore);
			break;
		case OUTPUT:
			printf("Lettura da %08x\n", *(unsigned int*)Ptr);
			*((unsigned*)(Ptr + offset_pag + LED_OFFSET)) = valore;
			break;
	}
	
	munmap(Ptr, dimensione_pag);
	
	return 0;
}
