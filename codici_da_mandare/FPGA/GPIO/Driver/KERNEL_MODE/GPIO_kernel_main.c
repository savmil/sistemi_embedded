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

#include "GPIO_list.h"
/**
 * @file           : GPIO_kernel_main.c
 * @brief          modulo kernel che governa l' utilizzo del driver GPIO
*/
/**
 * @brief Nome identificativo del device-driver.
 * Deve corrispondere al valore del campo "compatible" nel device tree source.
 */
#define DRIVER_NAME "GPIO"

/**
 * @brief Nome del file creato sotto /dev/ per ciascun device
 */
#define DRIVER_FNAME "GPIO%d"

MODULE_AUTHOR("gruppo 3");
MODULE_DESCRIPTION("GPIO device-driver kernel mode");
MODULE_VERSION("1.0");

/**
 * @brief Numero massimo di device gestibili
 *
 * MAX_NUM_OF_DEVICES dimensione della struttura dati GPIO_list
 */
#define MAX_NUM_OF_DEVICES 10

/*
 * Funzioni implementate dal modulo
 */
static int 			GPIO_probe			(struct platform_device *op);
static int 			GPIO_remove			(struct platform_device *op);
static int 			GPIO_open			(struct inode *inode, struct file *file_ptr);
static int 			GPIO_release		(struct inode *inode, struct file *file_ptr);
static loff_t		GPIO_llseek			(struct file *file_ptr, loff_t off, int whence);
static unsigned int GPIO_poll			(struct file *file_ptr, struct poll_table_struct *wait);
static ssize_t 		GPIO_read			(struct file *file_ptr, char *buf, size_t count, loff_t *ppos);
static ssize_t 		GPIO_write 			(struct file *file_ptr, const char *buf, size_t size, loff_t *off);
static irqreturn_t	GPIO_irq_handler	(int irq, struct pt_regs * regs);

#define INTR_MASK		0xF //!< @brief Maschera di abilitazione degli interrupt per i singoli pin

static GPIO_list *device_list = NULL;

static struct class*  GPIO_class  = NULL;

/**
 * @brief Identifica il device all'interno del device tree
 *
 */
static const struct of_device_id __test_int_driver_id[]={
	{.compatible = "GPIO"},
	{}
};

/**
 * @brief Struttura che specifica le funzioni che agiscono sul device
 *
 */
static struct file_operations GPIO_fops = {
		.owner		= THIS_MODULE,
		.llseek		= GPIO_llseek,
		.read		= GPIO_read,
		.write		= GPIO_write,
		.poll		= GPIO_poll,
		.open		= GPIO_open,
		.release	= GPIO_release
};

/**
 * @brief Viene chiamata automaticamente all'inserimento del modulo.
 *
 * @param pdev struttura che astrae al kernel il platform_device associato al nostro dispositivo
 */
