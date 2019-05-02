/*
 * uart_intr.c
 *
 *  Created on: 27 apr 2019
 *      Author: michele
 */

#include "my_uart_int.h"
#include "uart_intr.h"
#include "xil_types.h"
#include "xil_io.h"


void MYINTUART_EnableInterrupt(myIntUART * MY_UART_INTInstance, u32 mask)
{
	unsigned IER_OFFSET = 0x4;
	MY_UART_INT_mWriteReg(MY_UART_INTInstance->IntAddress,IER_OFFSET, mask);

}


void MYINTUART_GlobalEnableInterrupt(myIntUART * MY_UART_INTInstance, u32 mask)
{
	unsigned GIE_OFFSET = 0x0;
	MY_UART_INT_mWriteReg(MY_UART_INTInstance->IntAddress,GIE_OFFSET, mask);

}
/*
void MYINTUART_DisableInterrupt(myIntUART * MY_UART_INTInstance, u32 mask)
{
	u32 Register;
	unsigned IER_OFFSET = 0x04;
	Register = MY_UART_INT_mReadReg(MY_UART_INTInstance->IntAddress,IER_OFFSET);
	MY_UART_INT_mWriteReg(MY_UART_INTInstance->IntAddress,IER_OFFSET, Register & (~mask));
}
*/

void MYINTUART_DisableInterrupt(myIntUART * MY_UART_INTInstance, u32 mask)
{
	unsigned IER_OFFSET = 0x04;
	MY_UART_INT_mWriteReg(MY_UART_INTInstance->IntAddress,IER_OFFSET, mask);
}


void MYINTUART_ACK(myIntUART * MY_UART_INTInstance, u32 mask)
{
	unsigned ACK_OFFSET = 0x0C;
	MY_UART_INT_mWriteReg(MY_UART_INTInstance->IntAddress,ACK_OFFSET,mask);
}

u32 MYINTUART_GetStatus(myIntUART * MY_UART_INTInstance){
		u32 Register;
		unsigned MASK_OFFSET = 0x08;
		Register = MY_UART_INT_mReadReg(MY_UART_INTInstance->BaseAddress,MASK_OFFSET);
		return Register;
}

void MYINTUART_Init(myIntUART * MY_UART_INTInstance, u32 baseaddr, u32 intaddr){
	MY_UART_INTInstance->BaseAddress=baseaddr;
	MY_UART_INTInstance->IntAddress=intaddr;
}


void MYINTUART_setData(myIntUART * MY_UART_INTInstance, u32 mask){
		unsigned MASK_OFFSET = 0x00;
		MY_UART_INT_mWriteReg(MY_UART_INTInstance->BaseAddress,MASK_OFFSET,mask);
}

u32 MYINTUART_GetData(myIntUART * MY_UART_INTInstance){
		u32 Register;
		unsigned MASK_OFFSET = 0x0C;
		Register = MY_UART_INT_mReadReg(MY_UART_INTInstance->BaseAddress,MASK_OFFSET);
		return Register;
}

u32 MYINTUART_GetPending(myIntUART * MY_UART_INTInstance){
	u32 Register;
	unsigned MASK_OFFSET = 0x08;
	Register = MY_UART_INT_mReadReg(MY_UART_INTInstance->IntAddress,MASK_OFFSET);
	return Register;
}

void MYINTUART_Start(myIntUART * MY_UART_INTInstance){
		unsigned MASK_OFFSET = 0x04;
		MY_UART_INT_mWriteReg(MY_UART_INTInstance->BaseAddress,MASK_OFFSET, 0x1);
}

void MYINTUART_Stop(myIntUART * MY_UART_INTInstance){
	unsigned MASK_OFFSET = 0x04;
	MY_UART_INT_mWriteReg(MY_UART_INTInstance->BaseAddress,MASK_OFFSET, 0x0);
}

