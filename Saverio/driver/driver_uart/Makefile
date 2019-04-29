
CC=$(CROSS_COMPILE)gcc

obj-m += console_uart_kernel.o

KDIR  := /home/saverio/zybo/linux-xlnx
PWD		:= $(shell pwd)

default:
	${MAKE} -C $(KDIR) M=$(PWD) modules

clean:
	${MAKE} -C ${KDIR} M=${PWD} clean
