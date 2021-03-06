#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/slab.h>
#include <linux/fs.h>
#include <linux/errno.h>
#include <linux/types.h>
#include <linux/proc_fs.h>
#include <linux/fcntl.h>
#include <linux/unistd.h>

#include <linux/platform_device.h>
#include <linux/of_device.h>
#include <linux/of_platform.h>
#include <linux/of_address.h>
#include <linux/of_irq.h>
#include <linux/interrupt.h>
#include <linux/irqreturn.h>
#include <asm/uaccess.h>
#include <asm/io.h>

#include <linux/sched.h>
#include <linux/poll.h>

#include <linux/io.h>
#include <linux/of.h>
#include <linux/mod_devicetable.h>

#include "UART_list.h"
/**
 * @file UART_kernel_main.c
 * @brief Inizializza il driver kernel ed espone le funzionalità del modulo
 */
/**
 * @brief Nome identificativo del device-driver.
 * Deve corrispondere al valore del campo "compatible" nel device tree source.
 */
#define DRIVER_NAME "UART"

/**
 * @brief Nome del file creato sotto /dev/ per ciascun device
 */
#define DRIVER_FNAME "UART%d"

#define TX 1
#define RX 2

MODULE_AUTHOR("gruppo 3");
MODULE_DESCRIPTION("UART device-driver kernel mode");
MODULE_VERSION("1.0");

/**
 * @brief Numero massimo di device gestibili
 *
 * MAX_NUM_OF_DEVICES dimensione della struttura dati UART_list
 */
#define MAX_NUM_OF_DEVICES 10

/*
 * Funzioni implementate dal modulo
 */
static int 			UART_probe			(struct platform_device *op);
static int 			UART_remove			(struct platform_device *op);
static int 			UART_open			(struct inode *inode, struct file *file_ptr);
static int 			UART_release		(struct inode *inode, struct file *file_ptr);
static loff_t		UART_llseek			(struct file *file_ptr, loff_t off, int whence);
static unsigned int UART_poll			(struct file *file_ptr, struct poll_table_struct *wait);
static ssize_t 		UART_read			(struct file *file_ptr, char *buf, size_t count, loff_t *ppos);
static ssize_t 		UART_write 			(struct file *file_ptr, const char __user * buf, size_t count, loff_t * off);
static irqreturn_t	UART_irq_handler	(int irq, struct pt_regs * regs);

#define INTR_MASK		0x3 //!< @brief Maschera di abilitazione degli interrupt per i singoli pin

static UART_list *device_list = NULL;

static struct class*  UART_class  = NULL;

/**
 * @brief Identifica il device all'interno del device tree
 *
 */
static const struct of_device_id __test_int_driver_id[]={
	{.compatible = "xlnx,UART-1.0"},
	{}
};

/**
 * @brief Struttura che specifica le funzioni che agiscono sul device
 *
 */
static struct file_operations UART_fops = {
		.owner		= THIS_MODULE,
		.llseek		= UART_llseek,
		.read		= UART_read,
		.write		= UART_write,
		.poll		= UART_poll,
		.open		= UART_open,
		.release	= UART_release
};

/**
 * @brief Viene chiamata automaticamente all'inserimento del modulo.
 *
 * @param pdev struttura che astrae al kernel il platform_device associato al nostro dispositivo
 */
static int UART_probe(struct platform_device *pdev) {
	int ret = 0;
	UART *UART_ptr = NULL;
	printk(KERN_INFO "Chiamata %s\n", __func__);

	if (device_list == NULL) {

		if ((device_list = kmalloc(sizeof(UART_list), GFP_KERNEL)) == NULL ) {
			printk(KERN_ERR "%s: kmalloc ha restituito NULL\n", __func__);
			return -ENOMEM;
		}

		if ((ret = UART_list_Init(device_list, MAX_NUM_OF_DEVICES)) != 0) {
			printk(KERN_ERR "%s: UART_list_Init() ha restituito %d\n", __func__, ret);
			kfree(device_list);
			device_list = NULL;
			return ret;
		}

		if ((UART_class = class_create(THIS_MODULE, DRIVER_NAME) ) == NULL) {
			printk(KERN_ERR "%s: class_create() ha restituito NULL\n", __func__);
			kfree(device_list);
			device_list = NULL;
			return -ENOMEM;
		}
	}

/* Allocazione dell'oggetto UART */
	if ((UART_ptr = kmalloc(sizeof(UART), GFP_KERNEL)) == NULL) {
		printk(KERN_ERR "%s: kmalloc ha restituito NULL\n", __func__);
		return -ENOMEM;
	}

	if ((ret = UART_Init(	UART_ptr,
								THIS_MODULE,
								pdev,
								UART_class,
								DRIVER_NAME,
								DRIVER_FNAME,
								UART_list_device_count(device_list),
								&UART_fops,
								(irq_handler_t) UART_irq_handler)) != 0) {
		printk(KERN_ERR "%s: UART_Init() ha restituito %d\n", __func__, ret);
		kfree(UART_ptr);
		return ret;
	}

	UART_list_add(device_list, UART_ptr);

	printk(KERN_INFO "\t%s => %s%d\n", pdev->name, DRIVER_NAME, UART_list_device_count(device_list)-1);

	return ret;
}

