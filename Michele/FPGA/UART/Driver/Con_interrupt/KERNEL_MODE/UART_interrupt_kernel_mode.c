#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <linux/sched.h>
#include <linux/platform_device.h>
#include <linux/io.h>
#include <linux/of.h>
#include <linux/uaccess.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#include <linux/slab.h>
#include <linux/mod_devicetable.h>

#define DEVNAME "UART"

#define	DATA_IN    0 // DATA TO SEND
#define	TX_EN	   4 // TRANSFER ENABLE (0)
#define	STATUS_REG 8 // OE (0)  FE(1) DE(2) RDA(3) TX_BUSY(4) 
#define	RX_REG	   12 // DATA RECEIVED
#define GLOBAL_INTR_EN 16 // GLOBAL INTERRUPT ENABLE
#define INTR_EN        20 // LOCAL INTERRUPT ENABLE
#define INTR_ACK_PEND  28 // PENDING/ACK REGISTER

#define INTR_MASK      3

/**
 * Una struttura che contiene le informazioni riguardanti la gestione
 * del componente Hardware
 */
struct mydriver_dm
{
   /*@{*/
   void __iomem *    base_addr;/**<indirizzo virtuale UART*/ // ioremapped kernel virtual address of UART
   struct platform_device *   pdev;/**<dispositivo*/    // device
   unsigned long remap_size;/**<area di memoria occupata per la gestione del device*/ // Device Memory Size 
   int               irq;/**<valore dell' IRQ da gestire*/ // the IRQ number ( note: this will NOT be the value from the DTS entry )
   /*@}*/
};

struct resource *irq_res; // Device IRQ Resource Structure 
struct resource *res; // Device Resource Structure 

static struct mydriver_dm my_dm;
static struct mydriver_dm *dm;

u8 * buffer_tx;
u8 * buffer_rx;
int tx_count, rx_count, buffer_size = 0;

/**
 * @file UART_interrupt_kernel_mode.c
 * @page driver_UART_kernel
 * @brief funzioni per gestire la trasmissione e la ricezione dei
 * 	  dati utilizzando il protocollo UART (KERNEL)
 */
/**
 *
 * @brief	Handler dell' interrupt
 *
 * @param	irq è il valore associato all' interrupt da gestire
 * @param	dev_id non utilizzato
 *
 * @return	ritorna identificativo del handler
 *
 * @note
 *
 */
static irq_handler_t isr_handler(int irq,void *dev_id){
	
	u32 reg_sent_data, pending_reg;
	
	iowrite32(0, dm->base_addr + TX_EN); // abbasso il TX_EN
	iowrite32(0, dm->base_addr + GLOBAL_INTR_EN); //disabilito interruzioni
	
	printk(KERN_INFO"ISR serverd!\n");

	pending_reg = ioread32(dm->base_addr + INTR_ACK_PEND);
	
	if((pending_reg & 0x00000002) == 0x00000002){
		/*---ISR RX---*/
		printk(KERN_INFO"ISR RX...\n");
		
		if(rx_count <= buffer_size){
			
			buffer_rx[rx_count] = ioread32(dm->base_addr + RX_REG);
			printk(KERN_INFO"ISR RX - value received: %c\n", buffer_rx[rx_count]);
			
		}
		
		iowrite32(2, dm->base_addr + INTR_ACK_PEND); //ACK
		iowrite32(0, dm->base_addr + INTR_ACK_PEND); //ACK
		iowrite32(1, dm->base_addr + GLOBAL_INTR_EN); //abiito interruzioni
		rx_count++;
	}
	else if((pending_reg & 0x00000001) == 0x00000001){
		/*---ISR TX---*/
		tx_count++;
		printk(KERN_INFO"ISR TX...\n");
		
		if(tx_count < buffer_size){
			
			reg_sent_data = ioread32(dm->base_addr + DATA_IN);
			printk(KERN_INFO"ISR TX - value sent: %c\n", reg_sent_data);
			printk(KERN_INFO"ISR TX - start sending next value: %c\n", buffer_tx[tx_count]);
			iowrite32(buffer_tx[tx_count], dm->base_addr + DATA_IN); 
			
			iowrite32(1, dm->base_addr + INTR_ACK_PEND); //ACK
			iowrite32(0, dm->base_addr + INTR_ACK_PEND); //ACK
			iowrite32(1, dm->base_addr + GLOBAL_INTR_EN); //abiito interruzioni
			iowrite32(1, dm->base_addr + TX_EN); // assirisco il TX_EN
		}
		else{
			iowrite32(1, dm->base_addr + INTR_ACK_PEND); //ACK
			iowrite32(0, dm->base_addr + INTR_ACK_PEND); //ACK
			iowrite32(1, dm->base_addr + GLOBAL_INTR_EN); //abiito interruzioni
		}
	}	
	
	return (irq_handler_t) IRQ_HANDLED;
}

