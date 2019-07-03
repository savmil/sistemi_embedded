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

#define UART0_BASE_ADDR		0x43C00000
#define UART1_BASE_ADDR		0x43C10000

#define INT_MASK_TX			0x1
#define INT_MASK_RX			0x2
/**************************** Type Definitions *******************************/

void DeviceDriverHandler0();
void DeviceDriverHandler1();
void ISR_TX(UART UARTInstance);
void ISR_RX(UART UARTInstance);

UART UARTInstance0,UARTInstance1;

u32 pendingReg, dataReg;
volatile static int count0,count1, tx_count, rx_count;
XScuGic InterruptController;
XScuGic_Config *GicConfig;
int i=1;


/**
 *
 * @brief	Effettua la configurazione e l'abilitazione del GIC.
 *
 * @return	XST_SUCCESS se la configurazione è avvenuta correttamente
 * 			XST_FAILURE altrimenti
 *
 * @note
 *
 */
int SetupInterrupt(){

		int Status;

		//inizializzazione driver xscugic per la gestione del gic
		GicConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
		Status = XScuGic_CfgInitialize(&InterruptController,GicConfig, GicConfig->CpuBaseAddress);
		if ( Status != XST_SUCCESS) return XST_FAILURE;

		//abilita la gestione delle eccezioni relative alla lina di interruzione in ingresso.
		Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
				(Xil_ExceptionHandler)XScuGic_InterruptHandler,&InterruptController);
		Xil_ExceptionEnable();

		//Associa l'handler definito dall'utente alla linea di interruzione in ingresso al gic
		//relativa al componente.
		Status = XScuGic_Connect(&InterruptController,XPAR_FABRIC_UART_0_INTERRUPT_INTR,
				(Xil_ExceptionHandler)DeviceDriverHandler0,(void *)&InterruptController);
		if ( Status != XST_SUCCESS) return XST_FAILURE;


		Status = XScuGic_Connect(&InterruptController,XPAR_FABRIC_UART_1_INTERRUPT_INTR,
						(Xil_ExceptionHandler)DeviceDriverHandler1,(void *)&InterruptController);
				if ( Status != XST_SUCCESS) return XST_FAILURE;

		//Abilita la linea di interruzione del gic relativa al componente mappato
		XScuGic_Enable(&InterruptController,XPAR_FABRIC_UART_0_INTERRUPT_INTR);
		XScuGic_Enable(&InterruptController,XPAR_FABRIC_UART_1_INTERRUPT_INTR);

		return Status;


}


int main(void){

	//Configurazione ed enable del Gic
	if(SetupInterrupt() != XST_SUCCESS)
		return XST_FAILURE;

	//Init della struttura dati che astrae il componente UART
	UART_Init(&UARTInstance0, UART0_BASE_ADDR);
	UART_Init(&UARTInstance1, UART1_BASE_ADDR);


	//Abilitazione delle interruzioni globali del componente e delle singole linee interne di interrupt
	UART_GlobalEnableInterrupt(&UARTInstance0,0x1);
	UART_EnableInterrupt(&UARTInstance0,INT_MASK_RX);

	UART_GlobalEnableInterrupt(&UARTInstance1,0x1);
	UART_EnableInterrupt(&UARTInstance1,INT_MASK_TX);


	//contatore utilizzato per verificare il corretto funzionamento del dispositivo.
	//indica il numero di volte che l'handler è stato chiamato.
	count0=0;
	count1=0;

	//invio di prova
	UART_SetData(&UARTInstance1,0xF);
	UART_Start(&UARTInstance1);

	while(i>0){
		i++;
	}

	return 0;
}

void DeviceDriverHandler0()
{

	count0++;
	//vengono disabilitate le intrruzioni globali del componente
	UART_GlobalDisableInterrupt(&UARTInstance0,0x1);
	pendingReg = UART_GetPending(&UARTInstance0);
	printf("PENDING REG :%08x \n\n",pendingReg);

	/*	avendo una sola linea di interruzione diretta verso il processore
		è necessario identificare quale delle due linee interne ha
		attivato la linea IRQ. Nel fare questo è necessario esplicitare uno
		schema di priorità interno di gestione delle interruzioini.
		In questo caso viene gestita prima l'interruzione relativa alla linea RX
	*/

	if((pendingReg & 0x00000002) == 0x00000002)
		ISR_RX(UARTInstance0);
	else if((pendingReg & 0x00000001) == 0x00000001){
		ISR_TX(UARTInstance0);
		}


	//abilitazione interruzioni globali del componente
	UART_GlobalEnableInterrupt(&UARTInstance0,0x1);
}


void DeviceDriverHandler1()
{

	count1++;
	//vengono disabilitate le intrruzioni globali del componente
	UART_GlobalDisableInterrupt(&UARTInstance1,0x1);
	pendingReg = UART_GetPending(&UARTInstance1);
	printf("PENDING REG :%08x \n\n",pendingReg);

	/*	avendo una sola linea di interruzione diretta verso il processore
		è necessario identificare quale delle due linee interne ha
		attivato la linea IRQ. Nel fare questo è necessario esplicitare uno
		schema di priorità interno di gestione delle interruzioini.
		In questo caso viene gestita prima l'interruzione relativa alla linea RX
	*/

	if((pendingReg & 0x00000002) == 0x00000002)
		ISR_RX(UARTInstance1);
	else if((pendingReg & 0x00000001) == 0x00000001){
		ISR_TX(UARTInstance1);												
		if(tx_count<5){
		UART_SetData(&UARTInstance1,0xF);
		UART_Start(&UARTInstance1);}
	}
	//abilitazione interruzioni globali del componente
	UART_GlobalEnableInterrupt(&UARTInstance1,0x1);
}


void ISR_TX(UART UARTInstance){
	printf("******** ISR TX*************\n\n");
	tx_count++;
	//ACK interruzione relativa a TX
	UART_ACK(&UARTInstance,0x1);
}

void ISR_RX(UART UARTInstance){
	printf("******** ISR RX*************\n\n");
	rx_count++;
	//ACK interruzione relativa a RX
	UART_ACK(&UARTInstance,0x2);
}