/**
 * @breif Viene chiamata automaticamente alla rimozione del modulo.
 *
 * @param pdev struttura che astrae al kernel il platform_device associato al nostro dispositivo
 *
 * @retval 0 se non si verifica nessun errore
 *
 * @details
 * Dealloca tutta la memoria utilizzata dal driver, de-inizializzando il device e disattivando gli interrupt per il
 * device, effettuando tutte le operazioni inverse della funzione UART_probe().
 */
static int UART_remove(struct platform_device *pdev) {
	UART *UART_ptr = NULL;

	printk(KERN_INFO "Chiamata %s\n\tptr: %08x\n\tname: %s\n\tid: %u\n", __func__, (uint32_t) pdev, pdev->name, pdev->id);

	UART_ptr = UART_list_find_by_pdev(device_list, pdev);
	if (UART_ptr != NULL) {
		UART_Destroy(UART_ptr);
		kfree(UART_ptr);
	}

	if (UART_list_device_count(device_list) == 0) {
		UART_list_Destroy(device_list);
		kfree(device_list);
		class_destroy(UART_class);
	}

	return 0;
}

/**
 * @brief Invocata all'apertura del file corrispondente al device.
 *
 * @param inode struttura dati sul file system che archivia e descrive attributi base su file, directory o qualsiasi altro oggetto
 * @param file_ptr puntatore al descrittore file del device
 *
 * @retval 0 se non si verifica nessun errore
 *
 */
static int UART_open(struct inode *inode, struct file *file_ptr) {
	UART *UART_ptr;
	printk(KERN_INFO "Chiamata %s\n", __func__);

	printk(KERN_INFO "%s\n\tminor : %d", __func__, MINOR(inode->i_cdev->dev));
	
	if ((UART_ptr = UART_list_find_by_minor(device_list, inode->i_cdev->dev)) == NULL) {
		printk(KERN_INFO "%s: UART_list_find_by_minor() ha restituito NULL\n", __func__);
		return -1;
	}

	if(UART_ptr->buffer_tx != NULL)
		kfree(UART_ptr->buffer_tx);
	
	if(UART_ptr->buffer_rx != NULL)
		kfree(UART_ptr->buffer_rx);
	
	UART_ptr->buffer_tx = (uint8_t *) kmalloc(sizeof(uint8_t), GFP_KERNEL);
	if (UART_ptr->buffer_tx == NULL ) {
		printk(KERN_ERR "%s: kmalloc return NULL\n", __func__);
		return -ENOMEM;
	}

	UART_ptr->buffer_rx = (uint8_t *) kmalloc(sizeof(uint8_t), GFP_KERNEL);
	if (UART_ptr->buffer_rx == NULL ) {
		printk(KERN_ERR "%s: kmalloc return NULL\n", __func__);
		return -ENOMEM;
	}
	
	file_ptr->private_data = UART_ptr;
	return 0;
}

/**
 * @brief Invocata alla chiusura del file corrispondente al device.
 *
 * @param inode struttura dati sul file system che archivia e descrive attributi base su file, directory o qualsiasi altro oggetto
 * @param file_ptr puntatore al descrittore file del device
 *
 * @retval 0 se non si verifica nessun errore
 */
static int UART_release(struct inode *inode, struct file *file_ptr) {
	file_ptr->private_data = NULL;
	printk(KERN_INFO "Chiamata %s\n", __func__);
	return 0;
}

/**
 * @brief Implementa le system-call lseek() e llseek().
 *
 * @param file_ptr puntatore al descrittore file del device
 * @param off offset da aggiungere al parametro whence per il posizionamento
 * @param whence può assumere i valori SEEK_SET, SEEK_CUR o SEEK_END per specificare
 *        rispettivamente il riferimento dall'inizio file, dalla posizione corrente o dalla fine.
 *
 * @return Nuova posizione della "testina" di lettura/scrittura
 */
