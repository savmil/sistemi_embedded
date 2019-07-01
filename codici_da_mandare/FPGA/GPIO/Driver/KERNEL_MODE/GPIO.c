#include "GPIO.h"
#include <linux/slab.h>
#include <linux/sched.h>
#include <linux/poll.h>
#include <linux/module.h>

MODULE_LICENSE("GPL");
/**
 * @file           : GPIO.c
 * @brief          permette la gestione del singolo GPIO
*/
/**
 * @brief Inizializza una struttura GPIO per il corrispondente device
 *
 * @param 	GPIO_device puntatore a struttura GPIO, corrispondente al device su cui operare
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
int GPIO_Init(		GPIO* GPIO_device,
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
	
	GPIO_device->pdev = pdev;
	GPIO_device->class = class;
		
/** Alloca un range di Mj e min numbers per il device a caratteri */	
	
	if ((error = alloc_chrdev_region(&GPIO_device->Mm, 0 , 1, file_name)) != 0) {
		printk(KERN_ERR "%s: alloc_chrdev_region() ha restituito %d\n", __func__, error);
		return error;
	}

/** Inizializza la struttura cdev specificando la struttura file operations associata al device a caratteri */

	cdev_init (&GPIO_device->cdev, f_ops);
	GPIO_device->cdev.owner = owner;

/** Crea il device all'interno del filesystem assegnandogli i numbers richiesti in precedenza e ne restituisce il puntatore. */
	
	if ((GPIO_device->dev = device_create(class, NULL, GPIO_device->Mm, NULL, file_name)) == NULL) {
		printk(KERN_ERR "%s: device_create() ha restituito NULL\n", __func__);
		error = -ENOMEM;
		goto device_create_error;
	}
	
/** Aggiunge il device a caratteri al sistema. Se l'operazione va a buon fine sarà possibile vedere il device sotto /dev */

	
	if ((error = cdev_add(&GPIO_device->cdev, GPIO_device->Mm, 1)) != 0) {
		printk(KERN_ERR "%s: cdev_add() ha restituito %d\n", __func__, error);
		goto cdev_add_error;
	}

/** Inizializza la struct resource con il valori recuperati dal device tree corrispondente al device */

	dev = &pdev->dev;
	if ((error = of_address_to_resource(dev->of_node, 0, &GPIO_device->res)) != 0) {
		printk(KERN_ERR "%s: address_to_resource() ha restituito %d\n", __func__, error);
		goto of_address_to_resource_error;
	}
	GPIO_device->res_size = GPIO_device->res.end - GPIO_device->res.start + 1;

/** Alloca una quantita res_size di memoria fisica per il dispositivo IO a partire dall'inidirzzo res.start e ne resituisce l'inidirizzo */	
	
	if ((GPIO_device->mreg = request_mem_region(GPIO_device->res.start, GPIO_device->res_size, file_name)) == NULL) {
		printk(KERN_ERR "%s: request_mem_region() ha restituito NULL\n", __func__);
		error = -ENOMEM;
		goto request_mem_region_error;
	}

/** Mappa la memoria fisca allocata e restituisce l'indirizzo virtuale */
	
	if ((GPIO_device->vrtl_addr = ioremap(GPIO_device->res.start, GPIO_device->res_size))==NULL) {
		printk(KERN_ERR "%s: ioremap() ha restituito NULL\n", __func__);
		error = -ENOMEM;
		goto ioremap_error;
	}

/** Cerca le specifiche dell'interrupt nel device tree e restituisce il suo numero identificativo */

	GPIO_device->irqNumber = irq_of_parse_and_map(dev->of_node, 0);
	if ((error = request_irq(GPIO_device->irqNumber , irq_handler, 0, file_name, NULL)) != 0) {
		printk(KERN_ERR "%s: request_irq() ha restituito %d\n", __func__, error);
		goto irq_of_parse_and_map_error;
	}
	GPIO_device->irq_mask = irq_mask;

	
		
/** Inizializzazione della wait-queue per la system-call read() e poll() */
	
 	init_waitqueue_head(&GPIO_device->read_queue);
	init_waitqueue_head(&GPIO_device->poll_queue);
	
/** Inizializzazione degli spinlock */
	
	spin_lock_init(&GPIO_device->slock_int);
	GPIO_device->can_read = 0;
/** Abilitazione degli interrupt del device */
	
 	GPIO_GlobalInterruptEnable(GPIO_device);
	GPIO_PinInterruptEnable(GPIO_device, GPIO_device->irq_mask);
	goto no_error;

	irq_of_parse_and_map_error:
		iounmap(GPIO_device->vrtl_addr);
	ioremap_error:
		release_mem_region(GPIO_device->res.start, GPIO_device->res_size);
	request_mem_region_error:
	of_address_to_resource_error:
	cdev_add_error:
		device_destroy(GPIO_device->class, GPIO_device->Mm);
	device_create_error:
		cdev_del(&GPIO_device->cdev);
		unregister_chrdev_region(GPIO_device->Mm, 1);
	
no_error:
	
	printk(KERN_INFO " IRQ registered as %d\n", GPIO_device->irqNumber);	
	printk(KERN_INFO " Driver succesfully probed at Virtual Address 0x%08lx\n", (unsigned long) GPIO_device->vrtl_addr);
	
	return error;
}

/**
 * @brief Rimuove un device GPIO con le relative strutture kernel allocate per il suo funzionamento
 *
 * @param device puntatore a struttura GPIO che indica l'istanza GPIO da rimuovere
 */
