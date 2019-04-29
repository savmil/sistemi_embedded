#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/uaccess.h>
#include <linux/io.h>
#include <linux/proc_fs.h>
#include <linux/seq_file.h>
#include <linux/platform_device.h>
#include <linux/slab.h>
#include <linux/mod_devicetable.h>

/* Define Driver Name */
#define DRIVER_NAME "UartTX_RX"
static void *base_addr; /* Vitual Base Address */
struct resource *res; /* Device Resource Structure */
unsigned long remap_size; /* Device Memory Size */

#define	DATA_IN 0 //8bit
#define	TX_EN	4 //1bit
#define	STATUS_REG 8 /* OE (0)  FE(1) DE(2) TX_BUSY(4) */
#define	RX_REG	12 //8 bit data reg RDA(8)

/* Write operation for /proc/UartTX_RX
* -----------------------------------
* Quando l'utente utilizza il comando "cat" con una stringa verso /proc/UartTX_RX,
* la stringa viene salvata in * const char __user *buf. Questa funzione la copia dal user
* space al kernel space, e la trasforma in un unsigned long.
* Scrive il valore nel registro attivando la modalità trasmissione.
*/
static ssize_t proc_UartTX_RX_write(struct file *file, const char __user * buf, size_t count, loff_t * ppos){

		char UartTX_RX_phrase[16];
		u32 UartTX_RX_value;
		u32 statusTX;
	
		if (count < 11) {
			if (copy_from_user(UartTX_RX_phrase, buf, count))
				return -EFAULT;
			UartTX_RX_phrase[count] = '\0';
		}

		UartTX_RX_value = simple_strtoul(UartTX_RX_phrase, NULL, 0);
		wmb();
		
//		printk("scrivo valore %u all'indirizzo 0x%08p\n", UartTX_RX_value, base_addr+4);
		iowrite32(UartTX_RX_value, base_addr + DATA_IN); // inserisco valore in DATA_IN
	    iowrite32(1, base_addr + TX_EN); // assirisco il TX_EN

		statusTX = ioread32(base_addr + STATUS_REG);
		
		while((statusTX & 16) != 16){			

			statusTX = ioread32(base_addr + STATUS_REG); // polling su tx_busy, quando tx_busy=0 allora abbassa tx_en

		}
	
		iowrite32(0, base_addr + TX_EN);
	
		printk("INVIATO VALORE %u ", UartTX_RX_value);
	
		return count;
}

/* Callback function when opening file /proc/UartTX_RX
* ------------------------------------------------------
* Read the register value of UartTX_RX controller, print the value to
* the sequence file struct seq_file *p. In file open operation for /proc/UartTX_RX
* this callback function will be called first to fill up the seq_file,
* and seq_read function will print whatever in seq_file to the terminal.
*/
static int proc_UartTX_RX_show(struct seq_file *p, void *v){

	u32 dataRX;
	u32 status_reg;
	
	dataRX = ioread32(base_addr + RX_REG);
	
	while((dataRX & 256) != 256){ //polling for RDA enable	

		dataRX = ioread32(base_addr + RX_REG);

	}
	
	status_reg = ioread32(base_addr + STATUS_REG);
	
	seq_printf(p, "RICEVUTO VALORE %u\n", dataRX & 0x000000FF);
	seq_printf(p, "STATUS REGISTER : %08x\n", status_reg);

	
	printk("RICEVUTO VALORE: %u ", dataRX & 0x000000FF);
	printk("STATUS_REGISTER : %08x", status_reg);
	
	return 0;
}

