#include "myuart.h"
#include "UART.h"
#include "xil_io.h"
#include "xil_exception.h"
#include "xparameters.h"
#include "xil_cache.h"
#include "xil_printf.h"
#include "xil_types.h"
#include "xscugic.h"

/**
 * @file myuart.c
 * @page driver_UART
 * @brief Funzioni per l'utilizzo della periferiferica UART
 */


/**
 *
 * @brief	Permette di abilitare l'interruzione del componente UART. 
 *
 * @param UARTInstance rappresenta la particolare instanza del componente UART.
 *	
 * @param	Maschera per abilitare le interruzioni. Scrivere il valore binario 1 
 *		per abilitare le interruzioni.
 *
 *
 * @return	none
 *
 * @note
 *
 */
void UART_GlobalEnableInterrupt(UART * UARTInstance, u32 mask){
	
	u32 Register;
	unsigned GLOBAL_INT_OFFSET = GLOBAL_INTR;
	Register = UART_mReadReg(UARTInstance->BaseAddress,GLOBAL_INT_OFFSET);
	UART_mWriteReg(UARTInstance->BaseAddress, GLOBAL_INT_OFFSET, Register | mask);
}


/**
 *
 * @brief	Permette di disabilitare l'interruzione del componente UART. 
 *
 * @param UARTInstance rappresenta la particolare instanza del componente UART.
 *	
 * @param	Maschera per disabilitare le interruzioni. Scrivere il valore binario 1 
 *		per disabilitare le interruzioni.
 *
 *
 * @return	none
 *
 * @note
 *
 */
void UART_GlobalDisableInterrupt(UART * UARTInstance, u32 mask)
{
	u32 Register;
	unsigned GLOBAL_INT_OFFSET = GLOBAL_INTR;
	Register = UART_mReadReg(UARTInstance->BaseAddress,GLOBAL_INT_OFFSET);
	UART_mWriteReg(UARTInstance->BaseAddress,GLOBAL_INT_OFFSET, Register & (~mask));
}


/**
 *
 * @brief	Permette di abilitare le singole linee di interruzione del componente UART. 
 *					La linea 0 corrisponde all'interruzione per  trasmissione carattere completata.
*					La linea 1 corrisponde all'interruzione per ricezione carattere completata.
 *
 * @param UARTInstance rappresenta la particola instanza del componente UART.
 *	
 * @param	Maschera per abilitare le linee di interruzioni. Scirvere 1 al bit 0 per abilitare
 *						interruzione trasmissione, 1 al bit 1 per abilitare interruzione ricezione
 *
 *
 * @return	none
 *
 * @note
 *
 */
void UART_EnableInterrupt(UART * UARTInstance, u32 mask){
	
	u32 Register;
	unsigned INT_OFFSET = INTR_MASK;
	Register = UART_mReadReg(UARTInstance->BaseAddress,INT_OFFSET);
	UART_mWriteReg(UARTInstance->BaseAddress, INT_OFFSET, Register | mask);
}



/**
 *
 * @brief	Permette di disabilitare le singole linee di interruzione del componente UART. 
 *					La linea 0 corrisponde all'interruzione per  trasmissione carattere completata.
*					La linea 1 corrisponde all'interruzione per ricezione carattere completata.
 *
 * @param UARTInstance rappresenta la particola instanza del componente UART.
 *	
 * @param	Maschera per disabilitare le linee di interruzioni. Scirvere 1 al bit 0 per disabilitare
 *						interruzione trasmissione, 1 al bit 1 per disabilitare interruzione ricezione
 *
 *
 * @return	none
 *
 * @note
 *
 */
void UART_DisableInterrupt(UART * UARTInstance, u32 mask)
{
	u32 Register;
	unsigned INT_OFFSET = INTR_MASK;
	Register = UART_mReadReg(UARTInstance->BaseAddress,INT_OFFSET);
	UART_mWriteReg(UARTInstance->BaseAddress,INT_OFFSET, Register & (~mask));
}


/**
 *
 * @brief	Permette di dare ACK per processare le singole linee di interruzione del componente UART. 
 *					L'ACK rimuove la corrisponde interruzione pendente.
 *					La linea 0 corrisponde all'interruzione per  trasmissione carattere completata.
 *					La linea 1 corrisponde all'interruzione per ricezione carattere completata.
 *
 * @param UARTInstance rappresenta la particola instanza del componente UART.
 *	
 * @param	Maschera per dare ACK . Scirvere 1 al bit 0 per ACK
 *						su interruzione trasmissione, 1 al bit 1 per ACK su interruzione ricezione
 *
 *
 * @return	none
 *
 * @note
 *
 */
