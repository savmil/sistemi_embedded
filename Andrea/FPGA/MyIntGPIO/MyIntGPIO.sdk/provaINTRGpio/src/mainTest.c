#include <stdio.h>
#include <stdlib.h>
#include "xil_io.h"
#include "xil_exception.h"
#include "xparameters.h"
#include "xil_cache.h"
#include "xil_printf.h"
#include "xil_types.h"
#include "xscugic.h"

#include "myIntGPIO2.h"

/************************** Constant Definitions *****************************/

#define INTC_DEVICE_ID		XPAR_SCUGIC_0_DEVICE_ID

#define GPIOSWITCH_INT_ADDR	0x43C10000
#define GPIOSWITCH_BASE_ADDR	0x43C00000

#define GPIOBUTTON_INT_ADDR	0x43C30000
#define GPIOBUTTON_BASE_ADDR	0x43C20000

#define GPIOLED_INT_ADDR	0x43C50000
#define GPIOLED_BASE_ADDR	0x43C40000

/**************************** Type Definitions *******************************/
void SwitchISR();
void ButtonISR();
void LedISR();

myIntGPIO GPIO_Switch,GPIO_Button,GPIO_Led;

volatile static int InterruptProcessed = FALSE;


int main(void)
{
	int Status;


	XScuGic InterruptController;
	XScuGic_Config *GicConfig;


	/*inizializzazione GPIO*/
	MYINTGPIO_Init(&GPIO_Switch,GPIOSWITCH_BASE_ADDR,GPIOSWITCH_INT_ADDR);
	MYINTGPIO_Init(&GPIO_Button,GPIOBUTTON_BASE_ADDR,GPIOBUTTON_INT_ADDR);
	MYINTGPIO_Init(&GPIO_Led,GPIOLED_BASE_ADDR,GPIOLED_INT_ADDR);


	GicConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
	Status = XScuGic_CfgInitialize(&InterruptController,GicConfig, GicConfig->CpuBaseAddress);
	if ( Status != XST_SUCCESS) return XST_FAILURE;


	//Enable interrupt on device
	MYINTGPIO_EnableInterrupt(&GPIO_Switch,0x1);
	MYINTGPIO_GlobalEnableInterrupt(&GPIO_Switch,0x01);

	MYINTGPIO_EnableInterrupt(&GPIO_Button,0x1);
	MYINTGPIO_GlobalEnableInterrupt(&GPIO_Button,0x01);

	MYINTGPIO_EnableInterrupt(&GPIO_Led,0x1);
	MYINTGPIO_GlobalEnableInterrupt(&GPIO_Led,0x01);


	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
			(Xil_ExceptionHandler)XScuGic_InterruptHandler,&InterruptController);
	Xil_ExceptionEnable();


	Status = XScuGic_Connect(&InterruptController,XPAR_FABRIC_MYINTGPIO_0_IRQ_INTR,
			(Xil_ExceptionHandler)SwitchISR,(void *)&InterruptController);
	if ( Status != XST_SUCCESS) return XST_FAILURE;

	Status = XScuGic_Connect(&InterruptController,XPAR_FABRIC_MYINTGPIO_1_IRQ_INTR,
			(Xil_ExceptionHandler)ButtonISR,(void *)&InterruptController);
	if ( Status != XST_SUCCESS) return XST_FAILURE;

	Status = XScuGic_Connect(&InterruptController,XPAR_FABRIC_MYINTGPIO_2_IRQ_INTR,
			(Xil_ExceptionHandler)LedISR,(void *)&InterruptController);
	if ( Status != XST_SUCCESS) return XST_FAILURE;


	MYINTGPIO_EnableInterrupt(&GPIO_Switch,0x1);
	MYINTGPIO_EnableInterrupt(&GPIO_Button,0x1);
	MYINTGPIO_EnableInterrupt(&GPIO_Led,0x1);


	MYINTGPIO_SetMask(&GPIO_Switch, 0xF);
	MYINTGPIO_SetMask(&GPIO_Button, 0xF);
	MYINTGPIO_SetMask(&GPIO_Led, 0xF);

	XScuGic_Enable(&InterruptController,XPAR_FABRIC_MYINTGPIO_0_IRQ_INTR);
	XScuGic_Enable(&InterruptController,XPAR_FABRIC_MYINTGPIO_1_IRQ_INTR);
	XScuGic_Enable(&InterruptController,XPAR_FABRIC_MYINTGPIO_2_IRQ_INTR);


//	XScuGic_SetPriorityTriggerType(&InterruptController,XPAR_FABRIC_myIntGPIO_0_INTERRUPT_INTR,0x3,0x3);

	int i=1;

	print("Iniziailizzazione completata....wait for interrupt\n");


	while(i>0){
		if(InterruptProcessed){
		i++;
		InterruptProcessed =FALSE;
		}
		}
}




void SwitchISR()
{
	MYINTGPIO_DisableInterrupt(&GPIO_Switch,0x01);
	InterruptProcessed = TRUE;
	print("\n\n**********ISR SWITCH***********\n\n");
	MYINTGPIO_ACK(&GPIO_Switch,0x01);
	MYINTGPIO_EnableInterrupt(&GPIO_Switch,0x01);
}

void ButtonISR()
{
	MYINTGPIO_DisableInterrupt(&GPIO_Button,0x01);
	InterruptProcessed = TRUE;
	print("\n\n**********ISR BUTTON***********\n\n");
	MYINTGPIO_ACK(&GPIO_Button,0x01);
	MYINTGPIO_EnableInterrupt(&GPIO_Button,0x01);
}

void LedISR()
{
	MYINTGPIO_DisableInterrupt(&GPIO_Led,0x01);
	InterruptProcessed = TRUE;
	print("\n\n**********ISR LED***********\n\n");
	MYINTGPIO_ACK(&GPIO_Led,0x01);
	MYINTGPIO_EnableInterrupt(&GPIO_Led,0x01);
}
