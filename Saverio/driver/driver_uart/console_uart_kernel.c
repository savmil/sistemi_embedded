#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/io.h>
#include <linux/slab.h> 
MODULE_LICENSE("GPL"); 
MODULE_AUTHOR("Mikkel and Thomas");
MODULE_DESCRIPTION("A very simple Linux device driver.");
MODULE_VERSION("0.1415926");
 
static int __init hello_init(void){
   int fd;
    void *map_base, *virt_addr; 
    unsigned long read_result, writeval;
    off_t target;
    int access_type = 'w';

    void* registro_abilitazione;
    void* registro_dati_da_scrivere;
    void* registro_dati_letti;
    char* stringa_scritta='0';
    char* stringa_letta='-1';
    int i=0;
    int j=0;
    size_t contatore_scritti=4;
    size_t contatore_letti=4;
    stringa_scritta=(char*) kmalloc(sizeof(char)*5,GFP_KERNEL);
    stringa_letta=(char*) kmalloc(sizeof(char)*5,GFP_KERNEL); 
    stringa_scritta[0]='c';
    stringa_scritta[1]='i';
    stringa_scritta[2]='a';
    stringa_scritta[3]='o';
    stringa_scritta[4]='\n';
    //printk("%ld \n",dim_pagina );
    //target = strtoul(argv[1], 0, 0); //mi permette di convertire stringa ad decimale
    


    //fd = single_open("/dev/uio0", NULL,NULL;
    //printk("/dev/mem opened.\n"); 
    //fflush(stdout);
    
    //permette di mappare la memoria su un puntatore, MAP_SHARED indica che le modifiche
    // sono presenti a tutti i processi
    // il puntatore mi restituisce (l' indirizzo virtuale) dove viene mappato l' indirizzo fisico cho
    // offset qui sta ad indicare quale deve essere l' indirizzo base da cui deve partire il puntatoe
    // che deve essere allineato alla pagina, quindi si deve evitare di prendere indirizzi non allini
    //per tale motivo �è presente l' and con il nedato della dimensione(per non prendere i 12 bit de 
    //printk("%x\n",target );
    //printk("%x\n", (~size_pagina) );
    //printk("%x\n",target & ~size_pagina );

    //    struct platform_device *pdev;
    //i parametri sono l' indirizzo fisico della periferica e lo spazio occupato dalla periferica
    registro_abilitazione = ioremap(0x43C00000,32);
    registro_dati_da_scrivere = ioremap(0x43C00004,32);
    registro_dati_letti = ioremap(0x43C0000C,32);
    printk(KERN_INFO "Goodbye World!, from your device 0x%X.\n",registro_abilitazione);
    iowrite32(0x00000002,registro_abilitazione);
    read_result=ioread32(registro_abilitazione);
     printk(KERN_INFO "Goodbye World!, from your device 0x%X.\n",stringa_scritta[0]);
     printk(KERN_INFO "Goodbye World!, from your device 0x%X.\n",stringa_scritta[1]);
     printk(KERN_INFO "Goodbye World!, from your device 0x%X.\n",stringa_scritta[2]);
     printk(KERN_INFO "Goodbye World!, from your device 0x%X.\n",stringa_scritta[3]);
     printk(KERN_INFO "Goodbye World!, from your device 0x%X.\n",stringa_scritta[4]);
    //struct resource *res;
    //res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    //int remap_size = res->end - res->start + 1;
	 for (i=0;i<=contatore_scritti;i++)
	    {
	        //printf("i %d",i);

	            //target=0x43c00004;
	//            printf("qui\n");

	        //virt_addr = map_base + (registro_dati_da_scrivere & size_pagina); 
	        iowrite32(stringa_scritta[i],registro_dati_da_scrivere);
	        //printf ("carattere %c",stringa_scritta[i]);
	        //read_result = *((unsigned long *) registro_dati_da_scrivere);
	        //printf("ho scritto 0x%X",read_result);
	        //target=0x43c00000;
	        //virt_addr = map_base + (target & size_pagina); 
	        iowrite32(0x00000002,registro_abilitazione);
	        //read_result = *((unsigned long *) registro_abilitazione);
	//          printf("ho scritto 0x%X",read_result);
	        iowrite32(0x00000003,registro_abilitazione);
	        //read_result = *((unsigned long *) registro_abilitazione);
	//          printf("ho scritto 0x%X",read_result); 
	        //target=0x43c0000c;
	        //virt_addr = map_base + (target & size_pagina); 
	        while((ioread32(registro_dati_letti)& 0x00000100)==0);
	        read_result = *((unsigned long *) registro_dati_letti);

	        //printf("Value at address 0x%X (%p): 0x%X\n", target, registro_dati_letti, read_result); 
	        //target=0x43c00000;
	        //virt_addr = map_base + (target & size_pagina);     
	        *((unsigned long *) registro_abilitazione)= 0x00000002;
	        //printf("carattere da salvare %d\n",read_result &0x000000FF);
	        //stringa_scritta=scanf("%X",&read_result);
	        //contatore_letti++;

	        //stringa_letta=realloc(stringa_letta, contatore_letti);
	        read_result=ioread32(registro_dati_letti);
	        stringa_letta[i]=read_result&0x000000FF;
	        printk("carattere %c \n", stringa_letta[i]);
	        if (stringa_letta[contatore_letti]=='\n')
	        {       printk("stringa letta ");
	                for (j=0;j<=contatore_letti;j++)
	                        printk("%c", stringa_letta[j]);
	                printk("\n");
	                contatore_letti=0;
	        }
	        else
	        {
	                //contatore_letti++;
	        }
	    }
        iounmap(registro_dati_letti);
        iounmap(registro_abilitazione);
        iounmap(registro_dati_da_scrivere);
   return 0;
}

static void __exit hello_exit(void){
   printk(KERN_INFO "Goodbye World!, from your device.\n");
}

module_init(hello_init);
module_exit(hello_exit)