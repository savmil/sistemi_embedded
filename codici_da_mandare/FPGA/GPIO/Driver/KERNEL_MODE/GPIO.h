#ifndef __GPIO__
#define __GPIO__

#include <linux/device.h>
#include <linux/cdev.h>
#include <linux/fs.h>

#include <linux/interrupt.h>
#include <linux/irqreturn.h>
#include <linux/of_device.h>
#include <linux/of_platform.h>
#include <linux/of_address.h>
#include <linux/of_irq.h>

#include <linux/wait.h>
#include <linux/spinlock.h>

#include <asm/uaccess.h>
#include <asm/io.h>
/**
 * @file           : GPIO.h
 * @brief          header file GPIO.c
*/
/**
 * Offset dei vari registri interni del device GPIO
 **/

#define	DIR_OFF    	    0  // DIRECTION
#define	WRITE_OFF	    4  // WRITE
#define READ_OFF		8  // READ
#define GLOBAL_INTR_EN  12 // GLOBAL INTERRUPT ENABLE
#define INTR_EN         16 // LOCAL INTERRUPT ENABLE
#define INTR_ACK_PEND   28 // PENDING/ACK REGISTER

/**
 * @brief Stuttura che astrae un device GPIO in kernel-mode.
 * Contiene ciò che è necessario al funzionamento del driver.
 */
typedef struct {
/** Major e minor number associati al device (M: identifica il driver associato al device; m: utilizzato dal driver per discriminare il singolo device tra quelli a lui associati)*/
	dev_t Mm;
/** Puntatore a struttura platform_device cui l'oggetto GPIO si riferisce */
	struct platform_device *pdev;  	
/** Stuttura per l'astrazione di un device a caratteri */
	struct cdev cdev;	
/** Puntatore alla struttura che rappresenta l'istanza del device*/		  	
	struct device* dev;
/** Puntatore a struttura che rappresenta una vista alto livello del device*/			      
	struct class*  class;
/** Interrupt-number a cui il device è connesso*/		        
	uint32_t irqNumber; 
/** Puntatore alla regione di memoria cui il device è mappato*/		        
	struct resource *mreg;
/** Device Resource Structure*/		 	 
	struct resource res; 
/** Maschera delle interruzioni interne attive per il device*/              
	uint32_t irq_mask;
/** res.end - res.start; numero di indirizzi associati alla periferica.*/			 	 
	uint32_t res_size; 	
/** Indirizzo base virtuale della periferica*/	    	 
	void __iomem *vrtl_addr;
/** wait queue per la sys-call read() */	  	 
	wait_queue_head_t read_queue;
/** wait queue per la sys-call poll()*/
	wait_queue_head_t poll_queue;
/** Flag che indica, quando asserito, la possibilità di effettuale una chiamata a read*/   
	uint32_t can_read;
/** Spinlock usato per garantire l'accesso in mutua esclusione alla variabile can_read*/  
	spinlock_t slock_int;
} GPIO;

int GPIO_Init(				GPIO* GPIO_device,
							struct module *owner,
							struct platform_device *pdev,
					  		struct class*  class,
							const char* driver_name,
							const char* device_name,
							uint32_t serial,
							struct file_operations *f_pdevs,
							irq_handler_t irq_handler,
							uint32_t irq_mask);

void GPIO_Destroy(GPIO* device);

void GPIO_SetCanRead(GPIO* device);

void GPIO_ResetCanRead(GPIO* device);

void GPIO_TestCanReadAndSleep(GPIO* device);

unsigned GPIO_GetPollMask(GPIO *device, struct file *file_ptr, struct poll_table_struct *wait);

void GPIO_WakeUp(GPIO* device);

void* GPIO_GetDeviceAddress(GPIO* device);

void GPIO_GlobalInterruptEnable(GPIO* GPIO_device);

void GPIO_GlobalInterruptDisable(GPIO* GPIO_device);

void GPIO_PinInterruptEnable(GPIO* GPIO_device, unsigned mask);

void GPIO_PinInterruptDisable(GPIO* GPIO_device, unsigned mask);

unsigned GPIO_PendingPinInterrupt(GPIO* GPIO_device);

void GPIO_PinInterruptAck(GPIO* GPIO_device, unsigned mask);

#endif
