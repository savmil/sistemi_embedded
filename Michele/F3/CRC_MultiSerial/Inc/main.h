/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2019 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under Ultimate Liberty license
  * SLA0044, the "License"; You may not use this file except in compliance with
  * the License. You may obtain a copy of the License at:
  *                             www.st.com/SLA0044
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f3xx_hal.h"
#include "stm32f3_discovery.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define USER_BTN_Pin GPIO_PIN_0
#define USER_BTN_GPIO_Port GPIOA
#define USER_BTN_EXTI_IRQn EXTI0_IRQn
#define LED4_BLUE_Pin GPIO_PIN_8
#define LED4_BLUE_GPIO_Port GPIOE
#define LED3_RED_Pin GPIO_PIN_9
#define LED3_RED_GPIO_Port GPIOE
#define LED5_ORANGE_Pin GPIO_PIN_10
#define LED5_ORANGE_GPIO_Port GPIOE
#define LED7_GREEN_Pin GPIO_PIN_11
#define LED7_GREEN_GPIO_Port GPIOE
#define LED9_BLUE_Pin GPIO_PIN_12
#define LED9_BLUE_GPIO_Port GPIOE
#define LED10_RED_Pin GPIO_PIN_13
#define LED10_RED_GPIO_Port GPIOE
#define LED8_ORANGE_Pin GPIO_PIN_14
#define LED8_ORANGE_GPIO_Port GPIOE
#define LED6_GREEN_Pin GPIO_PIN_15
#define LED6_GREEN_GPIO_Port GPIOE
#define SPI_EN_OUTPUT_Pin GPIO_PIN_8
#define SPI_EN_OUTPUT_GPIO_Port GPIOD
#define SPI_EN_INPUT_Pin GPIO_PIN_9
#define SPI_EN_INPUT_GPIO_Port GPIOD
/* USER CODE BEGIN Private defines */

/* Exported macro ------------------------------------------------------------*/
#define COUNTOF(__BUFFER__)   sizeof(*(__BUFFER__)))
/* Exported functions ------------------------------------------------------- */

/* Define CRC settings */
#define CRC_POLYNOMIAL_1 0x100D4E63
#define CRC_POLYNOMIAL_2 0x8CE56011
#define CRC_DEFAULTVALUE_1 0x00
#define CRC_DEFAULTVALUE_2 0x00



/* Define frame offset */
#define PAYLOAD_SIZE 2										//numero di chunk da 32 bit del payload (dim_msg/32)
#define CRC_DIM 32
#define BUFFER_SIZE (2*(CRC_DIM/8)+PAYLOAD_SIZE*4)
#define FRAME_SIZE PAYLOAD_SIZE+2
#define CRC1_OFFSET PAYLOAD_SIZE
#define CRC2_OFFSET PAYLOAD_SIZE+1
#define UART_BAUDRATE 9600

#define I2C_ADDRESS        0x30F
/* I2C TIMING Register define when I2C clock source is SYSCLK */
/* I2C TIMING is calculated in case of the I2C Clock source is the SYSCLK = 72 MHz */
/* This example use TIMING to 0x00C4092A to reach 1 MHz speed (Rise time = 26ns, Fall time = 2ns) */
#define I2C_TIMING      0x00C4092A


/* Define comunication channel */
#define UART_MODE 0
#define I2C_MODE 1
#define CAN_MODE 2
#define USB_MODE 3
#define SPI_MODE 4

//Parametro da modificare in base alla seriale richiesta tra le opzioni sopra definite
#define SERIAL_SELECTED 4
//Parametro da modificare in base al Master e Slave board
//#define MASTER_BOARD
/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
