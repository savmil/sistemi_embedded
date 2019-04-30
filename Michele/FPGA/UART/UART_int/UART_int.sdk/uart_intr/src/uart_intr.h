/*
 * uart_intr.h
 *
 *  Created on: 27 apr 2019
 *      Author: michele
 */

#ifndef SRC_UART_INTR_H_
#define SRC_UART_INTR_H_

#include "xil_types.h"
#include "xstatus.h"
#include "xil_io.h"

typedef struct{
	UINTPTR BaseAddress;
	UINTPTR IntAddress;
} myIntUART;


void MYINTUART_EnableInterrupt(myIntUART * myIntUARTInstance, u32 mask);
void MYINTUART_ACK(myIntUART * myIntUARTInstance, u32 mask);
void MYINTUART_GlobalEnableInterrupt(myIntUART * myIntUARTInstance, u32 mask);
void MYINTUART_DisableInterrupt(myIntUART * myIntUARTInstance, u32 mask);
void MYINTUART_setData(myIntUART * myIntUARTInstance, u32 mask);
void MYINTUART_Init(myIntUART * myIntUARTInstance, u32 baseaddr, u32 intaddr);
void MYINTUART_Start(myIntUART * myIntUARTInstance);
u32 MYINTUART_GetStatus(myIntUART * MY_UART_INTInstance);
void MYINTUART_Stop(myIntUART * MY_UART_INTInstance);
u32 MYINTUART_GetData(myIntUART * MY_UART_INTInstance);
u32 MYINTUART_GetPending(myIntUART * MY_UART_INTInstance);


#endif /* SRC_UART_INTR_H_ */
