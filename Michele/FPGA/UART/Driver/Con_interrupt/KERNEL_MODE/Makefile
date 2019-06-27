obj-m += my_kernel_UART.o
my_kernel_UART-objs :=UART_kernel_main.o UART.o UART_list.o

all:
	make -C linux-xlnx/ M=$(PWD) modules

clean:
	make -C linux-xlnx/ M=$(PWD) clean