void GPIO_Destroy(GPIO* device) {
	
	GPIO_GlobalInterruptDisable(device);
	GPIO_PinInterruptDisable(device, device->irq_mask);

	free_irq(device->irqNumber, NULL);
	iounmap(device->vrtl_addr);
	release_mem_region(device->res.start, device->res_size);
	device_destroy(device->class, device->Mm);
	cdev_del(&device->cdev);
	unregister_chrdev_region(device->Mm, 1);
	
}

/**
* @brief Utilizzata per asserire il flag "can_read" di uno specifico device GPIO
*
* @param device puntatore a struttura GPIO, device su cui operare
*/

void GPIO_SetCanRead(GPIO* device) {
	unsigned long flags;
	spin_lock_irqsave(&device->slock_int, flags);
	device-> can_read = 1;
	spin_unlock_irqrestore(&device->slock_int, flags);
}

/**
 * @brief Utilizzata per resettare il flag "can_read" di uno specifico device GPIO
 *
 * @param device puntatore a struttura GPIO, che si riferisce al device su cui operare
 */
 
void GPIO_ResetCanRead(GPIO* device) {
	unsigned long flags;
	spin_lock_irqsave(&device->slock_int, flags);
	device-> can_read = 0;
	spin_unlock_irqrestore(&device->slock_int, flags);
}

/**
 * @brief Testa il valore del flag "can_read". Se è uguale a 0, ovvero non è possibile effettuare
 * una lettura, mette in sleep il processo
 *
 * @param device puntatore a struttura GPIO, che si riferisce al device su cui operare
 */

void GPIO_TestCanReadAndSleep(GPIO* device) {
	wait_event_interruptible(device->read_queue, (device->can_read != 0));
}

/**
 * @brief Verifica che le operazioni di lettura risultino non-bloccanti.
 *
 * @param device puntatore a struttura GPIO, che si riferisce al device su cui operare
 * @param file puntatore al descrittore file del device
 * @param wait puntatore alla struttura poll_table
 *
 * @return maschera di bit che indica se sia possibile effettuare
 * operazioni di lettura non bloccanti.
 *
 * @details
 * Back-end di tre diverse sys-calls: poll, epoll e select,
 */
unsigned GPIO_GetPollMask(GPIO *device, struct file *file_ptr, struct poll_table_struct *wait) {
	unsigned mask = 0;
	poll_wait(file_ptr, &device->poll_queue,  wait);
	spin_lock(&device->slock_int);
	printk(KERN_INFO "%s called, can_read = %d",__func__, device->can_read);
	if(device->can_read)
		mask = POLLIN | POLLRDNORM;
	spin_unlock(&device->slock_int);
	return mask;
}

/**
 * @brief Risveglia i processi in attesa sulle code di read e poll.
 *
 * @param device puntatore a struttura GPIO, che si riferisce al device su cui operare
 */
 
void GPIO_WakeUp(GPIO* device) {
	wake_up_interruptible(&device->read_queue);
	wake_up_interruptible(&device->poll_queue);
}

/**
 * @brief Restituisce l'indirizzo virtuale di memoria cui è mappato un device
 *
 * @param device puntatore a struttura GPIO, che si riferisce al device su cui operare
 */
extern void* GPIO_GetDeviceAddress(GPIO* device) {
	return device->vrtl_addr;
}

/**
 * @brief Abilitazione interrupt globali;
 *
 * @param device puntatore a struttura GPIO, che si riferisce al device su cui operare
 */
void GPIO_GlobalInterruptEnable(GPIO* device) {
	iowrite32(1, (device->vrtl_addr + GLOBAL_INTR_EN));
}

/**
 * @brief Disabilitazione interrupt globali;
 *
 * @param device puntatore a struttura GPIO, che si riferisce al device su cui operare
 */
void GPIO_GlobalInterruptDisable(GPIO* device) {
	iowrite32(0, (device->vrtl_addr + GLOBAL_INTR_EN));
}

/**
 * @brief Abilitazione interrupt per i singoli pin del device.
 *
 * @param device puntatore a struttura GPIO, che si riferisce al device su cui operare
 * @param mask maschera di selezione degli interrupt da abilitare
 */
void GPIO_PinInterruptEnable(GPIO* device, unsigned mask) {
	unsigned reg_value = ioread32((device->vrtl_addr + INTR_EN));
	reg_value |= mask;
	iowrite32(reg_value, (device->vrtl_addr + INTR_EN));
}

/**
 * @brief Disabilitazione interrupt per i singoli pin del device.
 *
 * @param device puntatore a struttura GPIO, che si riferisce al device su cui operare
 *
 * @param mask maschera di selezione degli interrupt da disabilitare
 */
void GPIO_PinInterruptDisable(GPIO* device, unsigned mask) {
	unsigned reg_value = ioread32((device->vrtl_addr + INTR_EN));
	reg_value &= ~mask;
	iowrite32(reg_value, (device->vrtl_addr + INTR_EN));
}

/**
 * @brief Fornisce una maschera che indica quali interrupt non sono ancora stati serviti
 *		  e che quindi risultano pending.
 * @param device puntatore a struttura GPIO, che si riferisce al device su cui operare
 *
 * @return maschera riportante i pin per i quali gli interrupt non sono stati ancora serviti
 */
unsigned GPIO_PendingPinInterrupt(GPIO* device) {
	return ioread32((device->vrtl_addr + INTR_ACK_PEND));
}

/**
 * @brief Invia al device notifica di servizio di un interrupt;
 *
 * @param device puntatore a struttura GPIO, che si riferisce al device su cui operare
 *
 * @param mask maschera di selezione degli interrupt da notificare
 */
void GPIO_PinInterruptAck(GPIO* device, unsigned mask) {
	iowrite32(mask, (device->vrtl_addr + INTR_ACK_PEND));
	iowrite32(0, (device->vrtl_addr + INTR_ACK_PEND));
}