static int GPIO_probe(struct platform_device *pdev) {
	int ret = 0;
	GPIO *GPIO_ptr = NULL;
	printk(KERN_INFO "Chiamata %s\n", __func__);

	if (device_list == NULL) {

		if ((device_list = kmalloc(sizeof(GPIO_list), GFP_KERNEL)) == NULL ) {
			printk(KERN_ERR "%s: kmalloc ha restituito NULL\n", __func__);
			return -ENOMEM;
		}

		if ((ret = GPIO_list_Init(device_list, MAX_NUM_OF_DEVICES)) != 0) {
			printk(KERN_ERR "%s: GPIO_list_Init() ha restituito %d\n", __func__, ret);
			kfree(device_list);
			device_list = NULL;
			return ret;
		}

		if ((GPIO_class = class_create(THIS_MODULE, DRIVER_NAME) ) == NULL) {
			printk(KERN_ERR "%s: class_create() ha restituito NULL\n", __func__);
			kfree(device_list);
			device_list = NULL;
			return -ENOMEM;
		}
	}

/** Allocazione dell'oggetto GPIO */
	if ((GPIO_ptr = kmalloc(sizeof(GPIO), GFP_KERNEL)) == NULL) {
		printk(KERN_ERR "%s: kmalloc ha restituito NULL\n", __func__);
		return -ENOMEM;
	}

	if ((ret = GPIO_Init(	GPIO_ptr,
								THIS_MODULE,
								pdev,
								GPIO_class,
								DRIVER_NAME,
								DRIVER_FNAME,
								GPIO_list_device_count(device_list),
								&GPIO_fops,
								(irq_handler_t) GPIO_irq_handler,
								INTR_MASK)) != 0) {
		printk(KERN_ERR "%s: GPIO_Init() ha restituito %d\n", __func__, ret);
		kfree(GPIO_ptr);
		return ret;
	}

	GPIO_list_add(device_list, GPIO_ptr);

	printk(KERN_INFO "\t%s => %s%d\n", pdev->name, DRIVER_NAME, GPIO_list_device_count(device_list)-1);

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
 * device, effettuando tutte le operazioni inverse della funzione GPIO_probe().
 */
static int GPIO_remove(struct platform_device *pdev) {
	GPIO *GPIO_ptr = NULL;

	printk(KERN_INFO "Chiamata %s\n\tptr: %08x\n\tname: %s\n\tid: %u\n", __func__, (uint32_t) pdev, pdev->name, pdev->id);

	GPIO_ptr = GPIO_list_find_by_pdev(device_list, pdev);
	if (GPIO_ptr != NULL) {
		GPIO_Destroy(GPIO_ptr);
		kfree(GPIO_ptr);
	}

	if (GPIO_list_device_count(device_list) == 0) {
		GPIO_list_Destroy(device_list);
		kfree(device_list);
		class_destroy(GPIO_class);
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
static int GPIO_open(struct inode *inode, struct file *file_ptr) {
	GPIO *GPIO_ptr;
	printk(KERN_INFO "Chiamata %s\n", __func__);

	printk(KERN_INFO "%s\n\tminor : %d", __func__, MINOR(inode->i_cdev->dev));

	if ((GPIO_ptr = GPIO_list_find_by_minor(device_list, inode->i_cdev->dev)) == NULL) {
		printk(KERN_INFO "%s: GPIO_list_find_by_minor() ha restituito NULL\n", __func__);
		return -1;
	}

	file_ptr->private_data = GPIO_ptr;
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
static int GPIO_release(struct inode *inode, struct file *file_ptr) {
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
static loff_t GPIO_llseek (struct file *file_ptr, loff_t off, int whence) {
	GPIO *GPIO_dev_ptr;
    loff_t newpos;
	printk(KERN_INFO "Chiamata %s\n", __func__);
	GPIO_dev_ptr = file_ptr->private_data;
    switch(whence) {
      case 0: /* SEEK_SET */
        newpos = off;
        break;
      case 1: /* SEEK_CUR */
        newpos = file_ptr->f_pos + off;
        break;
      case 2: /* SEEK_END */
        newpos = GPIO_dev_ptr->res_size + off;
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
 * @param device puntatore a struttura GPIO, che si riferisce al device su cui operare
 * @param file_ptr puntatore al descrittore file del device
 * @param wait puntatore alla struttura poll_table
 *
 * @return maschera di bit che indica se sia possibile effettuare
 * operazioni di lettura non bloccanti.
 *
 * @details
 * Back-end di tre diverse sys-calls: poll, epoll e select,
 */
static unsigned int GPIO_poll (struct file *file_ptr, struct poll_table_struct *wait) {
	GPIO *GPIO_dev;
	unsigned int mask;
	printk(KERN_INFO "Chiamata %s\n", __func__);
	GPIO_dev = file_ptr->private_data;
	mask = GPIO_GetPollMask(GPIO_dev, file_ptr, wait);
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
static irqreturn_t GPIO_irq_handler(int irq, struct pt_regs * regs) {
	GPIO *GPIO_dev_ptr = NULL;
	printk(KERN_INFO "Chiamata %s\n\tline: %d\n", __func__, irq);
	printk(KERN_INFO"**********ISR***********");
	if ((GPIO_dev_ptr = GPIO_list_find_irq_line(device_list, irq)) == NULL) {
		printk(KERN_INFO "%s\n\tGPIO_list_find_irq_line() restituisce NULL:\n", __func__);
		return IRQ_NONE;
	}
	
/** Disabilitazione delle interruzioni della periferica */

	GPIO_GlobalInterruptDisable(GPIO_dev_ptr);
	GPIO_PinInterruptDisable(GPIO_dev_ptr, GPIO_dev_ptr->irq_mask);

/** Setting del valore del flag "can_read" */

	GPIO_SetCanRead(GPIO_dev_ptr);
	printk(KERN_INFO "funzione %s | valore can_read: %d\n", __func__, GPIO_dev_ptr->can_read);

/** Risveglio dei processi sleeping */

	GPIO_PinInterruptAck(GPIO_dev_ptr, GPIO_dev_ptr->irq_mask);
	GPIO_WakeUp(GPIO_dev_ptr);
	
	return IRQ_HANDLED;
}

/**
 * @brief Legge dati dal device.
 *
 * @param file_ptr puntatore al descrittore file del device
 * @param buf puntatore all'area di memoria dove verranno copiati i count bytes letti
 * @param count numeri di bytes da trasferire
 * @param off long offset type che indica la posizione alla quale si sta effettuando l'accesso
 *
 * @note l'aggiunta del flag O_NONBLOCK all'apertura del file descriptor associato al device farà sì che
 *       il processo chiamante non verrà bloccato se alla chiamata di una lettura non troverà dati disponibili
 */
static ssize_t GPIO_read (struct file *file_ptr, char *buf, size_t count, loff_t *off) {
	GPIO *GPIO_dev_ptr;
	void* read_addr;
	uint32_t data_readed;
	printk(KERN_INFO "Chiamata %s\n", __func__);
	GPIO_dev_ptr = file_ptr->private_data;
	if (*off > GPIO_dev_ptr->res_size)
		return -EFAULT;

	if ((file_ptr->f_flags & O_NONBLOCK) == 0) {
		printk(KERN_INFO "%s è bloccante\n", __func__);

/** Test della variabile "can_read", se non sono state rilevate iterruzioni e il flag O_NONBLOCK non è stato specificato il processo si mette il sleep */
		
		GPIO_TestCanReadAndSleep(GPIO_dev_ptr);
		
/** Il processo è risvegliato dall'arrivo di un'interruzione	*/
		
		GPIO_ResetCanRead(GPIO_dev_ptr);
	}
	else {
		printk(KERN_INFO "%s non è bloccante\n", __func__);
	}
/** Accesso ai registri del device */
	
	read_addr = GPIO_GetDeviceAddress(GPIO_dev_ptr)+*off;
	data_readed = ioread32(read_addr);
	printk(KERN_INFO "%s | read value: %08x\n", __func__, data_readed);
	
/** Copia dei dati letti verso l'userspace */
	
	if (copy_to_user(buf, &data_readed, count))
		return -EFAULT;

	GPIO_GlobalInterruptEnable(GPIO_dev_ptr);
	GPIO_PinInterruptEnable(GPIO_dev_ptr, GPIO_dev_ptr->irq_mask);
	
	return count;
}

/**
 * @brief Invia dati al device
 *
 * @param file_ptr puntatore al descrittore file del device
 * @param buf puntatore all'area di memoria dalla quale verranno copiati i count bytes 
 * @param count numeri di bytes da trasferire
 * @param off long offset type che indica la posizione alla quale si sta effettuando l'accesso
 *
 */
static ssize_t GPIO_write (struct file *file_ptr, const char *buf, size_t size, loff_t *off) {
	GPIO *GPIO_dev_ptr;
	uint32_t data_to_write;
	void* write_addr;
	printk(KERN_INFO "Chiamata %s\n", __func__);
	GPIO_dev_ptr = file_ptr->private_data;
	if (*off > GPIO_dev_ptr->res_size)
		return -EFAULT;
/** Copia dei dati dall'userspace */
	if (copy_from_user(&data_to_write, buf, size))
		return -EFAULT;
/** Accesso ai registri del device */
	write_addr = GPIO_GetDeviceAddress(GPIO_dev_ptr)+*off;
	iowrite32(data_to_write, write_addr);
	return size;
}

/**
 * @brief Definisce le funzioni probe() e remove() da chiamare al caricamento del driver.
 */
static struct platform_driver GPIO_driver = {
	.driver = {
				.name = DRIVER_NAME,
				.owner = THIS_MODULE,
				.of_match_table = of_match_ptr(__test_int_driver_id),
		},	
	.probe = GPIO_probe,
	.remove = GPIO_remove	
};

/**
 * @brief la macro module_platform_driver() prende in input la struttura platform_driver ed implementa le
 * funzioni module_init() e module_close() standard, chiamate quando il modulo viene caricato o
 * rimosso dal kernel.
 *
 * @param GPIO_driver struttura platform_driver associata al driver
 */
module_platform_driver(GPIO_driver);

MODULE_LICENSE("GPL");
