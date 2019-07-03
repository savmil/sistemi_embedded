/**
  ******************************************************************************
  * @file           : can.h
  * @brief header file per la configurazione della periferica CAN
  ******************************************************************************
  */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef DOXYGEN_SHOULD_SKIP_THIS
#ifndef __can_H
#define __can_H
#ifdef __cplusplus

 extern "C" {
#endif
#endif
/* Includes ------------------------------------------------------------------*/
#include "main.h"

extern CAN_HandleTypeDef CanHandle;

/* USER CODE BEGIN Private defines */


/*Can invia messaggi da 8 byte, quindi il frame va decomposto in messaggi di 8 byte */
#define CAN_CALLBACK_COUNT				(BUFFER_SIZE/8)



#define BROADCAST_ADDRESS				0x1

/* Definition for CANx clock resources */
#define CANx_CLK_ENABLE()              __HAL_RCC_CAN1_CLK_ENABLE()
#define CANx_GPIO_CLK_ENABLE()         __HAL_RCC_GPIOA_CLK_ENABLE()

#define CANx_FORCE_RESET()             __HAL_RCC_CAN1_FORCE_RESET()
#define CANx_RELEASE_RESET()           __HAL_RCC_CAN1_RELEASE_RESET()

/* Definition for CANx Pins */
#define CANx_TX_PIN                    GPIO_PIN_12
#define CANx_TX_GPIO_PORT              GPIOA
#define CANx_TX_AF                     GPIO_AF9_CAN
#define CANx_RX_PIN                    GPIO_PIN_11
#define CANx_RX_GPIO_PORT              GPIOA
#define CANx_RX_AF                     GPIO_AF9_CAN

/* Definition for CANx's NVIC */
#define CANx_TX_IRQn				   CAN_TX_IRQn
#define CANx_TX_IRQHandler			   CAN_RX1_IRQHandler

/* USER CODE END Private defines */

void MX_CAN_Init(uint16_t nodeAddress, uint16_t groupAddress);

/* USER CODE BEGIN Prototypes */

/* USER CODE END Prototypes */

#ifdef __cplusplus
}
#endif
#endif /*__ can_H */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
