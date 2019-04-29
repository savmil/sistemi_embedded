#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <signal.h>
#include <fcntl.h>
#include <ctype.h>
#include <termios.h>
#include <sys/types.h>
#include <sys/mman.h>
  
#define MAP_SIZE 4096UL
#define MAP_MASK (MAP_SIZE - 1)
int main(int argc, char **argv) {
    int fd;
    void *map_base, *virt_addr; 
    unsigned long read_result, writeval;
    off_t target;
    int access_type = 'w';

    unsigned long int dim_pagina = sysconf(_SC_PAGESIZE); //ritorna dimensione pagina in byte
    unsigned long int size_pagina=dim_pagina-1;
    //printf("%ld \n",dim_pagina );

    //target = strtoul(argv[1], 0, 0); //mi permette di convertire stringa ad decimale
    


    fd = open("/dev/uio0", O_RDWR | O_SYNC);
    //printf("/dev/mem opened.\n"); 
    
    //permette di mappare la memoria su un puntatore, MAP_SHARED indica che le modifiche
    // sono presenti a tutti i processi
    // il puntatore mi restituisce (l' indirizzo virtuale) dove viene mappato l' indirizzo fisico cho
    // offset qui sta ad indicare quale deve essere l' indirizzo base da cui deve partire il puntatoe
    // che deve essere allineato alla pagina, quindi si deve evitare di prendere indirizzi non allini
    //per tale motivo �è presente l' and con il nedato della dimensione(per non prendere i 12 bit de 
    //printf("%x\n",target );
    //printf("%x\n", (~size_pagina) );
    //printf("%x\n",target & ~size_pagina );
    map_base = mmap(0, dim_pagina, PROT_READ | PROT_WRITE, MAP_SHARED, fd, target & 0);
    if(map_base == (void *) -1)
        printf("errore \n");
    //l' indirizzo virtuale mi �è dato da l' indirizzo a cui si trova il device mem
    // a cui bisogna aggiungere l' offset (cio�è quella end bitwise mi dice nella pagina)
    //qui viene calcolato il reale offset all' interno della pagina, infatti si determina 
    //solamente quanto quell' indirizzo si trovi nella pagina
    
    virt_addr = map_base + (target & size_pagina);
    unsigned long int carattere=10;
    char* stringa_scritta='0';
    char* stringa_letta='-1';
    int i=0;
    size_t contatore_scritti=0;
    size_t contatore_letti=0;
    void* registro_abilitazione=map_base + (0x43c0000 & size_pagina);
    void* registro_dati_da_scrivere=map_base + (0x43c0004 & size_pagina); 
    void* registro_dati_letti=map_base + (0x43c000C & size_pagina);
    stringa_scritta=(char*) malloc(sizeof(char));
    stringa_letta=(char*) malloc(sizeof(char)); 
   while(1)
    {
            //carattere=getchar();
            //fgets(carattere,contatore,stdin);
            //carattere=scanf("%c",&carattere_letto);
            fflush(stdin);
            contatore_scritti=0;
            //mi serve per evitare di avere nel buffer il new line
            while ((carattere=getchar())!='\n')
            {
            //carattere=scanf("%[^\n]",&carattere_letto);
            contatore_scritti++;
            //printf(" contatore scritti %d",contatore_scritti);
            stringa_scritta=realloc(stringa_scritta, contatore_scritti);
            stringa_scritta[contatore_scritti-1]=carattere;
            //printf("carattere while %d\n",stringa_scritta[contatore_scritti-1]);
            } 
            stringa_scritta[contatore_scritti]='\n'; //aggiungo il new line per stampare il valore voluto
            
            for (i=0;i<=contatore_scritti;i++)
            {
            //printf("i %d",i);

                //target=0x43c00004;
//            printf("qui\n");

            //virt_addr = map_base + (registro_dati_da_scrivere & size_pagina); 
            *((unsigned long *) registro_dati_da_scrivere) = stringa_scritta[i];
            //printf ("carattere %c",stringa_scritta[i]);
            read_result = *((unsigned long *) registro_dati_da_scrivere);
            //printf("ho scritto 0x%X",read_result);
            //target=0x43c00000;
            //virt_addr = map_base + (target & size_pagina); 
            *((unsigned long *) registro_abilitazione)= 0x00000002;
            read_result = *((unsigned long *) registro_abilitazione);
//          printf("ho scritto 0x%X",read_result);
            *((unsigned long *) registro_abilitazione)= 0x00000003;
            read_result = *((unsigned long *) registro_abilitazione);
//          printf("ho scritto 0x%X",read_result); 
            //target=0x43c0000c;
            //virt_addr = map_base + (target & size_pagina); 
            while((*((unsigned long *) registro_dati_letti)& 0x00000100)==0);
            read_result = *((unsigned long *) registro_dati_letti);

            //printf("Value at address 0x%X (%p): 0x%X\n", target, registro_dati_letti, read_result); 
            //target=0x43c00000;
            //virt_addr = map_base + (target & size_pagina);     
            *((unsigned long *) registro_abilitazione)= 0x00000002;
            //printf("carattere da salvare %d\n",read_result &0x000000FF);
            //stringa_scritta=scanf("%X",&read_result);
            contatore_letti++;

            stringa_letta=realloc(stringa_letta, contatore_letti);

            stringa_letta[contatore_letti-1]=read_result&0x000000FF;
            //printf ("carattere %c \n", stringa_letta[contatore_letti-1]);
            if (stringa_letta[contatore_letti-1]=='\n')
            {       printf("stringa letta ");
                    for (i=0;i<contatore_letti;i++)
                            printf("%c", stringa_letta[i]);
                    printf("\n");
                    contatore_letti=0;
            }
            else
            {
                    contatore_letti++;
            }
        }
    }

    // chiude il file descriptor
    

    munmap(map_base, dim_pagina);
    close(fd);
    return 0;
}


