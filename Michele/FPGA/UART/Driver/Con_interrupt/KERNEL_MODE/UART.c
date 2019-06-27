#include "UART.h"
#include <linux/slab.h>
#include <linux/delay.h>
#include <linux/sched.h>
#include <linux/poll.h>
#include <linux/module.h>

MODULE_LICENSE("GPL");

/**
 * @brief Inizializza una struttura UART per il corrispondente device
 *
 * @param 	UART_device puntatore a struttura UART, corrispondente al device su cui operare
 * @param 	owner puntatore a struttura struct module, proprietario del device (THIS_MODULE)
 * @param 	pdev puntatore a struct platform_device
 * @param 	driver_name nome del driver
 * @param 	device_name nome del device
 * @param 	serial numero seriale del device
 * @param 	f_ops puntatore a struttura struct file_operations, specifica le funzioni che agiscono sul device
 * @param 	irq_handler puntatore irq_handler_t alla funzione che gestisce gli interrupt generati dal device
 * @param 	irq_mask maschera delle interruzioni attive del device
 *
 * @retval "0" se non si è verificato nessun errore
 *
 * @details
 */
int UART_Init(		UART* UART_device,
					struct module *owner,
					struct platform_device *pdev,
					struct class*  class,
					const char* driver_name,
					const char* device_name,
					uint32_t serial,
					struct file_operations *f_ops,
					irq_handler_t irq_handler,
					uint32_t irq_mask) {
	int error = 0;
	struct device *dev = NULL;

	char *file_name = kmalloc(strlen(driver_name) + 5, GFP_KERNEL);
	sprintf(file_name, device_name, serial);
	
	UART_device->pdev = pdev;
	UART_device->class = class;
		
	//genera Mj e min number
	if ((error = alloc_chrdev_region(&UART_device->Mm, 0 , 1, file_name)) != 0) {
		printk(KERN_ERR "%s: alloc_chrdev_region() ha restituito %d\n", __func__, error);
		return error;
	}
	
	//registra il file operation sul device a caratteri
	cdev_init (&UART_device->cdev, f_ops);
	UART_device->cdev.owner = owner;
	
	//Crea il device all'interno del filesystem assegnandogli il Mj e ne restituisce il puntatore.
	if ((UART_device->dev = device_create(class, NULL, UART_device->Mm, NULL, file_name)) == NULL) {
		printk(KERN_ERR "%s: device_create() ha restituito NULL\n", __func__);
		error = -ENOMEM;
		goto device_create_error;
	}
	
	//fa uscire il device sotto /dev/
	if ((error = cdev_add(&UART_device->cdev, UART_device->Mm, 1)) != 0) {
		printk(KERN_ERR "%s: cdev_add() ha restituito %d\n", __func__, error);
		goto cdev_add_error;
	}
	
	//inizializza la risorsa con il valori presi dal device tree andando a recuperare gli indirizzi fisici del nodo
	//parametro of_node è il device tree associato al nodo
	dev = &pdev->dev;
	if ((error = of_address_to_resource(dev->of_node, 0, &UART_device->res)) != 0) {
		printk(KERN_ERR "%s: address_to_resource() ha restituito %d\n", __func__, error);
		goto of_address_to_resource_error;
	}
	UART_device->res_size = UART_device->res.end - UART_device->res.start + 1;
	
	//alloco una quantita res_size di memoria fisica per il dispositivo IO a partire dall'inidirzzo res.start e resituisce l'inidirizzo
	if ((UART_device->mreg = request_mem_region(UART_device->res.start, UART_device->res_size, file_name)) == NULL) {
		printk(KERN_ERR "%s: request_mem_region() ha restituito NULL\n", __func__);
		error = -ENOMEM;
		goto request_mem_region_error;
	}
	
	//mappa la memoria fisca allocata e mi restituisce l'inidizzo virtuale
	if ((UART_device->vrtl_addr = ioremap(UART_device->res.start, UART_device->res_size))==NULL) {
		printk(KERN_ERR "%s: ioremap() ha restituito NULL\n", __func__);
		error = -ENOMEM;
		goto ioremap_error;
	}
	
	
	//mappa e si fa resituire il numero
	UART_device->irqNumber = irq_of_parse_and_map(dev->of_node, 0);
	
	
	if ((error = request_irq(UART_device->irqNumber , irq_handler, 0, file_name, NULL)) != 0) {
		printk(KERN_ERR "%s: request_irq() ha restituito %d\n", __func__, error);
		goto irq_of_parse_and_map_error;
	}
	UART_device->irq_mask = irq_mask;

	
		
/** Inizializzazione della wait-queue per la system-call read() e poll() */
	
	init_waitqueue_head(&UART_device->write_queue);
 	init_waitqueue_head(&UART_device->read_queue);
	init_waitqueue_head(&UART_device->poll_queue);
	
/** Inizializzazione degli spinlock */
	
	spin_lock_init(&UART_device->slock_int);
	spin_lock_init(&UART_device->write_lock);
	
	UART_device->can_read = 0;
	UART_device->can_write = 1;

/** Abilitazione degli interrupt del device */
	
 	UART_GlobalInterruptEnable(UART_device);
	
	UART_InterruptEnable(UART_device, UART_device->irq_mask);
	
	goto no_error;

	irq_of_parse_and_map_error:
		iounmap(UART_device->vrtl_addr);
	ioremap_error:
		release_mem_region(UART_device->res.start, UART_device->res_size);
	request_mem_region_error:
	of_address_to_resource_error:
	cdev_add_error:
		device_destroy(UART_device->class, UART_device->Mm);
	device_create_error:
		cdev_del(&UART_device->cdev);
		unregister_chrdev_region(UART_device->Mm, 1);
	
no_error:
	
	printk(KERN_INFO " IRQ registered as %d\n", UART_device->irqNumber);	
	printk(KERN_INFO " Driver succesfully probed at Virtual Address 0x%08lx\n", (unsigned long) UART_device->vrtl_addr);
	
	return error;
}EXPORT_SYMBOL(UART_Init);

