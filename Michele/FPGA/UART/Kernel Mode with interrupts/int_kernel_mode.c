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

#define DEVNAME "my_uart_int"

#define	DATA_IN    	   0 //8bit
#define	TX_EN	       4 //1bit
#define	STATUS_REG     8 /* OE (0)  FE(1) DE(2) TX_BUSY(4) */
#define	RX_REG	       12 //8 bit data reg RDA(8)

#define GLOBAL_INTR_EN 0
#define INTR_EN        4
#define INTR_STS       8
#define INTR_ACK       12
#define INTR_PENDING   16

#define INTR_MASK      3

struct mydriver_dm
{
   void __iomem *    base_addr; // ioremapped kernel virtual address of UART
   void __iomem *    int_addr; //ioremappet kernel virtual address of INT_DEVICE
   dev_t             dev_num; // dynamically allocated device number
   struct class *    class;   // sysfs class for this device
   struct device *   pdev;    // device
   unsigned long remap_size; /* Device Memory Size */
   int               irq; // the IRQ number ( note: this will NOT be the value from the DTS entry )
};

struct resource *irq_res; /* Device IRQ Resource Structure */
struct resource *res; /* Device Resource Structure */
struct resource *axi_intr_res; /* Device AXI Intr Resource Structure */

static struct mydriver_dm my_dm;
static struct mydriver_dm *dm;

static const struct of_device_id __test_int_driver_id[]={
{.compatible = "xlnx,my-uart-int-1.0"},
{}
};

/* Handler for /proc/my_int_uart
* -----------------------------------
*/
static irq_handler_t isr_handler(int irq,void *dev_id){
	
	u32 reg_sent_data, reg_received_data, pending_reg;
	
	iowrite32(0, dm->base_addr + TX_EN); // abbasso il TX_EN
	iowrite32(0, dm->int_addr + INTR_EN); //disabilito interruzioni
	
	printk(KERN_INFO"ISR serverd!\n");

	pending_reg = ioread32(dm->int_addr + INTR_STS);
	
	if((pending_reg & 0x00000002 & INTR_MASK) == 0x00000002){
		/*---ISR RX---*/
		printk(KERN_INFO"ISR RX...\n");
		reg_received_data = ioread32(dm->base_addr + RX_REG);
		printk(KERN_INFO"ISR RX - value %u received\n", reg_received_data & 0x000000FF);
		iowrite32(2, dm->int_addr + INTR_ACK); //ACK
	}
	if((pending_reg & 0x00000001 & INTR_MASK) == 0x00000001){
		/*---ISR TX---*/
		printk(KERN_INFO"ISR TX...\n");
		reg_sent_data = ioread32(dm->base_addr + DATA_IN);
		printk(KERN_INFO"ISR TX - value %u sent\n", reg_sent_data);
		iowrite32(1, dm->int_addr + INTR_ACK); //ACK
	}	
	
	iowrite32(INTR_MASK, dm->int_addr + INTR_EN); //abiito interruzioni
	
	return (irq_handler_t) IRQ_HANDLED;
}
 
/* Write operation for /proc/my_int_uart
* -----------------------------------
*/
static ssize_t my_int_uart_write(struct file *file, const char __user * buf, size_t count, loff_t * ppos){

		char my_int_uart_phrase[16];
		u32 my_int_uart_value;
		u32 statusTX;
	
		if (count < 11) {
			if (copy_from_user(my_int_uart_phrase, buf, count))
				return -EFAULT;
			my_int_uart_phrase[count] = '\0';
		}

		my_int_uart_value = simple_strtoul(my_int_uart_phrase, NULL, 0);
		wmb();
		
		iowrite32(my_int_uart_value, dm->base_addr + DATA_IN); // inserisco valore in DATA_IN
	    iowrite32(1, dm->base_addr + TX_EN); // assirisco il TX_EN

		statusTX = ioread32(dm->base_addr + STATUS_REG);
	
		printk(KERN_INFO"Write called...%u on register 0x%08lx", my_int_uart_value, (unsigned long)dm->base_addr + STATUS_REG);
	
		return count;
}

