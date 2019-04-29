#include "myIntGPIO2.h"
#include "myIntGPIO.h"
#include "xil_types.h"
#include "xil_io.h"


void MYINTGPIO_EnableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	u32 Register;
	unsigned IER_OFFSET = 0x04;
	Register = MYINTGPIO_mReadReg(myIntGPIOInstance->IntAddress,IER_OFFSET);
	MYINTGPIO_mWriteReg(myIntGPIOInstance->IntAddress,IER_OFFSET, Register | mask);

}


void MYINTGPIO_GlobalEnableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	u32 Register;
	unsigned GIE_OFFSET = 0x00;
	Register = MYINTGPIO_mReadReg(myIntGPIOInstance->IntAddress,GIE_OFFSET);
	MYINTGPIO_mWriteReg(myIntGPIOInstance->IntAddress,GIE_OFFSET, Register | mask);

}

void MYINTGPIO_DisableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	u32 Register;
	unsigned IER_OFFSET = 0x04;
	Register = MYINTGPIO_mReadReg(myIntGPIOInstance->IntAddress,IER_OFFSET);
	MYINTGPIO_mWriteReg(myIntGPIOInstance->IntAddress,IER_OFFSET, Register & (~mask));
}


void MYINTGPIO_ACK(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	u32 Register;
	unsigned ACK_OFFSET = 0x0C;
	Register = MYINTGPIO_mReadReg(myIntGPIOInstance->IntAddress,ACK_OFFSET);
	MYINTGPIO_mWriteReg(myIntGPIOInstance->IntAddress,ACK_OFFSET, Register | mask);
}

void MYINTGPIO_SetMask(myIntGPIO * myIntGPIOInstance, u32 mask){
		u32 Register;
		unsigned MASK_OFFSET = 0x08;
		Register = MYINTGPIO_mReadReg(myIntGPIOInstance->BaseAddress,MASK_OFFSET);
		MYINTGPIO_mWriteReg(myIntGPIOInstance->BaseAddress,MASK_OFFSET, Register | mask);
}

void MYINTGPIO_Init(myIntGPIO * myIntGPIOInstance, u32 baseaddr, u32 intaddr){
	myIntGPIOInstance->BaseAddress=baseaddr;
	myIntGPIOInstance->IntAddress=intaddr;
}