/**
 * @brief Rimuove un device UART con le relative strutture kernel allocate per il suo funzionamento
 *
 * @param device puntatore a struttura UART che indica l'istanza UART da rimuovere
 */
void UART_Destroy(UART* device) {
	
	UART_GlobalInterruptDisable(device);
	UART_InterruptDisable(device, device->irq_mask);

	free_irq(device->irqNumber, NULL);
	iounmap(device->vrtl_addr);
	release_mem_region(device->res.start, device->res_size);
	device_destroy(device->class, device->Mm);
	cdev_del(&device->cdev);
	unregister_chrdev_region(device->Mm, 1);
	
}EXPORT_SYMBOL(UART_Destroy);

/**
* @brief Utilizzata per asserire il flag "can_read" di uno specifico device UART
*
* @param device puntatore a struttura UART, device su cui operare
*/

void UART_SetCanRead(UART* device) {
	unsigned long flags;
	spin_lock_irqsave(&device->slock_int, flags);
	device-> can_read = 1;
	spin_unlock_irqrestore(&device->slock_int, flags);
}EXPORT_SYMBOL(UART_SetCanRead);


void UART_SetCanWrite(UART* device) {
	unsigned long flags;
	spin_lock_irqsave(&device->write_lock, flags);
	device-> can_write = 1;
	spin_unlock_irqrestore(&device->write_lock, flags);
}EXPORT_SYMBOL(UART_SetCanWrite);


/**
 * @brief Utilizzata per resettare il flag "can_read" di uno specifico device UART
 *
 * @param device puntatore a struttura UART, che si riferisce al device su cui operare
 */
 
void UART_ResetCanRead(UART* device) {
	unsigned long flags;
	spin_lock_irqsave(&device->slock_int, flags);
	device-> can_read = 0;
	spin_unlock_irqrestore(&device->slock_int, flags);
}EXPORT_SYMBOL(UART_ResetCanRead);



void UART_ResetCanWrite(UART* device) {
	unsigned long flags;
	spin_lock_irqsave(&device->write_lock, flags);
	device-> can_write = 0;
	spin_unlock_irqrestore(&device->write_lock, flags);
}EXPORT_SYMBOL(UART_ResetCanWrite);




/**
 * @brief Testa il valore del flag "can_read". Se è uguale a 0, ovvero non è possibile effettuare
 * una lettura, mette in sleep il processo
 *
 * @param device puntatore a struttura UART, che si riferisce al device su cui operare
 */

void UART_TestCanReadAndSleep(UART* device) {
	wait_event_interruptible(device->read_queue, (device->can_read != 0));
}EXPORT_SYMBOL(UART_TestCanReadAndSleep);


void UART_TestCanWriteAndSleep(UART* device) {
	wait_event_interruptible(device->write_queue, (device->can_write != 0));
}EXPORT_SYMBOL(UART_TestCanWriteAndSleep);


/**
 * @brief Verifica che le operazioni di lettura risultino non-bloccanti.
 *
 * @param device puntatore a struttura UART, che si riferisce al device su cui operare
 * @param file puntatore al descrittore file del device
 * @param wait puntatore alla struttura poll_table
 *
 * @return maschera di bit che indica se sia possibile effettuare
 * operazioni di lettura non bloccanti.
 *
 * @details
 * Back-end di tre diverse sys-calls: poll, epoll e select,
 */