/* Callback function when opening file /proc/my_int_uart
* ------------------------------------------------------
*/
static int proc_my_int_uart_show(struct seq_file *p, void *v){

	u32 dataRX;
	//u32 status_reg;
	
	//while((dataRX & 256) != 256){ //polling for RDA enable	

	dataRX = ioread32(dm->base_addr + RX_REG);

	//}
	
	//status_reg = ioread32(dm->base_addr + STATUS_REG);

	seq_printf(p,"%08x", dataRX & 0x000000FF);
	//seq_printf(p,"Open called...value of: RX_REG %08x || STATUS_REG %08x", dataRX & 0x000000FF, status_reg);
	//printk(KERN_INFO"Open called...value of: RX_REG %08x || STATUS_REG %08x", dataRX & 0x000000FF, status_reg);
	
	return 0;
}

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

/* File Operations for /proc/my_uart_int 
* ------------------------------------
*/
static const struct file_operations proc_my_uart_int_operations = {
	.open = proc_my_int_uart_open,
	.read = seq_read,
	.write = my_int_uart_write,
	.llseek = seq_lseek,
};

/* Device Probe function for UartTX_RX
* ------------------------------------
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

	printk(KERN_INFO "IRQ read form DTS entry as %d\n", dm->irq);

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

	printk(KERN_INFO"res->start =  0x%08lx \n", (unsigned long) res->start);
	printk(KERN_INFO"res->end = 0x%08lx \n", (unsigned long) res->end);
	dm->remap_size = res->end - res->start + 1;
	printk(KERN_INFO"remap_size = 0x%08lx \n", (unsigned long) dm->remap_size);
	
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

	printk(KERN_INFO DEVNAME " probed at VA 0x%08lx\n", (unsigned long) dm->base_addr);
	
	axi_intr_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
	if (!axi_intr_res) {
		dev_err(&pdev->dev, "No memory resource\n");
		return -ENODEV;
	}

	printk(KERN_INFO"axi_intr_res->start =  0x%08lx \n", (unsigned long) axi_intr_res->start);
	printk(KERN_INFO"axi_intr_res->end = 0x%08lx \n", (unsigned long) axi_intr_res->end);
	dm->remap_size = axi_intr_res->end - axi_intr_res->start + 1;
	printk(KERN_INFO"remap_size = 0x%08lx \n", (unsigned long) dm->remap_size);
	
	if (!request_mem_region(axi_intr_res->start, dm->remap_size, pdev->name)) {
		dev_err(&pdev->dev, "Cannot request IO\n");
		return -ENXIO;
	}

	dm->int_addr = ioremap(axi_intr_res->start, dm->remap_size);
	if (dm->int_addr == NULL) {
		dev_err(&pdev->dev, "Couldn't ioremap memory at 0x%08lx\n", (unsigned long)axi_intr_res->start);
		ret = -ENOMEM;
		goto err_release_region;
	}
	
	printk(KERN_INFO DEVNAME " probed at VA 0x%08lx\n", (unsigned long) dm->int_addr);
	
	iowrite32(1, dm->int_addr + GLOBAL_INTR_EN); // abilitazione interruzioni globali
	printk(KERN_INFO"Writren value %u on register 0x%08lx", 1, (unsigned long)dm->int_addr + GLOBAL_INTR_EN);

	iowrite32(INTR_MASK, dm->int_addr + INTR_EN); // abilitazione interruzioni 
	printk(KERN_INFO"Written value %u on register 0x%08lx", INTR_MASK, (unsigned long)dm->int_addr + INTR_EN);

	return 0;
	
	err_create_proc_entry:
		iounmap(dm->base_addr);
		iounmap(dm->int_addr);
	err_release_region:
		release_mem_region(res->start, dm->remap_size);
		release_mem_region(axi_intr_res->start, dm->remap_size);
		

	return 0;

}
/* Remove function for /proc/my_uart_int
* ----------------------------------
*/
static int __test_int_driver_remove(struct platform_device *pdev){

	printk(KERN_INFO"test_int: IRQ %d about to be freed!\n",dm->irq);
	
	free_irq(dm->irq, dm);

	/* Remove /proc/my_int_uart entry */
	remove_proc_entry(DEVNAME, NULL);
	
	/* Release mapped virtual addresses */
	iounmap(dm->base_addr);
	iounmap(dm->int_addr);
	/* Release the regions */
	release_mem_region(res->start, dm->remap_size);
	release_mem_region(axi_intr_res->start, dm->remap_size);
	
	printk(KERN_INFO"Released mapped virtual addresses, proc entry and regions");
	
	return 0;
}

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