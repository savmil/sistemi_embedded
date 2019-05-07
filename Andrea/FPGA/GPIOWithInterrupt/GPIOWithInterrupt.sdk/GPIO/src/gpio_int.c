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
void XGPIO_SetDirection(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	u32 Register;
	unsigned DIR_OFFSET = GPIO_S00_AXI_SLV_REG0_OFFSET;
	Register = GPIO_mReadReg(myIntGPIOInstance->BaseAddress,DIR_OFFSET);
	GPIO_mWriteReg(myIntGPIOInstance->BaseAddress, DIR_OFFSET, Register | mask);
}

void XGPIO_WriteData(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	unsigned WRITE_DATA_OFFSET = GPIO_S00_AXI_SLV_REG1_OFFSET;
	GPIO_mWriteReg(myIntGPIOInstance->BaseAddress, WRITE_DATA_OFFSET, mask);
}
/**
 *
 * @brief	Questa funzione abilita i singoli interrupt
 *		scrivendo nel registro
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
void XGPIO_EnableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	u32 Register;
	unsigned EN_INT_OFFSET = GPIO_S00_AXI_SLV_REG4_OFFSET;
	Register = GPIO_mReadReg(myIntGPIOInstance->BaseAddress,EN_INT_OFFSET);
	GPIO_mWriteReg(myIntGPIOInstance->BaseAddress, EN_INT_OFFSET, Register | mask);

}
/**
 *
 * @brief	Questa funzione disabilita i singoli interrupt
 *		scrivendo nel registro
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
void XGPIO_DisableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	u32 Register;
	unsigned EN_INT_OFFSET = GPIO_S00_AXI_SLV_REG4_OFFSET;
	Register = GPIO_mReadReg(myIntGPIOInstance->BaseAddress,EN_INT_OFFSET);
	GPIO_mWriteReg(myIntGPIOInstance->BaseAddress,EN_INT_OFFSET, Register & (~mask));
}

/**
 *
 * @brief	Questa funzione abilita tutti gli input globalmente scrivendo 
 *		nel registro 
 *
 * @param	myIntGPIOInstance definisce i registri di quella particolare
 *		istanza del GPIO
 * @param	mask è la maschera dove per ogni valore 
 *		uno presente viene abilitato l' interrupt corrispondente
 * @return	
 *
 * @note
 *
 */
void XGPIO_GlobalEnableInterrupt(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	u32 Register;
	unsigned GIE_OFFSET = GPIO_S00_AXI_SLV_REG3_OFFSET;
	Register = GPIO_mReadReg(myIntGPIOInstance->BaseAddress,GIE_OFFSET);
	GPIO_mWriteReg(myIntGPIOInstance->BaseAddress,GIE_OFFSET, Register | mask);

}
/**
 *
 * @brief	Questa funzione disabilita tutti gli input globalmente scrivendo 
 *		nel registro
 *
 * @param	myIntGPIOInstance definisce i registri di quella particolare
 *		istanza del GPIO
 * @param	mask è la maschera dove per ogni valore 
 *		uno presente viene disabilitato l' interrupt corrispondente
 * @return	
 *
 * @note
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
 * @brief	Questa funzione avvisa la periferica di aver servito l' interrupt
 *
 * @param	myIntGPIOInstance definisce i registri di quella particolare
 *		istanza del GPIO
 * @param	mask è la maschera dove per ogni valore 
 *		uno presente, asserisce il segnale di ack per interrupt associato 
 *		a tale valore della maschera
 * @return	
 *
 * @note
 *
 */
void XGPIO_ACK(myIntGPIO * myIntGPIOInstance, u32 mask)
{
	u32 Register;
	unsigned ACK_OFFSET = GPIO_S00_AXI_SLV_REG7_OFFSET;
	Register = GPIO_mReadReg(myIntGPIOInstance->BaseAddress,ACK_OFFSET);
	GPIO_mWriteReg(myIntGPIOInstance->BaseAddress,ACK_OFFSET, Register | mask);
//	usleep(100);
	GPIO_mWriteReg(myIntGPIOInstance->BaseAddress,ACK_OFFSET, 0x0);

}
/**
 *
 * @brief	Questa funzione restituisce il valore del registro
 *
 * @param	myIntGPIOInstance definisce i registri di quella particolare
 *		istanza del GPIO
 * @return	il valore del registro pending
 *
 * @note
 *
 */
u32 XGPIO_GetPending(myIntGPIO * myIntGPIOInstance)
{
	unsigned PEND_OFFSET = GPIO_S00_AXI_SLV_REG7_OFFSET;
	return GPIO_mReadReg(myIntGPIOInstance->BaseAddress,PEND_OFFSET);
}
/**
 *
 * @brief	Questa funzione scrive nel registro reg_intr_ack per avvisare
 * 		la periferica di aver servito l' interrupt
 *
 * @param	myIntGPIOInstance definisce i registri di quella particolare
 *		istanza del GPIO
 * @param	baseaddr definisce l' indirizzo base della periferica
 * @return	
 *
 * @note
 *
 */
void XGPIO_Init(myIntGPIO * myIntGPIOInstance, u32 baseaddr){
	myIntGPIOInstance->BaseAddress=baseaddr;
}


