/**
  ******************************************************************************
  * @file           : gpio.c
  * Configura i banchi di GPIO
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "gpio.h"

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */


/* GPIO init function */

/**
 * @brief  Funzione di configurazione dei vari banchi di GPIO
 * @param
 */
void MX_GPIO_Init(void)
{

  GPIO_InitTypeDef GPIO_InitStruct = {0};

  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOC_CLK_ENABLE();
  __HAL_RCC_GPIOF_CLK_ENABLE();
  __HAL_RCC_GPIOA_CLK_ENABLE();
  __HAL_RCC_GPIOE_CLK_ENABLE();
  __HAL_RCC_GPIOB_CLK_ENABLE();
  __HAL_RCC_GPIOD_CLK_ENABLE();

  /*Configure GPIO pin Output Level */
  HAL_GPIO_WritePin(GPIOE, LED4_BLUE_Pin|LED3_RED_Pin|LED5_ORANGE_Pin|LED7_GREEN_Pin 
                          |LED9_BLUE_Pin|LED10_RED_Pin|LED8_ORANGE_Pin|LED6_GREEN_Pin, GPIO_PIN_RESET);

  /*Configure GPIO pin Output Level */
  HAL_GPIO_WritePin(SPI_EN_OUTPUT_GPIO_Port, SPI_EN_OUTPUT_Pin, GPIO_PIN_SET);

  /*Configure GPIO pin : PtPin */
  GPIO_InitStruct.Pin = USER_BTN_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_IT_RISING;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  HAL_GPIO_Init(USER_BTN_GPIO_Port, &GPIO_InitStruct);

  /*Configure GPIO pins : PEPin PEPin PEPin PEPin 
                           PEPin PEPin PEPin PEPin */
  GPIO_InitStruct.Pin = LED4_BLUE_Pin|LED3_RED_Pin|LED5_ORANGE_Pin|LED7_GREEN_Pin 
                          |LED9_BLUE_Pin|LED10_RED_Pin|LED8_ORANGE_Pin|LED6_GREEN_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  HAL_GPIO_Init(GPIOE, &GPIO_InitStruct);

  /*Configure GPIO pin : PtPin */
  GPIO_InitStruct.Pin = SPI_EN_OUTPUT_Pin;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  HAL_GPIO_Init(SPI_EN_OUTPUT_GPIO_Port, &GPIO_InitStruct);


  /*Configure GPIO pin : PtPin */
  GPIO_InitStruct.Pin = GPIO_PIN_12;
  GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
  GPIO_InitStruct.Alternate = GPIO_AF5_SPI2;
  HAL_GPIO_Init(GPIOB, &GPIO_InitStruct);


  /* EXTI interrupt init*/
  HAL_NVIC_SetPriority(EXTI0_IRQn, 0, 0);
  HAL_NVIC_EnableIRQ(EXTI0_IRQn);

}

/* USER CODE BEGIN 2 */
/**
 * @brief Spegne tutti i led che sono utilizzati nel codice
 * @param
 */
void LedOff(){
    HAL_Delay(1000);
    //Spegnimento di tutti i led
    HAL_GPIO_WritePin(GPIOE, LED4_BLUE_Pin|LED3_RED_Pin|LED5_ORANGE_Pin|LED7_GREEN_Pin
    	                            |LED9_BLUE_Pin|LED10_RED_Pin|LED8_ORANGE_Pin|LED6_GREEN_Pin, GPIO_PIN_RESET);
    HAL_Delay(1000);
}

/* USER CODE END 2 */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
