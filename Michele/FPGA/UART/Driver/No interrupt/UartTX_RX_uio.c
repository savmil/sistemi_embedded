#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <limits.h>
#include <sys/types.h> 
#include <sys/stat.h> 
#include <fcntl.h>
#include <sys/mman.h>



#define	DEVICE_ADDRESS 0x43C00000

#define	TX	1
#define	RX	0


#define	DATA_IN 0							//8bit
#define	TX_EN	4								//1bit
#define	STATUS_REG 8				/* OE (0)  FE(1) DE(2) TX_BUSY(4) */
#define	RX_REG	12					//8 bit data reg RDA(8)

																		

int main(int argc, char *argv[]){

	
		void *Ptr;
		
		int scelta;
		int direzione=RX;
		int valore=0;

	
		while((scelta = getopt(argc,argv, "rt:")) != -1){

				switch(scelta){

					case 'r':
						direzione = RX;
						printf("*****RX**********\n\n");
						break;

					case 't':
						direzione = TX;
						valore = atoi(optarg);
						printf("*****TX**********\n\n");
						break;

					default:
						printf("Valore non riconosciuto.");
						return -1;
				}

		}

	

	int file_descr = open("/dev/uio0", O_RDWR);
	if (file_descr < 1){
		printf("Errore nell'accesso in memoria\n");
		return -1;
	}

	
	unsigned indirizzo_periferica = DEVICE_ADDRESS;
	unsigned dimensione_pag = sysconf(_SC_PAGESIZE);
	unsigned indirizzo_pag = (indirizzo_periferica & (~(dimensione_pag-1)));
	unsigned offset_pag = indirizzo_periferica - indirizzo_pag;

	Ptr = mmap(NULL, dimensione_pag, PROT_READ|PROT_WRITE, MAP_SHARED, file_descr, indirizzo_pag);


	switch(direzione){
		
		case TX:
				//scrivo valore in DATA_IN e do TX_EN
			*((unsigned*)(Ptr + offset_pag + DATA_IN)) = valore;
			*((unsigned*)(Ptr + offset_pag + TX_EN)) = 1; 
			
			
			int statusTX=0;
			statusTX = *((unsigned*)(Ptr + offset_pag + STATUS_REG));
		
			printf("Inviato valore %08x\n",valore);
			break;
			
		case RX:
				;
				int dataRX = 0;
				dataRX= *((unsigned*)(Ptr + offset_pag + RX_REG));

				//polling for RDA enable
				while((dataRX & 256) != 256){			
				dataRX = *((unsigned*)(Ptr + offset_pag + RX_REG));
				}
				printf("valore letto : %08x\n", dataRX & 0x000000FF);
				int status=0;
				status = *((unsigned*)(Ptr + offset_pag + STATUS_REG));
				printf("STATUS_REGISTER : %08x\n\n", status);
				break;
	}
	munmap(Ptr, dimensione_pag);	
	return 0;
}
