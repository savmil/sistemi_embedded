/*
 * devmem2.c: Simple program to read/write from/to any location in memory.
 *
 *  Copyright (C) 2000, Jan-Derk Bakker (jdb@lartmaker.nl)
 *
 *
 * This software has been developed for the LART computing board
 * (http://www.lart.tudelft.nl/). The development has been sponsored by
 * the Mobile MultiMedia Communications (http://www.mmc.tudelft.nl/)
 * and Ubiquitous Communications (http://www.ubicom.tudelft.nl/)
 * projects.
 *
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */

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
	printf("%ld \n",dim_pagina );
	if(argc < 2) {
		fprintf(stderr, "\nUsage:\t%s { address } [ type [ data ] ]\n"
			"\taddress : memory address to act upon\n"
			"\ttype    : access operation type : [b]yte, [h]alfword, [w]ord\n"
			"\tdata    : data to be written\n\n",
			argv[0]);
		exit(1);
	}
	target = strtoul(argv[1], 0, 0); //mi permette di convertire stringa ad decimale

	if(argc > 2)
		access_type = tolower(argv[2][0]);


    fd = open("/dev/mem", O_RDWR | O_SYNC);
    printf("/dev/mem opened.\n"); 
    fflush(stdout);
    
    //permette di mappare la memoria su un puntatore, MAP_SHARED indica che le modifiche
    // sono presenti a tutti i processi
    // il puntatore mi restituisce (l' indirizzo virtuale) dove viene mappato l' indirizzo fisico che voglio su quello logico
    // offset qui sta ad indicare quale deve essere l' indirizzo base da cui deve partire il puntatore
    // che deve essere allineato alla pagina, quindi si deve evitare di prendere indirizzi non allineati
    //per tale motivo è presente l' and con il nedato della dimensione(per non prendere i 12 bit dell' offset)  
    printf("%x\n",target );
     printf("%x\n", (~size_pagina) );
      printf("%x\n",target & ~size_pagina );
    map_base = mmap(0, dim_pagina, PROT_READ | PROT_WRITE, MAP_SHARED, fd, target & ~size_pagina);
    if(map_base == (void *) -1)
    	printf("errore \n");
    printf("Memory mapped at address  %p.\n", map_base); 
    fflush(stdout);
    //l' indirizzo virtuale mi è dato da l' indirizzo a cui si trova il device mem
    // a cui bisogna aggiungere l' offset (cioè quella end bitwise mi dice nella pagina)
    //qui viene calcolato il reale offset all' interno della pagina, infatti si determina 
    //solamente quanto quell' indirizzo si trovi nella pagina
    virt_addr = map_base + (target & size_pagina);
    if(access_type='w') 
    {
			read_result = *((unsigned long *) virt_addr);
	}
    printf("Value at address 0x%X (%p): 0x%X\n", target, virt_addr, read_result); 
    fflush(stdout);

	if(argc > 3) 
	{
		writeval = strtoul(argv[3], 0, 0);
		*((unsigned long *) virt_addr) = writeval;
		read_result = *((unsigned long *) virt_addr);
		
	}
	
	// chiude il file descriptor
	munmap(map_base, dim_pagina);
    close(fd);
    return 0;
}