static loff_t UART_llseek (struct file *file_ptr, loff_t off, int whence) {
	UART *UART_dev_ptr;
    loff_t newpos;
	printk(KERN_INFO "Chiamata %s\n", __func__);
	UART_dev_ptr = file_ptr->private_data;
    switch(whence) {
      case 0: /* SEEK_SET */
        newpos = off;
        break;
      case 1: /* SEEK_CUR */
        newpos = file_ptr->f_pos + off;
        break;
      case 2: /* SEEK_END */
        newpos = UART_dev_ptr->res_size + off;
        break;
      default:
        return -EINVAL;
    }
    if (newpos < 0)
    	return -EINVAL;
    file_ptr->f_pos = newpos;
    return newpos;
}

/**
 * @brief Verifica che le operazioni di lettura risultino non-bloccanti.
 *
 * @param device puntatore a struttura UART, che si riferisce al device su cui operare
 * @param file_ptr puntatore al descrittore file del device
 * @param wait puntatore alla struttura poll_table
 *
 * @return maschera di bit che indica se sia possibile effettuare
 * operazioni di lettura non bloccanti.
 *
 * @details
 * Back-end di tre diverse sys-calls: poll, epoll e select,
 */
static unsigned int UART_poll (struct file *file_ptr, struct poll_table_struct *wait) {
	UART *UART_dev;
	unsigned int mask;
	printk(KERN_INFO "Chiamata %s\n", __func__);
	UART_dev = file_ptr->private_data;
	UART_InterruptEnable(UART_dev, RX);
	mask = UART_GetPollMask(UART_dev, file_ptr, wait);
	return mask;
}

/**
 * @brief Interrupt-handler chiamato alla ricezione di un'interruzione sulla linea al quale è stato registrato
 *
 * @param irq Interrupt-number a cui il device è connesso 
 * @param regs registri sullo stack alla system call entry
 *
 * @retval IRQ_HANDLED dopo aver servito l'interruzione
 *
 */
static irqreturn_t UART_irq_handler(int irq, struct pt_regs * regs) {

	UART *UART_dev_ptr = NULL;
	uint32_t reg_sent_data;
	uint32_t pending_reg;
	
	printk(KERN_INFO "Chiamata %s\n\tline: %d\n", __func__, irq);
	
	if ((UART_dev_ptr = UART_list_find_irq_line(device_list, irq)) == NULL) {
		printk(KERN_INFO "%s\n\tUART_list_find_irq_line() restituisce NULL:\n", __func__);
		return IRQ_NONE;
	}
		
/* Disabilitazione delle interruzioni della periferica */	
	UART_GlobalInterruptDisable(UART_dev_ptr);	

	pending_reg = UART_PendingInterrupt(UART_dev_ptr);
	
	if((pending_reg & RX) == RX){
/*---ISR RX--- */
		
		UART_dev_ptr->buffer_rx[0] = UART_GetData(UART_dev_ptr);
		printk(KERN_INFO"ISR RX - value received: %c\n", UART_dev_ptr->buffer_rx[0]);
						
/* Setting del valore del flag "can_read" */
		UART_SetCanRead(UART_dev_ptr);

/* Risveglio dei processi sleeping */
		UART_GlobalInterruptEnable(UART_dev_ptr);
		UART_RXInterruptAck(UART_dev_ptr);
		UART_ReadPollWakeUp(UART_dev_ptr);
		
	}
	else if((pending_reg & TX) == TX){
/*---ISR TX--- */
		
		iowrite32(0x00000000, (UART_dev_ptr->vrtl_addr + TX_EN));
		
		reg_sent_data = ioread32(UART_dev_ptr->vrtl_addr + DATA_IN);
		printk(KERN_INFO"ISR TX - sent value: %c\n", reg_sent_data);
				
/* Setting del valore del flag "can_write" */
		UART_SetCanWrite(UART_dev_ptr);
		
			
/* Risveglio dei processi sleeping */
		UART_TXInterruptAck(UART_dev_ptr);
		UART_GlobalInterruptEnable(UART_dev_ptr);
		UART_WriteWakeUp(UART_dev_ptr);
		}
		
	return IRQ_HANDLED;
	
}

/**
 * @brief Utilizzata per effettuare la ricezione di un carattere tramite il nostro device UART.
 *        Se non è presente un nuovo carattere da leggere il processo si mette il sleep per poi
 *        essere successivamente risvegliato dalla ISR all'avvenuto completamento della ricezione
 *
 * @param file_ptr puntatore al descrittore file del device
 * @param buf puntatore all'area di memoria dove verranno copiati i count bytes letti
 * @param count numeri di bytes da trasferire
 * @param off long offset type che indica la posizione alla quale si sta effettuando l'accesso
 *
 * @note l'aggiunta del flag O_NONBLOCK all'apertura del file descriptor associato al device farà sì che
 *       il processo chiamante non verrà bloccato se alla chiamata di una lettura non troverà dati disponibili
 */