void UART_ACK(UART * UARTInstance, u32 mask){
	
	u32 Register;
	unsigned PENDING_ACK_OFFSET = ACK_PENDING_REG;
	Register = UART_mReadReg(UARTInstance->BaseAddress,PENDING_ACK_OFFSET);
	UART_mWriteReg(UARTInstance->BaseAddress, PENDING_ACK_OFFSET, Register | mask);
	usleep(100);
	UART_mWriteReg(UARTInstance->BaseAddress, PENDING_ACK_OFFSET, 0x0);
}

/**
 *
 * @brief	Restituisce la interruzioni del componente UART.  	
 *					Il bit 0 alto indirca interruzione pendente per  trasmissione carattere completata.
 *					Il bit 1 alto indirca interruzione pendente per ricezione carattere completata.
 *
 * @param UARTInstance rappresenta la particola instanza del componente UART.
 *	
 *
 * @return	Valore 32bit del registro delle interruzione pendenti del componente
 *
 * @note
 *
 */

u32 UART_GetPending(UART * UARTInstance)
{
	unsigned PEND_OFFSET = ACK_PENDING_REG;
	return UART_mReadReg(UARTInstance->BaseAddress,PEND_OFFSET);
}


/**
 *
 * @brief	Inizializza la particolare instanza del componente UART.  	
 *			
 *
 * @param baseaddr indica il BASE ADDRES in esadecimane del componente UART da utilizzare.
 *	
 * @return	none
 *
 * @note
 *
 */
void UART_Init(UART * UARTInstance, u32 baseaddr){
	UARTInstance->BaseAddress=baseaddr;
}



/**
 *
 * @brief	Setta il dato (8 bit) da trasmettere. 	
 *
 *
 * @param UARTInstance rappresenta la particola instanza del componente UART.
 *
 *
 * @param data rappresenta il dato da tramsettere. Solo gli 8 LSB verranno trasmessi
 *
 * @return	none
 *
 * @note	Settare il dato prima di iniziare la trasmissione. Il dato non sarà cancellato 
 *					dal registro
 *
 */
void UART_SetData(UART * UARTInstance, u32 data){
	unsigned TX_DATA_OFFSET = TX_DATA;
	UART_mWriteReg(UARTInstance->BaseAddress, TX_DATA_OFFSET, data & 0xFF);
}


/**
 *
 * @brief	Da inizio alla trasmissione. 	
 *
 *
 * @param UARTInstance rappresenta la particola instanza del componente UART.
 *
 *
 * @return	none
 *
 * @note	
 *
 */
void UART_Start(UART * UARTInstance){
	unsigned TX_EN_OFFSET = TX_ENABLE;
	UART_mWriteReg(UARTInstance->BaseAddress, TX_EN_OFFSET,  0x1);
	usleep(50);
	UART_mWriteReg(UARTInstance->BaseAddress, TX_EN_OFFSET,  0x0);

}



/**
 *
 * @brief	Restituisce il registro di stato del componente UART. 	
 *
 *
 * @param UARTInstance rappresenta la particola instanza del componente UART.
 *
 *
 * @return	Valore 32bit del registro di stato.
 *
 * @note	OE _>  			bit 0
 *					FE - >  			bit 1
 *					PE  ->  			bit 2
 *					RDA ->			bit 3
 *					TX_BUSY -> bit 4
 */
u32 UART_GetStatus(UART * UARTInstance){
	unsigned STATUS_REG_OFFSET = STATUS_REG;
	return UART_mReadReg(UARTInstance->BaseAddress,STATUS_REG_OFFSET);
}

/**
 *
 * @brief	Restituisce l'ultimo dato ricevuto del componente UART. 	
 *
 *
 * @param UARTInstance rappresenta la particola instanza del componente UART.
 *
 *
 * @return	Valore 32bit del dato ricevuto
 *
 * @note	Il dato presente nel registro RX_DATA è da considerasi valido se 
 *					nel registro di stato non sono presenti errori. 
 *
 */
u32 UART_GetData(UART * UARTInstance){
	unsigned RX_DATA_OFFSET = RX_DATA;
	return UART_mReadReg(UARTInstance->BaseAddress,RX_DATA_OFFSET);
}

