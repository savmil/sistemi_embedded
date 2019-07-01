#include "gpio_int.h"
#include "GPIO.h"
#include "xil_io.h"
#include "xil_exception.h"
#include "xparameters.h"
#include "xil_cache.h"
#include "xil_printf.h"
#include "xil_types.h"
#include "xscugic.h"




/**
 * @file gpio_int.c
 * @page driver_GPIO
 * @brief Funzioni per l'utilizzo della periferiferica GPIO
 */

/**
 *
 * @brief	Setta la direzione del segnale inout del componente GPIO.
 *
 *
 * @param 	myIntGpioInstance rappresenta la particola instanza del componente GPIO.
 *
 * @param	Maschera per il sengale di enable
 *
 *
 * @return	none
 *
 * @note
 *
 */

void XGPIO_SetDirection(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	unsigned DIR_OFFSET = GPIO_S00_AXI_SLV_REG0_OFFSET;
	GPIO_mWriteReg(myIntGPIOInstance->BaseAddress, DIR_OFFSET, mask);
}



/**
 *
 * @brief	Scrive sul sengale di write del componente GPIO.
 *
 *
 * @param 	myIntGpioInstance rappresenta la particola instanza del componente GPIO.
 *
 * @param	Valore da scrivere
 *
 *
 * @return	none
 *
 * @note
 *
 */
void XGPIO_WriteData(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	unsigned WRITE_DATA_OFFSET = GPIO_S00_AXI_SLV_REG1_OFFSET;
	GPIO_mWriteReg(myIntGPIOInstance->BaseAddress, WRITE_DATA_OFFSET, mask);
}

/**
 *
 * @brief	Legge i valori  del sengale di read del componente GPIO.
 *
 *
 * @param 	myIntGpioInstance rappresenta la particola instanza del componente GPIO.
 *
 * @param
 *
 *
 * @return	valore a 32bit del segnale READ
 *
 * @note
 *
 */
uint32_t XGPIO_ReadData(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	unsigned READ_DATA_OFFSET = GPIO_S00_AXI_SLV_REG2_OFFSET;
	return GPIO_mReadReg(myIntGPIOInstance->BaseAddress,READ_DATA_OFFSET);
}



/**
 *
 * @brief	Permette di abilitare le singole linee di interruzione del componente GPIO.
 *
 *
 * @param 	myIntGpioInstance rappresenta la particola instanza del componente GPIO.
 *
 * @param	Maschera per abilitare le linee di interruzioni. La corrispondenza
 * 			bit-linea è posizionale. Scrivere 1 per abilitare la linea nel relativo
 * 			bit
 *
 *
 * @return	none
 *
 * @note	Se le interruzioni globali non saranno attive nessuna linea potrà attivare
 * 			il segnale di interruzione verso il processore
 *
 */
void XGPIO_EnableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	unsigned EN_INT_OFFSET = GPIO_S00_AXI_SLV_REG4_OFFSET;
	GPIO_mWriteReg(myIntGPIOInstance->BaseAddress, EN_INT_OFFSET, mask);

}


/**
 *
 * @brief	Permette di disabilitare le singole linee di interruzione del componente GPIO.
 *
 *
 * @param 	myIntGpioInstance rappresenta la particola instanza del componente GPIO.
 *
 * @param	Maschera per abilitare le linee di interruzioni. La corrispondenza
 * 			bit-linea è posizionale. Scrivere 1 per abilitare la linea nel relativo
 * 			bit
 *
 *
 * @return	none
 *
 * @note	Se le interruzioni globali  saranno attive le altre linee potranno attivare
 * 			il segnale di interruzione verso il processore
 */
void XGPIO_DisableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	u32 Register;
	unsigned EN_INT_OFFSET = GPIO_S00_AXI_SLV_REG4_OFFSET;
	Register = GPIO_mReadReg(myIntGPIOInstance->BaseAddress,EN_INT_OFFSET);
	GPIO_mWriteReg(myIntGPIOInstance->BaseAddress,EN_INT_OFFSET, Register & (~mask));
}