static ssize_t UART_read (struct file *file_ptr, char *buf, size_t count, loff_t *off) {
	UART *UART_dev_ptr;
	void* read_addr;
	printk(KERN_INFO "Chiamata %s\n", __func__);
	
	UART_dev_ptr = file_ptr->private_data;
	if (*off > UART_dev_ptr->res_size)
		return -EFAULT;

	UART_InterruptEnable(UART_dev_ptr, RX);
	
	if ((file_ptr->f_flags & O_NONBLOCK) == 0) {
		printk(KERN_INFO "%s è bloccante\n", __func__);

/* Test della variabile "can_read", se non sono state rilevate iterruzioni e il flag O_NONBLOCK non è stato specificato il processo si mette il sleep */
		UART_TestCanReadAndSleep(UART_dev_ptr);
		
/* Il processo è risvegliato dall'arrivo di un'interruzione	*/
		UART_ResetCanRead(UART_dev_ptr);
	}
	else {
		printk(KERN_INFO "%s non è bloccante\n", __func__);
	}
/* Accesso ai registri del device */
	read_addr = UART_GetDeviceAddress(UART_dev_ptr)+*off;
	printk(KERN_INFO "%s risvegliata \n", __func__);
	
/* Copia dei dati letti verso l'userspace */
	if (copy_to_user(buf, UART_dev_ptr->buffer_rx, count))
		return -EFAULT;

	UART_GlobalInterruptEnable(UART_dev_ptr);
	UART_InterruptDisable(UART_dev_ptr, RX);
	
	return count;
}

/**
 * @brief Utilizzata per effettuare una trasmissione di un carattere tramite il nostro device UART.
 *        Se ancora non è terminata la precedente trasmissione il processo si mette il sleep per poi
 *        essere successivamente risvegliato dalla ISR all'avvenuto completamento della trasmissione.
 *
 * @param file_ptr puntatore al descrittore file del device
 * @param buf puntatore all'area di memoria dalla quale verranno copiati i count bytes 
 * @param count numeri di bytes da trasferire
 * @param off long offset type che indica la posizione alla quale si sta effettuando l'accesso
 *
 */
static ssize_t UART_write (struct file *file_ptr, const char __user * buf, size_t count, loff_t * off) {

	char * my_int_uart_phrase;
	UART *UART_dev_ptr;
	
	printk(KERN_INFO "Chiamata %s\n", __func__);
	
	UART_dev_ptr = file_ptr->private_data;
	if (*off > UART_dev_ptr->res_size)
		return -EFAULT;
	
	UART_InterruptEnable(UART_dev_ptr, TX);
	
/* Test della variabile "can_write" */
	UART_TestCanWriteAndSleep(UART_dev_ptr);
/* Il processo è risvegliato dall'arrivo di un'interruzione che indica la possibilità di effettuare una scrittura */
	UART_ResetCanWrite(UART_dev_ptr);
	
	if ((my_int_uart_phrase = kmalloc(sizeof(char)*count, GFP_KERNEL)) == NULL ) {
		printk(KERN_ERR "%s: kmalloc return NULL\n", __func__);
		return -ENOMEM;
	}

	if (copy_from_user(my_int_uart_phrase, buf, count))
		return -EFAULT;

	UART_dev_ptr->buffer_tx[0] = my_int_uart_phrase[0];								  
		
	printk(KERN_INFO"Write sending value: %c", UART_dev_ptr->buffer_tx[0]);
	
	UART_SetData(UART_dev_ptr, UART_dev_ptr->buffer_tx[0]);
	UART_Start(UART_dev_ptr);
	
	kfree(my_int_uart_phrase);
	
	UART_GlobalInterruptEnable(UART_dev_ptr);
	//UART_InterruptDisable(UART_dev_ptr, TX);
	
	return count;
}

/**
 * @brief Definisce le funzioni probe() e remove() da chiamare al caricamento del driver.
 */
static struct platform_driver UART_driver = {
	.driver = {
				.name = DRIVER_NAME,
				.owner = THIS_MODULE,
				.of_match_table = of_match_ptr(__test_int_driver_id),
		},	
	.probe = UART_probe,
	.remove = UART_remove	
};

/**
 * @brief la macro module_platform_driver() prende in input la struttura platform_driver ed implementa le
 * funzioni module_init() e module_close() standard, chiamate quando il modulo viene caricato o
 * rimosso dal kernel.
 *
 * @param UART_driver struttura platform_driver associata al driver
 */
module_platform_driver(UART_driver);

MODULE_LICENSE("GPL");