static const struct of_device_id __test_int_driver_id[]={
{.compatible = "xlnx,UART-1.0"},
{}
};

 
/* Write operation for /proc/my_int_uart
* --------------------------------------
*/
/**
 *
 * @brief	legge i valori scritti sul file /proc/UART e li invia utiliz
 *		zando UART
 *
 * @param	file in cui viengono scritti i dati da mandare
 * @param	_user non utilizato
 * @param	count numero di caratteri massimi da leggere
 * @param	ppos non utilizzato
 * @return	numeri di caratteri scritti sul file
 *
 * @note
 *
 */
static ssize_t my_int_uart_write(struct file *file, const char __user * buf, size_t count, loff_t * ppos){

		char * my_int_uart_phrase;
		int j;
	
		tx_count = 0;
		rx_count = 0;
		buffer_size = 0;
			
		if ((my_int_uart_phrase = kmalloc(sizeof(char)*count, GFP_KERNEL)) == NULL ) {
			printk(KERN_ERR "%s: kmalloc return NULL\n", __func__);
			return -ENOMEM;
		}
	
		if (copy_from_user(my_int_uart_phrase, buf, count))
			return -EFAULT;
		
		buffer_size = count-1;
	
		if ((buffer_tx = krealloc(buffer_tx, sizeof(u8)*buffer_size, GFP_KERNEL)) == NULL ) {
			printk(KERN_ERR "%s: kmalloc return NULL\n", __func__);
			return -ENOMEM;
		}
		printk(KERN_INFO"Allocated in buffer_tx %d bytes | buffer size = %d ", sizeof(u8)*buffer_size, buffer_size);

		if ((buffer_rx = krealloc(buffer_rx, sizeof(u8)*buffer_size, GFP_KERNEL)) == NULL ) {
			printk(KERN_ERR "%s: kmalloc return NULL\n", __func__);
			return -ENOMEM;
		}
		printk(KERN_INFO"Allocated in buffer_rx %d bytes | buffer size = %d ", sizeof(u8)*buffer_size, buffer_size);

		for(j=0; j<buffer_size; j++){
			
			buffer_tx[j] = my_int_uart_phrase[j];								  
			printk(KERN_INFO"buffer_tx[%d] %c", j, buffer_tx[j]);
			wmb();
		}
		
		printk(KERN_INFO"Write called with value %s", my_int_uart_phrase);
	
		printk(KERN_INFO"Start sending first value: %c", buffer_tx[0]);
		iowrite32(buffer_tx[0], dm->base_addr + DATA_IN); // inserisco valore in DATA_IN
	    iowrite32(1, dm->base_addr + TX_EN); // assirisco il TX_EN
	
		kfree(my_int_uart_phrase);
	
		return count;
}
/**
 *
 * @brief	restituisce lo stato della UART quando si apre il file
 *		/proc/UART
 *
 * @param	seq_file non utilizzato
 * @param	v non utilizato
 * @return	
 *
 * @note
 *
 */
/* Callback function when opening file /proc/my_int_uart
* ------------------------------------------------------
*/
static int proc_my_int_uart_show(struct seq_file *p, void *v){

	u32 status_reg;
	int j=0;
	
	status_reg = ioread32(dm->base_addr + STATUS_REG);
	
	for(j=0;j<buffer_size;j++)
		seq_printf(p,"%c", buffer_rx[j]);
	
	printk(KERN_INFO"Open called. STATUS REG: %08x", status_reg);
	
	return 0;
}
/**
 *
 * @brief	gestisce l' apertura del file /proc/UART
 *		/proc/UART
 *
 * @param	inode non utilizzato
 * @param	file file che deve essere aperto
 * @return	
 *
 * @note
 *
 */
/* Open function for /proc/my_int_uart
* ------------------------------------
*/
static int proc_my_int_uart_open(struct inode *inode, struct file *file){

	unsigned int size = 16;
	char *buf;
	struct seq_file *m;
	int res;
	buf = (char *)kmalloc(size * sizeof(char), GFP_KERNEL);
	
	if (!buf)
		return -ENOMEM;
	res = single_open(file, proc_my_int_uart_show, NULL);
	
	if (!res) {
		m = file->private_data;
		m->buf = buf;
		m->size = size;
	}
	else {
		kfree(buf);
	}
	
	return res;
}

/* File Operations for /proc/my_uart_int */
/**
 * Una struttura che definisce le operazioni sul file /proc/UART 
 * @param open funzione che gestisce l' apertura
 * @param read funzione che gestisce la lettura
 * @param write funzione che gestisce la scrittura
 * @param llseek funzione che gestisce la ricerca nel file
 */
