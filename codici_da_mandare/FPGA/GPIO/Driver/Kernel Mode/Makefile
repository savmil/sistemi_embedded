obj-m += my_kernel_GPIO.o
my_kernel_GPIO-objs :=GPIO_kernel_main.o GPIO.o GPIO_list.o

all:
	make -C linux-xlnx/ M=$(PWD) modules

clean:
	make -C linux-xlnx/ M=$(PWD) clean
