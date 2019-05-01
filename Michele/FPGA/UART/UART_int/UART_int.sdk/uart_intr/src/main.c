/*
 * main.c
 *
 *  Created on: 27 apr 2019
 *      Author: michele
 */

#include "uart_intr.h"
#include <stdio.h>
#include <stdlib.h>
#include "xil_io.h"
#include "xil_exception.h"
#include "xparameters.h"
#include "xil_cache.h"
#include "xil_printf.h"
#include "xil_types.h"
#include "xscugic.h"
#include "uart_intr.h"

/************************** Constant Definitions *****************************/

#define INTC_DEVICE_ID		XPAR_SCUGIC_0_DEVICE_ID

#define UART_INT_ADDR	0x43C10000
#define UART_BASE_ADDR	0x43C00000
#define INT_MASK		0x2
/**************************** Type Definitions *******************************/

void DeviceDriverHandler();
void ISR_TX();
void ISR_RX();

myIntUART myIntUARTInstance;
int count, tx_count, rx_count = 0;
volatile static int InterruptProcessed = FALSE;
u32 pendingReg, dataReg;

int main(void){

	int Status;
	XScuGic InterruptController;
	XScuGic_Config *GicConfig;

	MYINTUART_Init(&myIntUARTInstance, UART_BASE_ADDR, UART_INT_ADDR);

	GicConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
	Status = XScuGic_CfgInitialize(&InterruptController,GicConfig, GicConfig->CpuBaseAddress);
	if ( Status != XST_SUCCESS) return XST_FAILURE;

	MYINTUART_EnableInterrupt(&myIntUARTInstance,INT_MASK);
	MYINTUART_GlobalEnableInterrupt(&myIntUARTInstance,0x1);



	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
			(Xil_ExceptionHandler)XScuGic_InterruptHandler,&InterruptController);
	Xil_ExceptionEnable();


	Status = XScuGic_Connect(&InterruptController,XPAR_FABRIC_MY_UART_INT_0_IRQ_INTR,
				(Xil_ExceptionHandler)DeviceDriverHandler,(void *)&InterruptController);
	if ( Status != XST_SUCCESS) return XST_FAILURE;

	MYINTUART_EnableInterrupt(&myIntUARTInstance,INT_MASK);

	XScuGic_Enable(&InterruptController,XPAR_FABRIC_MY_UART_INT_0_IRQ_INTR);

	XScuGic_SetPriorityTriggerType(&InterruptController,XPAR_FABRIC_MY_UART_INT_0_IRQ_INTR,0x1,0x3);
	int i=1;
	count=0;

	MYINTUART_setData(&myIntUARTInstance,0xF);
	MYINTUART_Start(&myIntUARTInstance);
/*
	MYINTUART_setData(&myIntUARTInstance,0xA);
	MYINTUART_Start(&myIntUARTInstance);
*/

//	printf("Dato inviato.... attendo interrupt\n\n");


	while(i>0){

		if(InterruptProcessed){

			i++;
			InterruptProcessed =FALSE;

		}
	}

	return 0;
}

void DeviceDriverHandler()
{

	count++;
	MYINTUART_DisableInterrupt(&myIntUARTInstance,0x0);
	MYINTUART_Stop(&myIntUARTInstance);
	InterruptProcessed = TRUE;
//	printf("TX BUSY %08x: ",MYINTUART_GetStatus(&myIntUARTInstance));

	pendingReg = MYINTUART_GetPending(&myIntUARTInstance);
	printf("PENDING REG %08x: ",pendingReg);

	/* NB nel caso reale dovrei fare elseif perchè devo servirne una sola per ISR */

	dataReg = MYINTUART_GetData(&myIntUARTInstance);

	if((pendingReg & 0x00000002 & INT_MASK) == 0x00000002)
		ISR_RX();
	if((pendingReg & 0x00000001 & INT_MASK) == 0x00000001)
		ISR_TX();

	pendingReg = MYINTUART_GetPending(&myIntUARTInstance);

	MYINTUART_EnableInterrupt(&myIntUARTInstance,INT_MASK);
}

void ISR_TX(){

	tx_count++;
	MYINTUART_ACK(&myIntUARTInstance,0x1);
}

void ISR_RX(){

	rx_count++;
	MYINTUART_ACK(&myIntUARTInstance,0x2);
}