unsigned UART_GetPollMask(UART *device, struct file *file_ptr, struct poll_table_struct *wait) {
	unsigned mask = 0;
	poll_wait(file_ptr, &device->poll_queue,  wait);
	spin_lock(&device->slock_int);
	printk(KERN_INFO "Poll, valore can_read = %d", device->can_read);
	if(device->can_read)
		mask = POLLIN | POLLRDNORM;
	spin_unlock(&device->slock_int);
	printk(KERN_INFO "Poll, ritorna mask = %d", mask);
	return mask;
}EXPORT_SYMBOL(UART_GetPollMask);

/**
 * @brief Risveglia i processi in attesa sulle code di read e poll.
 *
 * @param device puntatore a struttura UART, che si riferisce al device su cui operare
 */
 
void UART_ReadPollWakeUp(UART* device) {
	wake_up_interruptible(&device->read_queue);
	wake_up_interruptible(&device->poll_queue);
}EXPORT_SYMBOL(UART_ReadPollWakeUp);

void UART_WriteWakeUp(UART* device) {
	wake_up_interruptible(&device->read_queue);
	wake_up_interruptible(&device->poll_queue);
}EXPORT_SYMBOL(UART_WriteWakeUp);



/**
 * @brief Restituisce l'indirizzo virtuale di memoria cui è mappato un device
 *
 * @param device puntatore a struttura UART, che si riferisce al device su cui operare
 */
extern void* UART_GetDeviceAddress(UART* device) {
	return device->vrtl_addr;
}EXPORT_SYMBOL(UART_GetDeviceAddress);

/**
 * @brief Abilitazione interrupt globali;
 *
 * @param device puntatore a struttura UART, che si riferisce al device su cui operare
 */
void UART_GlobalInterruptEnable(UART* device) {
	iowrite32(1, (device->vrtl_addr + GLOBAL_INTR_EN));
}EXPORT_SYMBOL(UART_GlobalInterruptEnable);

/**
 * @brief Disabilitazione interrupt globali;
 *
 * @param device puntatore a struttura UART, che si riferisce al device su cui operare
 */
void UART_GlobalInterruptDisable(UART* device) {
	iowrite32(0, (device->vrtl_addr + GLOBAL_INTR_EN));
}EXPORT_SYMBOL(UART_GlobalInterruptDisable);

/**
 * @brief Abilitazione interrupt per i singoli pin del device.
 *
 * @param device puntatore a struttura UART, che si riferisce al device su cui operare
 * @param mask maschera di selezione degli interrupt da abilitare
 */
void UART_InterruptEnable(UART* device, unsigned mask) {
	unsigned reg_value = ioread32((device->vrtl_addr + INTR_EN));
	reg_value |= mask;
	iowrite32(reg_value, (device->vrtl_addr + INTR_EN));
}EXPORT_SYMBOL(UART_InterruptEnable);

/**
 * @brief Disabilitazione interrupt per i singoli pin del device.
 *
 * @param device puntatore a struttura UART, che si riferisce al device su cui operare
 *
 * @param mask maschera di selezione degli interrupt da disabilitare
 */
void UART_InterruptDisable(UART* device, unsigned mask) {
	unsigned reg_value = ioread32((device->vrtl_addr + INTR_EN));
	reg_value &= ~mask;
	iowrite32(reg_value, (device->vrtl_addr + INTR_EN));
}EXPORT_SYMBOL(UART_InterruptDisable);

/**
 * @brief Fornisce una maschera che indica quali interrupt non sono ancora stati serviti
 *		  e che quindi risultano pending.
 * @param device puntatore a struttura UART, che si riferisce al device su cui operare
 *
 * @return maschera riportante i pin per i quali gli interrupt non sono stati ancora serviti
 */
unsigned UART_PendingInterrupt(UART* device) {
	return ioread32((device->vrtl_addr + INTR_ACK_PEND));
}EXPORT_SYMBOL(UART_PendingInterrupt);

/**
 * @brief Invia al device notifica di servizio di un interrupt;
 *
 * @param device puntatore a struttura UART, che si riferisce al device su cui operare
 *
 * @param mask maschera di selezione degli interrupt da notificare
 */
void UART_TXInterruptAck(UART* device) {
	uint32_t mask = 0x00000001;
	iowrite32(mask, (device->vrtl_addr + INTR_ACK_PEND));
	iowrite32(0, (device->vrtl_addr + INTR_ACK_PEND));
}

void UART_RXInterruptAck(UART* device) {
	uint32_t mask = 0x00000002;
	iowrite32(mask, (device->vrtl_addr + INTR_ACK_PEND));
	iowrite32(0, (device->vrtl_addr + INTR_ACK_PEND));
}

void UART_SetData(UART* device, uint8_t dataToSend){
	
	iowrite32(dataToSend, (device->vrtl_addr + DATA_IN));

}

uint8_t UART_GetData(UART* device){
	
	return ioread32((device->vrtl_addr + RX_REG));

}

void UART_Start(UART* device){

	iowrite32(0x00000001, (device->vrtl_addr + TX_EN));

}