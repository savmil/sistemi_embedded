#include "myIntGPIO2.h"
#include "myIntGPIO.h"
#include "xil_types.h"
#include "xil_io.h"
/**
 * @file myIntGPIO2.c
 * @page driver_GPIO
 * @brief funzioni per abilitare e gestire l' interrupt
 */
/**
 *
 * @brief	Questa funzione abilita i singoli interrupt
 *		scrivendo nel registro reg_intr_en
 *
 * @param	myIntGPIOInstance definisce i registri di quella particolare
 *		istanza del GPIO
 * @param	mask è la maschera dove per ogni valore 
 *		uno presente, abilità l' interrupt associato al valore del
 *		registro reg_intr_en
 *
 * @return	
 *
 * @note
 *
 */
void MYINTGPIO_EnableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	u32 Register;
	unsigned IER_OFFSET = 0x04;
	Register = MYINTGPIO_mReadReg(myIntGPIOInstance->IntAddress,IER_OFFSET);
	MYINTGPIO_mWriteReg(myIntGPIOInstance->IntAddress,IER_OFFSET, Register | mask);

}
/**
 *
 * @brief	Questa funzione disabilita i singoli interrupt
 *		scrivendo nel registro reg_intr_en
 *
 * @param	myIntGPIOInstance definisce i registri di quella particolare
 *		istanza del GPIO
 * @param	mask è la maschera che se pari a 1 abilita l' interrupt globali
 *
 * @return	
 *
 * @note
 *
 */

void MYINTGPIO_GlobalEnableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	u32 Register;
	unsigned GIE_OFFSET = 0x00;
	Register = MYINTGPIO_mReadReg(myIntGPIOInstance->IntAddress,GIE_OFFSET);
	MYINTGPIO_mWriteReg(myIntGPIOInstance->IntAddress,GIE_OFFSET, Register | mask);

}
/**
 *
 * @brief	Questa funzione disabilita tutti gli input globalmente scrivendo 
 *		nel registro reg_global_intr_en
 *
 * @param	myIntGPIOInstance definisce i registri di quella particolare
 *		istanza del GPIO
 * @param	mask è la maschera dove per ogni valore 
 *		uno presente, disabilità l' interrupt associato al valore del
 *		registro reg_intr_en
 * @return	
 *
 * @note
 *
 */

void MYINTGPIO_DisableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	u32 Register;
	unsigned IER_OFFSET = 0x04;
	Register = MYINTGPIO_mReadReg(myIntGPIOInstance->IntAddress,IER_OFFSET);
	MYINTGPIO_mWriteReg(myIntGPIOInstance->IntAddress,IER_OFFSET, Register & (~mask));
}

/**
 *
 * @brief	Questa funzione scrive nel registro reg_intr_ack per avvisare
 * 		la periferica di aver servito l' interrupt
 *
 * @param	myIntGPIOInstance definisce i registri di quella particolare
 *		istanza del GPIO
 * @param	mask è la maschera dove per ogni valore 
 *		uno presente, asserisce il segnale di ack per interrupt associato 
 *		al valore del registro reg_intr_ack
 * @return	
 *
 * @note
 *
 */
void MYINTGPIO_ACK(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	u32 Register;
	unsigned ACK_OFFSET = 0x0C;
	Register = MYINTGPIO_mReadReg(myIntGPIOInstance->IntAddress,ACK_OFFSET);
	MYINTGPIO_mWriteReg(myIntGPIOInstance->IntAddress,ACK_OFFSET, Register | mask);
}
/**
 *
 * @brief	Questa funzione setta la maschera del componente detector per
 *		decidere di quali componenti campionare il segnale di
 *		interrupt
 *
 * @param	myIntGPIOInstance definisce i registri di quella particolare
 *		istanza del GPIO
 * @param	mask è la maschera dove per ogni valore 
 *		uno presente, asserisce il segnale di interrupt da campionare
 * @return	
 *
 * @note
 *
 */
void MYINTGPIO_SetMask(myIntGPIO * myIntGPIOInstance, u32 mask){
		u32 Register;
		unsigned MASK_OFFSET = 0x08;
		Register = MYINTGPIO_mReadReg(myIntGPIOInstance->BaseAddress,MASK_OFFSET);
		MYINTGPIO_mWriteReg(myIntGPIOInstance->BaseAddress,MASK_OFFSET, Register | mask);
}
/**
 *
 * @brief	Questa funzione scrive nel registro reg_intr_ack per avvisare
 * 		la periferica di aver servito l' interrupt
 *
 * @param	myIntGPIOInstance definisce i registri di quella particolare
 *		istanza del GPIO
 * @param	baseaddr definisce l' indirizzo base della periferica
 * @param	intaddr definisce l' indirizzo base per la gestione degli interrupt
 * @return	
 *
 * @note
 *
 */
void MYINTGPIO_Init(myIntGPIO * myIntGPIOInstance, u32 baseaddr, u32 intaddr){
	myIntGPIOInstance->BaseAddress=baseaddr;
	myIntGPIOInstance->IntAddress=intaddr;
}

