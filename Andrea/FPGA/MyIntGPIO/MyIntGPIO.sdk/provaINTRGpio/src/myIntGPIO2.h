#include "xil_types.h"
#include "xstatus.h"
#include "xil_io.h"
/**
 * Una struttura che definisce gli indirizzi del componente GPIO
 */
typedef struct{
	/*@{*/
	UINTPTR BaseAddress;/**< indirizzo base periferica */
	UINTPTR IntAddress;/**< indirizzo base per gestire le interruzioni */
	/*@}*/
} myIntGPIO;


void MYINTGPIO_EnableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask);
void MYINTGPIO_ACK(myIntGPIO * myIntGPIOInstance, u32 mask);
void MYINTGPIO_GlobalEnableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask);
void MYINTGPIO_DisableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask);
void MYINTGPIO_SetMask(myIntGPIO * myIntGPIOInstance, u32 mask);
void MYINTGPIO_Init(myIntGPIO * myIntGPIOInstance, u32 baseaddr, u32 intaddr);
