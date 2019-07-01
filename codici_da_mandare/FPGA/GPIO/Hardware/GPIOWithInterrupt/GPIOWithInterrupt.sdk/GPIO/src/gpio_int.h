#include "xil_types.h"
#include "xstatus.h"
#include "xil_io.h"
/**
 * @file gpio_int.h
 * @brief header gpio_int.c
 */
typedef struct{
	UINTPTR BaseAddress;
} myIntGPIO;

void XGPIO_Init(myIntGPIO * myIntGPIOInstance, u32 baseaddr);
void XGPIO_EnableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask);
void XGPIO_DisableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask);
void XGPIO_ACK(myIntGPIO * myIntGPIOInstance, u32 mask);
void XGPIO_GlobalEnableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask);
void XGPIO_GlobalDisableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask);
void XGPIO_WriteData(myIntGPIO * myIntGPIOInstance, u32 mask);
u32 XGPIO_GetPending(myIntGPIO * myIntGPIOInstance);
