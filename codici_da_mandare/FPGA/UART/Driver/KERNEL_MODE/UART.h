#ifndef __UART__
#define __UART__

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
 * @brief Offset dei vari registri interni del device UART
 **/

#define	DATA_IN   		0	// DATA TO SEND
#define	TX_EN	        4	// TRANSFER ENABLE (0)
#define	STATUS_REG      8   // OE(0) FE(1) DE(2) RDA(3) TX_BUSY(4) 
#define	RX_REG	        12 	// DATA RECEIVED
#define GLOBAL_INTR_EN  16 	// GLOBAL INTERRUPT ENABLE
#define INTR_EN         20 	// LOCAL INTERRUPT ENABLE
#define INTR_ACK_PEND   28 	// PENDING/ACK REGISTER

/**
 * @brief Stuttura che astrae un device UART in kernel-mode.
 * Contiene ciò che è necessario al funzionamento del driver.
 */
typedef struct {
	dev_t Mm;					  		// 	Major e minor number associati al device (M: identifica il driver associato al device; m: utilizzato dal driver per discriminare il singolo device tra quelli a lui associati)
	struct platform_device *pdev; 		//	Puntatore a struttura platform_device cui l'oggetto UART si riferisce 
	struct cdev cdev;			  		//	Stuttura per l'astrazione di un device a caratteri 
	struct device* dev;			  		//  Puntatore alla struttura che rappresenta l'istanza del device  
	struct class*  class;		  		//  Puntatore a struttura che rappresenta una vista alto livello del device  
	uint32_t irqNumber; 		  		// 	Interrupt-number a cui il device è connesso 
	struct resource *mreg;		  		//	Puntatore alla regione di memoria cui il device è mappato
	struct resource res;          		//  Device Resource Structure 
	uint32_t irq_mask;			  		//	Maschera delle interruzioni interne attive per il device 
	uint32_t res_size; 		      		//	res.end - res.start; numero di indirizzi associati alla periferica. 
	void __iomem *vrtl_addr; 	  		//	Indirizzo base virtuale della periferica 
	wait_queue_head_t read_queue; 		//  wait queue per la sys-call read() 				
	wait_queue_head_t poll_queue; 		// 	wait queue per la sys-call poll() 
	wait_queue_head_t write_queue;		// 	wait queue per la sys-call write() 
	uint32_t can_read;			 		// 	Flag che indica, quando asserito, la possibilità di effettuale una chiamata a read
	uint32_t can_write;					// 	Flag che indica, quando asserito, la possibilità di effettuale una chiamata a write
	spinlock_t slock_int;        		//  Spinlock usato per garantire l'accesso in mutua esclusione alla variabile can_read
	spinlock_t write_lock;				//  Spinlock usato per garantire l'accesso in mutua esclusione alla variabile can_write
	uint8_t * buffer_tx;				//  Buffer utilizzato per contenere i caratteri da trasmettere
	uint8_t * buffer_rx;				//  Buffer utilizzato per contenere i caratteri da ricevere
	uint32_t tx_count;					//  Contatore che indica il numero di caratteri trasmessi
	uint32_t rx_count;					//  Contatore che indica il numero di caratteri ricevuti
	uint32_t buffer_size;				//	Dimensione dei buffer ricezione/trasmissione
} UART;

int UART_Init(				UART* UART_device,
							struct module *owner,
							struct platform_device *pdev,
					  		struct class*  class,
							const char* driver_name,
							const char* device_name,
							uint32_t serial,
							struct file_operations *f_pdevs,
							irq_handler_t irq_handler,
							uint32_t irq_mask);

void UART_Destroy(UART* device);

void UART_SetCanRead(UART* device);

void UART_ResetCanRead(UART* device);

void UART_TestCanReadAndSleep(UART* device);

void UART_SetCanWrite(UART* device);

void UART_ResetCanWrite(UART* device);

void UART_TestCanWriteAndSleep(UART* device);

unsigned UART_GetPollMask(UART *device, struct file *file_ptr, struct poll_table_struct *wait);

void UART_WriteWakeUp(UART* device);

void UART_ReadPollWakeUp(UART* device);

void* UART_GetDeviceAddress(UART* device);

uint8_t UART_GetData(UART* device);

void UART_SetData(UART* device, uint8_t dataToSend);

void UART_Start(UART* device);

void UART_GlobalInterruptEnable(UART* UART_device);

void UART_GlobalInterruptDisable(UART* UART_device);

void UART_InterruptEnable(UART* UART_device,uint32_t mask);

void UART_InterruptDisable(UART* UART_device,uint32_t mask);

unsigned UART_PendingInterrupt(UART* UART_device);

void UART_TXInterruptAck(UART* UART_device);

void UART_RXInterruptAck(UART* UART_device);

#endif