static const struct file_operations proc_my_uart_int_operations = {
	.open = proc_my_int_uart_open,
	.read = seq_read,
	.write = my_int_uart_write,
	.llseek = seq_lseek,
};

/**
 *
 * @brief	gestione del platoform device, gestionde dell' interrupt
 *		
 *
 * @param	pdev platform device da gestire
 * @return	
 *
 * @note
 *
 */
static int __test_int_driver_probe(struct platform_device *pdev){
              
	int ret, rval = 0;
	struct proc_dir_entry *my_int_uart_proc_entry;
	dm = &my_dm;
	
	printk(KERN_INFO DEVNAME": IRQ about to be registered!\n");

	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
	if (!irq_res) {
		printk(KERN_INFO "could not get platform IRQ resource.\n");
		return -1;
	 }

	dm->irq = irq_res->start; // save the returned IRQ

	rval = request_irq(dm->irq, (irq_handler_t) isr_handler, IRQF_SHARED , DEVNAME, dm);
	if(rval != 0){
		printk(KERN_INFO "can't get assigned irq: %d\n", dm->irq);
		return -1;
	}

	printk(KERN_INFO "IRQ registered as %d\n", dm->irq);
	
	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!res) {
		dev_err(&pdev->dev, "No memory resource\n");
		return -ENODEV;
	}
	
	dm->remap_size = res->end - res->start + 1;
	
	if (!request_mem_region(res->start, dm->remap_size, pdev->name)) {
		dev_err(&pdev->dev, "Cannot request IO\n");
		return -ENXIO;
	}

	dm->base_addr = ioremap(res->start, dm->remap_size);
	if (dm->base_addr == NULL) {
		dev_err(&pdev->dev, "Couldn't ioremap memory at 0x%08lx\n", (unsigned long)res->start);
		ret = -ENOMEM;
		goto err_release_region;
	}
	
	my_int_uart_proc_entry = proc_create(DEVNAME, 0, NULL, &proc_my_uart_int_operations);
	if (my_int_uart_proc_entry == NULL) {
		dev_err(&pdev->dev, "Couldn't create proc entry\n");
		ret = -ENOMEM;
		goto err_create_proc_entry;
	}

	dm->pdev = pdev;
	
	printk(KERN_INFO DEVNAME " Driver succesfully probed at VA 0x%08lx\n", (unsigned long) dm->base_addr);
	
	iowrite32(1, dm->base_addr + GLOBAL_INTR_EN); // abilitazione interruzioni globali
	printk(KERN_INFO"Written value %u on register 0x%08lx - Global Interrupt enabled", 1, (unsigned long)dm->base_addr + GLOBAL_INTR_EN);

	iowrite32(INTR_MASK, dm->base_addr + INTR_EN); // abilitazione interruzioni 
	printk(KERN_INFO"Written value %u on register 0x%08lx - Local Interrupt enabled", INTR_MASK, (unsigned long)dm->base_addr + INTR_EN);

	return 0;
	
	err_create_proc_entry:
		iounmap(dm->base_addr);
	err_release_region:
		release_mem_region(res->start, dm->remap_size);
		
	return 0;

}
/**
 *
 * @brief	rimuove il platform device
 *		
 *
 * @param	pdev platform device da gestire
 * @return	
 *
 * @note
 *
 */
static int __test_int_driver_remove(struct platform_device *pdev){

	printk(KERN_INFO"IRQ %d about to be freed!\n",dm->irq);
	
	free_irq(dm->irq, dm);
	kfree(buffer_tx);
	kfree(buffer_rx);
	
	/* Remove /proc/my_int_uart entry */
	remove_proc_entry(DEVNAME, NULL);
	
	/* Release mapped virtual addresses */
	iounmap(dm->base_addr);
	/* Release the regions */
	release_mem_region(res->start, dm->remap_size);
	
	printk(KERN_INFO"Released mapped virtual addresses, proc entry and regions");
	
	return 0;
}
/**
 * Una struttura che gestisce l' identificativo del platform driver
 * @param name nome driver
 * @param owner proprietario
 * @param of_match_table id
 * @param probe funzione iniziallizzazione driver
 * @param remove funzione che gestisce la rimozione
 */
static struct platform_driver __test_int_driver={
.driver={
	.name=DEVNAME,
	.owner=THIS_MODULE,
	.of_match_table=of_match_ptr(__test_int_driver_id), 
	
},
.probe=__test_int_driver_probe, 
.remove=__test_int_driver_remove 
};
  

module_platform_driver(__test_int_driver);
 
MODULE_LICENSE("GPL");
