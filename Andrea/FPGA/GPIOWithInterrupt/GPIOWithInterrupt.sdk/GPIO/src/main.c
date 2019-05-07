#include "gpio_int.h"
#include "xil_io.h"
#include "xil_exception.h"
#include "xparameters.h"
#include "xil_cache.h"
#include "xil_printf.h"
#include "xil_types.h"
#include "xscugic.h"

#define INTC_DEVICE_ID		XPAR_SCUGIC_0_DEVICE_ID
#define BASE_ADDR_GPIO0			0x43C00000
#define BASE_ADDR_GPIO1			0x43C10000
#define BASE_ADDR_GPIO2			0x43C20000


myIntGPIO GPIO_Switch,GPIO_Button,GPIO_Led;

volatile static int InterruptProcessed = FALSE;

void SwitchISR();
void ButtonISR();
void LedISR();

int SetupInterrupt(){

	XScuGic InterruptController;
	XScuGic_Config *GicConfig;
	int Status;

	GicConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
	Status = XScuGic_CfgInitialize(&InterruptController,GicConfig, GicConfig->CpuBaseAddress);
	if ( Status != XST_SUCCESS) return XST_FAILURE;

	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
			(Xil_ExceptionHandler)XScuGic_InterruptHandler,&InterruptController);
	Xil_ExceptionEnable();

	Status = XScuGic_Connect(&InterruptController,XPAR_FABRIC_GPIO_0_INTERRUPT_INTR,
			(Xil_ExceptionHandler)SwitchISR,(void *)&InterruptController);
	if ( Status != XST_SUCCESS) return XST_FAILURE;

	Status = XScuGic_Connect(&InterruptController,XPAR_FABRIC_GPIO_1_INTERRUPT_INTR,
			(Xil_ExceptionHandler)ButtonISR,(void *)&InterruptController);
	if ( Status != XST_SUCCESS) return XST_FAILURE;

	Status = XScuGic_Connect(&InterruptController,XPAR_FABRIC_GPIO_2_INTERRUPT_INTR,
			(Xil_ExceptionHandler)LedISR,(void *)&InterruptController);
	if ( Status != XST_SUCCESS) return XST_FAILURE;


	XScuGic_Enable(&InterruptController,XPAR_FABRIC_GPIO_0_INTERRUPT_INTR);
	XScuGic_Enable(&InterruptController,XPAR_FABRIC_GPIO_1_INTERRUPT_INTR);
	XScuGic_Enable(&InterruptController,XPAR_FABRIC_GPIO_2_INTERRUPT_INTR);


	Status = XST_SUCCESS;

	return Status;
}

int main(void){

	SetupInterrupt();

	XGPIO_Init(&GPIO_Switch, BASE_ADDR_GPIO0);
	XGPIO_Init(&GPIO_Button, BASE_ADDR_GPIO1);
	XGPIO_Init(&GPIO_Led, BASE_ADDR_GPIO2);


	XGPIO_EnableInterrupt(&GPIO_Switch,0xF);
	XGPIO_GlobalEnableInterrupt(&GPIO_Switch,0x01);

	XGPIO_EnableInterrupt(&GPIO_Button,0xF);
	XGPIO_GlobalEnableInterrupt(&GPIO_Button,0x01);

	XGPIO_EnableInterrupt(&GPIO_Led,0xF);
	XGPIO_GlobalEnableInterrupt(&GPIO_Led,0x01);

	int i=1;

	while(i>0){
		if(InterruptProcessed){
			i++;
			InterruptProcessed =FALSE;
		}
	}
}

void SwitchISR(){
	XGPIO_DisableInterrupt(&GPIO_Switch,0x01);
	InterruptProcessed = TRUE;
	print("\n\n**********ISR SWITCH***********\n\n");
	XGPIO_ACK(&GPIO_Switch,0x0F);
	XGPIO_EnableInterrupt(&GPIO_Switch,0x01);
}

void ButtonISR(){
	XGPIO_DisableInterrupt(&GPIO_Button,0x01);
	InterruptProcessed = TRUE;
	print("\n\n**********ISR BUTTON***********\n\n");
	XGPIO_ACK(&GPIO_Button,0x0F);
	XGPIO_EnableInterrupt(&GPIO_Button,0x01);
}

void LedISR(){
	XGPIO_DisableInterrupt(&GPIO_Led,0x01);
	InterruptProcessed = TRUE;
	print("\n\n**********ISR LED***********\n\n");
	XGPIO_ACK(&GPIO_Led,0x0F);
	XGPIO_EnableInterrupt(&GPIO_Led,0x01);
}
