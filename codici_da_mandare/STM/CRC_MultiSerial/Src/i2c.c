/**
  ******************************************************************************
  * @file           : i2c.c
  * Permette la configurazione della periferica I2C
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "i2c.h"

I2C_HandleTypeDef hi2c2;

/**
 * @brief  Funzione di configurazione della periferica I2C
 * @param  nodeAddress setta l' indentificativo del nodo 
 * @param  groupAddress setta l' identificato del gruppo
 * a cui il nodo appartiene
 */
void MX_I2C2_Init(uint16_t nodeAddress, uint16_t groupAddress)
{

  hi2c2.Instance = I2C2;
  hi2c2.Init.Timing = I2C_TIMING;  //0x2000090E;
  hi2c2.Init.OwnAddress1 = nodeAddress;
  hi2c2.Init.AddressingMode = I2C_ADDRESSINGMODE_10BIT;

  hi2c2.Init.DualAddressMode = I2C_DUALADDRESS_ENABLE;
  hi2c2.Init.OwnAddress2 = groupAddress;

/** da ack confrontando tutti i 7 bit dell'addres ricevuto con quelli di ownAddress2. utilizzato per realizzare multicast */
  hi2c2.Init.OwnAddress2Masks = I2C_OA2_NOMASK;

/** abilita generic call address. Permette di realizzare broadcast su address 0x00 */
  hi2c2.Init.GeneralCallMode = I2C_GENERALCALL_ENABLE;

  hi2c2.Init.NoStretchMode = I2C_NOSTRETCH_DISABLE;

  if (HAL_I2C_Init(&hi2c2) != HAL_OK)
	  Error_Handler();

  if (HAL_I2CEx_ConfigAnalogFilter(&hi2c2, I2C_ANALOGFILTER_ENABLE) != HAL_OK)
	  Error_Handler();

  if (HAL_I2CEx_ConfigDigitalFilter(&hi2c2, 0) != HAL_OK)
	  Error_Handler();

}
/**
 * @brief  Configura opportunamente l' handler della periferica I2C
 * ed i pin associati ad essa
 * @param  i2cHandle handler della periferica I2C
 */
void HAL_I2C_MspInit(I2C_HandleTypeDef* i2cHandle)
{

  GPIO_InitTypeDef GPIO_InitStruct = {0};
  if(i2cHandle->Instance==I2C2)
  {

    __HAL_RCC_GPIOA_CLK_ENABLE();

    GPIO_InitStruct.Pin = GPIO_PIN_9|GPIO_PIN_10;
    GPIO_InitStruct.Mode = GPIO_MODE_AF_OD;
    GPIO_InitStruct.Pull = GPIO_PULLUP;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
    GPIO_InitStruct.Alternate = GPIO_AF4_I2C2;
    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

    /* I2C2 clock enable */
    __HAL_RCC_I2C2_CLK_ENABLE();

    /* I2C2 interrupt Init */
    HAL_NVIC_SetPriority(I2C2_EV_IRQn, 0, 0);
    HAL_NVIC_EnableIRQ(I2C2_EV_IRQn);
    HAL_NVIC_SetPriority(I2C2_ER_IRQn, 0, 0);
    HAL_NVIC_EnableIRQ(I2C2_ER_IRQn);

  }
}
/**
 * @brief  Disabilita la periferica CAN
 * @param  canHandle handler della periferica CAN
 */
void HAL_I2C_MspDeInit(I2C_HandleTypeDef* i2cHandle)
{

  if(i2cHandle->Instance==I2C2)
  {

    /* Peripheral clock disable */
    __HAL_RCC_I2C2_CLK_DISABLE();
  
    HAL_GPIO_DeInit(GPIOA, GPIO_PIN_9|GPIO_PIN_10);

    /* I2C2 interrupt Deinit */
    HAL_NVIC_DisableIRQ(I2C2_EV_IRQn);
    HAL_NVIC_DisableIRQ(I2C2_ER_IRQn);

  }
}