/**
 *
 * @brief	Permette di abilitare l'interruzione del componente GPIO.
 *
 * @param myIntGPIOInstance rappresenta la particolare instanza del componente GPIO.
 *
 * @param	Maschera per abilitare le interruzioni. Scrivere il valore binario 1
 *			per abilitare le interruzioni.
 *
 *
 * @return	none
 *
 * @note	Abilitare le intrruzioni globali fa si che le linee di interuzioni
 * 			interne vengano inserite nel registro delle interruzioni pendenti
 * 			e il segnale IRQ diretto verso il processore possa essere asserito
 * 			se ci sono interruzioni pendenti.
 *
 *
 */
void XGPIO_GlobalEnableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	unsigned GIE_OFFSET = GPIO_S00_AXI_SLV_REG3_OFFSET;
	GPIO_mWriteReg(myIntGPIOInstance->BaseAddress,GIE_OFFSET, mask);

}




/**
 *
 * @brief	Permette di disabilitare l'interruzione del componente GPIO.
 *
 * @param myIntGPIOInstance rappresenta la particolare instanza del componente GPIO.
 *
 * @param	Maschera per disabilitare le interruzioni. Scrivere il valore binario 1
 *			per disablitare le interruzioni.
 *
 *
 * @return	none
 *
 * @note	Disabilitare le intrruzioni globali fa si che le linee di interuzioni
 * 			interne  non vengano inserite nel registro delle interruzioni pendenti
 * 			e il segnale IRQ diretto verso il processore non possa  essere asserito
 * 			se ci sono interruzioni pendenti.
 *
 *
 */
void XGPIO_GlobalDisableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	u32 Register;
	unsigned GIE_OFFSET = GPIO_S00_AXI_SLV_REG3_OFFSET;
	Register = GPIO_mReadReg(myIntGPIOInstance->BaseAddress,GIE_OFFSET);
	GPIO_mWriteReg(myIntGPIOInstance->BaseAddress,GIE_OFFSET, Register & (~mask));
}

/**
 *
 * @brief	Permette di dare ACK per processare le singole linee di interruzione del componente GPIO.
 *			L'ACK rimuove la corrisponde interruzione pendente.
 *
 *
 * @param 	myIntGPIOInstance rappresenta la particola instanza del componente GPIO.
 *
 * @param	Maschera per dare l'ACK .
 *
 * @return	La corrispondenza bit-linea è posizionale. Il valore 1 al bit-iesimo
 * 			indica ack ad interruzione pendente dell'iesima linea.
 *
 * @note
 *
 */

void XGPIO_ACK(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	unsigned ACK_OFFSET = GPIO_S00_AXI_SLV_REG7_OFFSET;
	GPIO_mWriteReg(myIntGPIOInstance->BaseAddress,ACK_OFFSET, mask);
	usleep(100);
	GPIO_mWriteReg(myIntGPIOInstance->BaseAddress,ACK_OFFSET, 0x0);

}


/**
 *
 * @brief			Restituisce le  interruzioni pendenti del componente GPIO.
 *
 * @param 			myIntGpioInstance rappresenta la particola instanza del componente GPIO.
 *
 *
 * @return			Valore 32bit del registro delle interruzione pendenti del componente
 *
 * @note			La corrispondenza bit-linea è posizionale. Il valore 1 al bit-iesimo
 * 					indica interruzione pendente dell'iesima linea.
 *
 */
u32 XGPIO_GetPending(myIntGPIO * myIntGPIOInstance)
{
	unsigned PEND_OFFSET = GPIO_S00_AXI_SLV_REG7_OFFSET;
	return GPIO_mReadReg(myIntGPIOInstance->BaseAddress,PEND_OFFSET);
}


/**
 *
 * @brief			Inizializza una particolare istanza del componente GPIO.
 *
 * @param 			myIntGpioInstance rappresenta la particola instanza del componente GPIO.
 *
 *
 * @return
 *
 * @note
 */
void XGPIO_Init(myIntGPIO * myIntGPIOInstance, u32 baseaddr){
	myIntGPIOInstance->BaseAddress=baseaddr;
}


