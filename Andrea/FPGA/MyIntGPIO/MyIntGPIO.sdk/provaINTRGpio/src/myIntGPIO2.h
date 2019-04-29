#include "xil_types.h"
#include "xstatus.h"
#include "xil_io.h"

typedef struct{
	UINTPTR BaseAddress;
	UINTPTR IntAddress;
} myIntGPIO;


void MYINTGPIO_EnableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask);
void MYINTGPIO_ACK(myIntGPIO * myIntGPIOInstance, u32 mask);
void MYINTGPIO_GlobalEnableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask);
void MYINTGPIO_DisableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask);
void MYINTGPIO_SetMask(myIntGPIO * myIntGPIOInstance, u32 mask);
void MYINTGPIO_Init(myIntGPIO * myIntGPIOInstance, u32 baseaddr, u32 intaddr);