/* Open function for /proc/UartTX_RX
* ------------------------------------
* When user want to read /proc/UartTX_RX (i.e. cat /proc/UartTX_RX), the open function
* will be called first. In the open function, a seq_file will be prepared and the
* status of UartTX_RX will be filled into the seq_file by proc_UartTX_RX_show function.
*/
static int proc_UartTX_RX_open(struct inode *inode, struct file *file){

	unsigned int size = 16;
	char *buf;
	struct seq_file *m;
	int res;
	buf = (char *)kmalloc(size * sizeof(char), GFP_KERNEL);
	
	if (!buf)
		return -ENOMEM;
	res = single_open(file, proc_UartTX_RX_show, NULL);
	
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

/* File Operations for /proc/UartTX_RX */
static const struct file_operations proc_UartTX_RX_operations = {
	.open = proc_UartTX_RX_open,
	.read = seq_read,
	.write = proc_UartTX_RX_write,
	.llseek = seq_lseek,
	.release = single_release
};

/*
* Shutdown function for UartTX_RX
* -----------------------------------
* Before UartTX_RX shutdown, turn-off all the leds
*/
static void UartTX_RX_shutdown(struct platform_device *pdev){
	iowrite32(0, base_addr);
}

/* Remove function for UartTX_RX
* ----------------------------------
* When UartTX_RX module is removed, turn off all the leds first,
* release virtual address and the memory region requested.
*/
static int UartTX_RX_remove(struct platform_device *pdev){

	UartTX_RX_shutdown(pdev);
	
	/* Remove /proc/UartTX_RX entry */
	remove_proc_entry(DRIVER_NAME, NULL);
	
	/* Release mapped virtual address */
	iounmap(base_addr);
	
	/* Release the region */
	release_mem_region(res->start, remap_size);

	return 0;
}


/* Device Probe function for UartTX_RX
* ------------------------------------
* Get the resource structure from the information in device tree.
* request the memory regioon needed for the controller, and map it into
* kernel virtual memory space. Create an entry under /proc file system
* and register file operations for that entry.
*/
static int UartTX_RX_probe(struct platform_device *pdev){

	struct proc_dir_entry *UartTX_RX_proc_entry;
	int ret = 0;

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!res) {
		dev_err(&pdev->dev, "No memory resource\n");
		return -ENODEV;
	}

	printk("res->end = 0x%08lx \n", (unsigned long) res->end);
	printk("res->start =  0x%08lx \n", (unsigned long) res->start);
	remap_size = res->end - res->start + 1;
	printk("remap_size = 0x%08lx \n", (unsigned long) remap_size);
	
	if (!request_mem_region(res->start, remap_size, pdev->name)) {
		dev_err(&pdev->dev, "Cannot request IO\n");
		return -ENXIO;
	}

	base_addr = ioremap(res->start, remap_size);
	if (base_addr == NULL) {
		dev_err(&pdev->dev, "Couldn't ioremap memory at 0x%08lx\n", (unsigned long)res->start);
		ret = -ENOMEM;
		goto err_release_region;
	}
	
	UartTX_RX_proc_entry = proc_create(DRIVER_NAME, 0, NULL, &proc_UartTX_RX_operations);
	if (UartTX_RX_proc_entry == NULL) {
		dev_err(&pdev->dev, "Couldn't create proc entry\n");
		ret = -ENOMEM;
		goto err_create_proc_entry;
	}

	printk(KERN_INFO DRIVER_NAME " probed at VA 0x%08lx\n", (unsigned long) base_addr);
	return 0;
	
	err_create_proc_entry:
		iounmap(base_addr);
	err_release_region:
		release_mem_region(res->start, remap_size);

	return ret;
}

/* device match table to match with device node in device tree */
static const struct of_device_id UartTX_RX_of_match[] = {
	{.compatible = "xlnx,myuart-1.0"},
	{},
};

MODULE_DEVICE_TABLE(of, UartTX_RX_of_match);

/* platform driver structure for UartTX_RX driver */
static struct platform_driver UartTX_RX_driver = {
	.driver = {
		.name = DRIVER_NAME,
		.owner = THIS_MODULE,
		.of_match_table = UartTX_RX_of_match},
	.probe = UartTX_RX_probe,
	.remove = UartTX_RX_remove,
	.shutdown = UartTX_RX_shutdown
};

/* Register UartTX_RX platform driver */
module_platform_driver(UartTX_RX_driver);

MODULE_AUTHOR("Michele Bevilacqua");
MODULE_LICENSE("GPL");
MODULE_DESCRIPTION(DRIVER_NAME ": UART TX RX driver");
MODULE_ALIAS(DRIVER_NAME);