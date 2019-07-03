#include "xil_types.h"
#include "xstatus.h"
#include "xil_io.h"



#define TX_DATA			UART_S00_AXI_SLV_REG0_OFFSET
#define TX_ENABLE		UART_S00_AXI_SLV_REG1_OFFSET
#define STATUS_REG		UART_S00_AXI_SLV_REG2_OFFSET
#define RX_DATA			UART_S00_AXI_SLV_REG3_OFFSET
#define GLOBAL_INTR		UART_S00_AXI_SLV_REG4_OFFSET
#define INTR_MASK		UART_S00_AXI_SLV_REG5_OFFSET
#define ACK_PENDING_REG	UART_S00_AXI_SLV_REG7_OFFSET
/**
 * @file myuart.h
 * @brief header file myuart.c
 */
/**
 * Una struttura che definisce gli indirizzi del componente GPIO
 */
typedef struct{
	/*@{*/
	UINTPTR BaseAddress;/**< indirizzo base periferica */
	/*@}*/
} UART;


void UART_GlobalEnableInterrupt(UART * UARTInstance, u32 mask);
void UART_GlobalDisableInterrupt(UART * UARTInstance, u32 mask);
void UART_EnableInterrupt(UART * UARTInstance, u32 mask);
void UART_DisableInterrupt(UART * UARTInstance, u32 mask);
void UART_ACK(UART * UARTInstance, u32 mask);
u32 UART_GetPending(UART * MY_UART_INTInstance);

void UART_Init(UART * UARTInstance, u32 baseaddr);
void UART_SetData(UART * UARTInstance, u32 data);
void UART_Start(UART * UARTInstance);
u32 UART_GetStatus(UART * MY_UART_INTInstance);
u32 UART_GetData(UART * MY_UART_INTInstance);
