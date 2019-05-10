#include "myuart.h"
#include <stdio.h>
#include <stdlib.h>
#include "xil_io.h"
#include "xil_exception.h"
#include "xparameters.h"
#include "xil_cache.h"
#include "xil_printf.h"
#include "xil_types.h"
#include "xscugic.h"
#include "xil_cache_l.h"

/************************** Constant Definitions *****************************/

#define INTC_DEVICE_ID		XPAR_SCUGIC_0_DEVICE_ID

#define UART_BASE_ADDR		0x43C00000
#define INT_MASK			0x3
/**************************** Type Definitions *******************************/

void DeviceDriverHandler();
void ISR_TX();
void ISR_RX();

UART UARTInstance;
volatile static int InterruptProcessed = FALSE;
u32 pendingReg, dataReg;
volatile static int count, tx_count, rx_count;


void SetupInterrupt(){

		int Status;
		XScuGic InterruptController;
		XScuGic_Config *GicConfig;

		UART_Init(&UARTInstance, UART_BASE_ADDR);

		GicConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
		Status = XScuGic_CfgInitialize(&InterruptController,GicConfig, GicConfig->CpuBaseAddress);
		if ( Status != XST_SUCCESS) return XST_FAILURE;

		Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
					(Xil_ExceptionHandler)XScuGic_InterruptHandler,&InterruptController);
			Xil_ExceptionEnable();


		Status = XScuGic_Connect(&InterruptController,XPAR_FABRIC_UART_0_INTERRUPT_INTR,
						(Xil_ExceptionHandler)DeviceDriverHandler,(void *)&InterruptController);
		if ( Status != XST_SUCCESS) return XST_FAILURE;

		XScuGic_Enable(&InterruptController,XPAR_FABRIC_UART_0_INTERRUPT_INTR);

		return Status;

}


int main(void){



	UART_GlobalEnableInterrupt(&UARTInstance,0x1);
	UART_EnableInterrupt(&UARTInstance,INT_MASK);


	int i=1;
	count=0;


	UART_SetData(&UARTInstance,0xF);
	UART_Start(&UARTInstance);

	printf("Dato inviato.... attendo interrupt\n\n");


	while(i>0){
			;
	}

	return 0;
}

void DeviceDriverHandler()
{
	count++;
	UART_GlobalDisableInterrupt(&UARTInstance,0x1);
	pendingReg = UART_GetPending(&UARTInstance);
	printf("PENDING REG :%08x \n\n",pendingReg);

	if(pendingReg == 0x00000002)
		ISR_RX();
	else if(pendingReg == 0x00000001)
		ISR_TX();
	UART_GlobalEnableInterrupt(&UARTInstance,0x1);
}

void ISR_TX(){
	printf("******** ISR TX*************\n\n");
	tx_count++;
	UART_ACK(&UARTInstance,0x1);
}

void ISR_RX(){
	printf("******** ISR RX*************\n\n");
	rx_count++;
	UART_ACK(&UARTInstance,0x2);
}