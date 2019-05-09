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

#define DEVNAME "GPIO_2"

#define	DIR_OFF    	    0  // DIRECTION
#define	WRITE_OFF	    4  // WRITE
#define READ_OFF		8  // READ
#define GLOBAL_INTR_EN  12 // GLOBAL INTERRUPT ENABLE
#define INTR_EN         16 // LOCAL INTERRUPT ENABLE
#define INTR_ACK_PEND   28 // PENDING/ACK REGISTER

#define INTR_MASK      0xF

struct mydriver_dm
{
   void __iomem *    base_addr; // ioremapped kernel virtual address of UART
   struct platform_device *   pdev;    // device
   unsigned long remap_size; /* Device Memory Size */
   int               irq; // the IRQ number ( note: this will NOT be the value from the DTS entry )
};

struct resource *irq_res; /* Device IRQ Resource Structure */
struct resource *res; /* Device Resource Structure */

static struct mydriver_dm my_dm;
static struct mydriver_dm *dm;

static const struct of_device_id __test_int_driver_id[]={
{.compatible = "xlnx,GPIO_2"},
{}
};

static irq_handler_t isr_handler(int irq,void *dev_id){
		
	u32 read_reg;
	
	printk(KERN_INFO"HANDLER - irq_num = %d",irq);
	
	iowrite32(0, dev_id + GLOBAL_INTR_EN); //disabilito interruzioni
	
	read_reg = ioread32(dev_id + READ_OFF); // leggo valore da READ register
		
	printk(KERN_INFO"**********ISR LED***********");
	
	printk(KERN_INFO"READ value %08x\n", read_reg);

	
	iowrite32(INTR_MASK, dev_id + INTR_ACK_PEND); //ACK
	iowrite32(0, dev_id + INTR_ACK_PEND); //ACK
	
	iowrite32(1, dev_id + GLOBAL_INTR_EN); //abiito interruzioni
	
	return (irq_handler_t) IRQ_HANDLED;
}
 
/* Write operation for /proc/GPIO_2
* --------------------------------------
*/
static ssize_t GPIO_write(struct file *file, const char __user * buf, size_t count, loff_t * ppos){

		char GPIO_phrase[16];
		u32 GPIO_value;
			
		if (count < 12) {
			if (copy_from_user(GPIO_phrase, buf, count))
				return -EFAULT;
			GPIO_phrase[count] = '\0';
		}

		GPIO_value = simple_strtoul(GPIO_phrase, NULL, 0);
		wmb();
		
		iowrite32(GPIO_value, dm->base_addr + DIR_OFF); // inserisco valore in WRITE register
	
		printk(KERN_INFO"Write called, written value %08x on register direction", GPIO_value);
	
		return count;
}

/* Callback function when opening file /proc/GPIO_2
* ------------------------------------------------------
*/
static int proc_GPIO_show(struct seq_file *p, void *v){

	u32 read_reg;
	
	read_reg = ioread32(dm->base_addr + READ_OFF); // leggo valore da READ register

	seq_printf(p,"Open called: READ value %08x\n", read_reg);
	printk(KERN_INFO"Open called: READ value %08x\n", read_reg);
	
	return 0;
}

/* Open function for /proc/GPIO_2
* ------------------------------------
*/
static int proc_GPIO_open(struct inode *inode, struct file *file){

	unsigned int size = 16;
	char *buf;
	struct seq_file *m;
	int res;
	buf = (char *)kmalloc(size * sizeof(char), GFP_KERNEL);
	
	if (!buf)
		return -ENOMEM;
	res = single_open(file, proc_GPIO_show, NULL);
	
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

/* File Operations for /proc/GPIO_2 */
static const struct file_operations proc_GPIO_operations = {
	.open = proc_GPIO_open,
	.read = seq_read,
	.write = GPIO_write,
	.llseek = seq_lseek,
};


static int __test_int_driver_probe(struct platform_device *pdev){
              
	int ret, rval = 0;
	struct proc_dir_entry *GPIO_proc_entry;
	dm = &my_dm;
		
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
	
	GPIO_proc_entry = proc_create(DEVNAME, 0, NULL, &proc_GPIO_operations);
	if (GPIO_proc_entry == NULL) {
		dev_err(&pdev->dev, "Couldn't create proc entry\n");
		ret = -ENOMEM;
		goto err_create_proc_entry;
	}

	printk(KERN_INFO DEVNAME": IRQ about to be registered!\n");

	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
	if (!irq_res) {
		printk(KERN_INFO "could not get platform IRQ resource.\n");
		return -1;
	 }

	dm->irq = irq_res->start; // save the returned IRQ
	
	printk(KERN_INFO "IRQ read form DTS entry as %d\n", dm->irq);

	rval = request_irq(dm->irq, (irq_handler_t) isr_handler, IRQF_SHARED, DEVNAME, dm->base_addr);
	if(rval != 0){
		printk(KERN_INFO "can't get assigned irq: %d\n", dm->irq);
		return -1;
	}
	
	printk(KERN_INFO "IRQ registered as %d\n", dm->irq);
	
	dm->pdev = pdev;
	
	printk(KERN_INFO DEVNAME " Driver succesfully probed at VA 0x%08lx\n", (unsigned long) dm->base_addr);
	
	iowrite32(1, dm->base_addr + GLOBAL_INTR_EN); // abilitazione interruzioni globali
	printk(KERN_INFO"Written value %u on register 0x%08lx - Global Interrupt enabled", 1, (unsigned long)dm->base_addr + GLOBAL_INTR_EN);

	iowrite32(INTR_MASK, dm->base_addr + INTR_EN); // abilitazione interruzioni 
	printk(KERN_INFO"Written value %02x on register 0x%08lx - Local Interrupt enabled", INTR_MASK, (unsigned long)dm->base_addr + INTR_EN);

	printk(KERN_INFO "base_addr: 0x%08lx", (unsigned long)dm->base_addr);
	
	return 0;
	
	err_create_proc_entry:
		iounmap(dm->base_addr);
	err_release_region:
		release_mem_region(res->start, dm->remap_size);
		
	return 0;

}

static int __test_int_driver_remove(struct platform_device *pdev){

	printk(KERN_INFO"IRQ %d about to be freed!\n",dm->irq);
	
	free_irq(dm->irq, dm);

	/* Remove /proc/GPIO_2 entry */
	remove_proc_entry(DEVNAME, NULL);
	
	/* Release mapped virtual addresses */
	iounmap(dm->base_addr);
	/* Release the regions */
	release_mem_region(res->start, dm->remap_size);
	
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