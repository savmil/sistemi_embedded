/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * @file           : main.c
 * @brief          : Main program body
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

/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "can.h"
#include "crc.h"
#include "i2c.h"
#include "spi.h"
#include "usart.h"
#include "usb_device.h"
#include "gpio.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */

__IO uint32_t UserButtonStatus = 0; /* set to 1 after User Button interrupt  */
__IO uint32_t wTransferState = TRANSFER_WAIT;
__IO ITStatus UartReady = RESET;
static uint32_t Frame[FRAME_SIZE] = { 0x00001234, 0x0, 0x0 };
//uint8_t aRxBuffer[FRAME_SIZE];
//uint8_t aTxBuffer[FRAME_SIZE];

uint8_t aRxBuffer[BUFFER_SIZE];
uint8_t aTxBuffer[BUFFER_SIZE];

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
/* USER CODE BEGIN PFP */
void CRC_Check(uint32_t * ReceivedFrame);
void Receive_CRC(uint32_t * ReceivedData, uint8_t channel);
void Send_CRC(uint32_t * MSG, uint8_t channel);
/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{
  /* USER CODE BEGIN 1 */
  /* USER CODE END 1 */
  

  /* MCU Configuration--------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* Configure the system clock */
  SystemClock_Config();

  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
/*  MX_CAN_Init();
  MX_CRC_Init();
  MX_SPI2_Init();
  MX_USART2_UART_Init();
  MX_USB_DEVICE_Init();
  MX_I2C2_Init();
  *//* USER CODE BEGIN 2 */

#ifdef MASTER_BOARD

	HAL_GPIO_WritePin(GPIOE, LED4_BLUE_Pin, GPIO_PIN_RESET);

	MX_CRC_Init(CRC_POLYNOMIAL_1, CRC_DEFAULTVALUE_1);
	uint32_t CRC32_1 = HAL_CRC_Calculate(&hcrc, (uint32_t *) &Frame,
	PAYLOAD_SIZE);

	MX_CRC_Init(CRC_POLYNOMIAL_2, CRC_DEFAULTVALUE_2);
	uint32_t CRC32_2 = HAL_CRC_Calculate(&hcrc, (uint32_t *) &Frame,
	PAYLOAD_SIZE);

	Frame[CRC1_OFFSET] = CRC32_1;
	Frame[CRC2_OFFSET] = CRC32_2;

	//Send_CRC(Frame,SERIAL_SELECTED);
#else
	Receive_CRC(Frame, SERIAL_SELECTED);
#endif

  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
	while (1) {
		/* USER CODE END WHILE */
				LedOff();
				Send_CRC(Frame, SERIAL_SELECTED);
				LedOff();
				Receive_CRC(Frame, SERIAL_SELECTED);
				/* USER CODE BEGIN 3 */
	}
  /* USER CODE END 3 */
}

/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};
  RCC_PeriphCLKInitTypeDef PeriphClkInit = {0};

  /** Initializes the CPU, AHB and APB busses clocks 
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI|RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_ON;
  RCC_OscInitStruct.HSEPredivValue = RCC_HSE_PREDIV_DIV1;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL6;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }
  /** Initializes the CPU, AHB and APB busses clocks 
  */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_1) != HAL_OK)
  {
    Error_Handler();
  }
  PeriphClkInit.PeriphClockSelection = RCC_PERIPHCLK_USB|RCC_PERIPHCLK_USART2
                              |RCC_PERIPHCLK_I2C2;
  PeriphClkInit.Usart2ClockSelection = RCC_USART2CLKSOURCE_PCLK1;
  PeriphClkInit.I2c2ClockSelection = RCC_I2C2CLKSOURCE_HSI;
  PeriphClkInit.USBClockSelection = RCC_USBCLKSOURCE_PLL;
  if (HAL_RCCEx_PeriphCLKConfig(&PeriphClkInit) != HAL_OK)
  {
    Error_Handler();
  }
}

/* USER CODE BEGIN 4 */

void Frame32to8(uint32_t * in_buffer32, uint8_t * out_buffer8) {

	uint8_t chunk = 0;

	for (int i = 0; i < FRAME_SIZE; i++) {
		for (int j = 0; j < 4; j++) {
			chunk = in_buffer32[i] >> j * 8 & 255;
			out_buffer8[4 * i + j] = chunk;
		}
	}

}

void Frame8to32(uint8_t * in_buffer8, uint32_t * out_buffer32) {

	uint32_t chunk32 = 0;
	uint32_t temp = 0;

	//for (int i = 0; i < FRAME_SIZE; i++) {
	for (int i = 0; i < FRAME_SIZE; i++) {
		for (int j = 0; j < 4; j++) {
			temp = in_buffer8[(4 * i) + j];
			temp = temp << 8 * j;
			chunk32 = chunk32 + temp;
			temp = 0;
		}
		out_buffer32[i] = chunk32;
		chunk32 = 0;
	}

}

void Send_CRC(uint32_t * MSG, uint8_t channel) {

	switch (channel) {

	case 0:

		MX_USART2_UART_Init(UART_BAUDRATE);
		//uint8_t aTxBuffer[BUFFER_SIZE];
		Frame32to8(MSG, aTxBuffer);
#ifdef MASTER_BOARD
		while (UserButtonStatus == 0) {
			HAL_GPIO_TogglePin(GPIOE, LED4_BLUE_Pin);
			HAL_Delay(100);
		}
#endif /* MASTER_BOARD */
		if (HAL_UART_Transmit_IT(&huart2, (uint8_t*) aTxBuffer, BUFFER_SIZE)
				!= HAL_OK) {
			Error_Handler();
		}

		while (UartReady != SET) {
			HAL_GPIO_TogglePin(GPIOE, LED4_BLUE_Pin);
			HAL_Delay(100);
		}

		UartReady = RESET;
		break;

	case 1:

		MX_I2C2_Init();
		Frame32to8(MSG, aTxBuffer);
#ifdef MASTER_BOARD

		while (UserButtonStatus == 0) {
			HAL_GPIO_TogglePin(GPIOE, LED4_BLUE_Pin);
			HAL_Delay(100);
		}

		/* Delay to avoid that possible signal rebound is taken as button release */
		  HAL_Delay(100);

		if (HAL_I2C_Master_Transmit_IT(&hi2c2, (uint16_t) I2C_ADDRESS,
				(uint8_t*) aTxBuffer, BUFFER_SIZE) != HAL_OK) {
			/* Error_Handler() function is called when error occurs. */
			Error_Handler();
		}

#else

		if(HAL_I2C_Slave_Transmit_IT(&hi2c2, (uint8_t*)aTxBuffer, BUFFER_SIZE)!= HAL_OK)
		{
			/* Transfer error in transmission process */
			Error_Handler();
		}

#endif /* MASTER_BOARD */

		while (HAL_I2C_GetState(&hi2c2) != HAL_I2C_STATE_READY) {
			//HAL_GPIO_TogglePin(GPIOE, LED4_BLUE_Pin);
			//HAL_Delay(100);
		}

		break;
	case 2:
		MX_CAN_Init();
		break;
	case 3:
		MX_USB_DEVICE_Init();
		break;
	case 4:

#ifdef MASTER_BOARD
		hspi2.Init.Mode = SPI_MODE_MASTER;
#else
		hspi2.Init.Mode = SPI_MODE_SLAVE;
#endif /* MASTER_BOARD */

		MX_SPI2_Init();
		Frame32to8(MSG, aTxBuffer);

#ifdef MASTER_BOARD
		while (UserButtonStatus == 0) {
			HAL_GPIO_TogglePin(GPIOE, LED4_BLUE_Pin);
			HAL_Delay(100);
		}
#endif /* MASTER_BOARD */

		HAL_GPIO_WritePin(SPI_EN_OUTPUT_GPIO_Port, SPI_EN_OUTPUT_Pin,
				GPIO_PIN_SET);

		if (HAL_SPI_Transmit_IT(&hspi2, (uint8_t*) aTxBuffer, BUFFER_SIZE)
				!= HAL_OK) {
			/* Transfer error in transmission process */
			Error_Handler();
		}

		while (wTransferState == TRANSFER_WAIT) {
			//HAL_GPIO_TogglePin(GPIOE, LED4_BLUE_Pin);
			//HAL_Delay(100);
		}

		wTransferState = TRANSFER_WAIT;

		HAL_GPIO_WritePin(SPI_EN_OUTPUT_GPIO_Port, SPI_EN_OUTPUT_Pin,
				GPIO_PIN_RESET);

		break;
	}
}

void Receive_CRC(uint32_t * ReceivedData, uint8_t channel) {

	switch (channel) {

	case 0:
		MX_USART2_UART_Init(UART_BAUDRATE);
		//uint8_t aRxBuffer[BUFFER_SIZE];

		if (HAL_UART_Receive_IT(&huart2, (uint8_t *) aRxBuffer, BUFFER_SIZE)
				!= HAL_OK) {
			Error_Handler();
		}

		while (UartReady != SET) {
			HAL_GPIO_TogglePin(GPIOE, LED9_BLUE_Pin);
			HAL_Delay(100);
		}

		UartReady = RESET;

//            uint32_t ReceivedFrame[FRAME_SIZE];
		Frame8to32(aRxBuffer, ReceivedData);
		CRC_Check(ReceivedData);
		break;

	case 1:
		MX_I2C2_Init();

#ifdef MASTER_BOARD

		if (HAL_I2C_Master_Receive_IT(&hi2c2, (uint16_t) I2C_ADDRESS,
				(uint8_t *) aRxBuffer, BUFFER_SIZE) != HAL_OK) {
			/* Error_Handler() function is called when error occurs. */
			Error_Handler();
		}

#else
		HAL_GPIO_WritePin(GPIOE, LED9_BLUE_Pin, GPIO_PIN_SET);

		if(HAL_I2C_Slave_Receive_IT(&hi2c2, (uint8_t *)aRxBuffer, BUFFER_SIZE) != HAL_OK)
		{
			/* Transfer error in reception process */
			Error_Handler();
		}

#endif /* MASTER_BOARD */

		while (HAL_I2C_GetState(&hi2c2) != HAL_I2C_STATE_READY) {
			//HAL_GPIO_TogglePin(GPIOE, LED9_BLUE_Pin);
			//HAL_Delay(100);
		}

		HAL_GPIO_WritePin(GPIOE, LED9_BLUE_Pin, GPIO_PIN_RESET);

		Frame8to32(aRxBuffer, ReceivedData);
		CRC_Check(ReceivedData);

		break;
	case 2:
		MX_CAN_Init();
		break;
	case 3:
		MX_USB_DEVICE_Init();
		break;
	case 4:

#ifdef MASTER_BOARD
		hspi2.Init.Mode = SPI_MODE_MASTER;
#else
		hspi2.Init.Mode = SPI_MODE_SLAVE;
#endif /* MASTER_BOARD */

		MX_SPI2_Init();

		//uint8_t aRxBuffer1[BUFFER_SIZE];
		while (HAL_GPIO_ReadPin(SPI_EN_INPUT_GPIO_Port, SPI_EN_INPUT_Pin)
				== GPIO_PIN_RESET) {
			HAL_GPIO_TogglePin(GPIOE, LED9_BLUE_Pin);
			//HAL_Delay(100);
		}

		if (HAL_SPI_Receive_IT(&hspi2, (uint8_t*) aRxBuffer, BUFFER_SIZE)
				!= HAL_OK) {
			/* Transfer error in transmission process */
			Error_Handler();
		}

		while (wTransferState == TRANSFER_WAIT) {
			//HAL_GPIO_TogglePin(GPIOE, LED9_BLUE_Pin);
			//HAL_Delay(100);
		}

		wTransferState = TRANSFER_WAIT;

		Frame8to32(aRxBuffer, ReceivedData);
		CRC_Check(ReceivedData);
		break;

	}

}

void CRC_Check(uint32_t * ReceivedFrame) {

	MX_CRC_Init(CRC_POLYNOMIAL_1, CRC_DEFAULTVALUE_1);
	uint32_t CRC32_1 = HAL_CRC_Calculate(&hcrc, (uint32_t *) ReceivedFrame,
	PAYLOAD_SIZE);

	MX_CRC_Init(CRC_POLYNOMIAL_2, CRC_DEFAULTVALUE_2);
	uint32_t CRC32_2 = HAL_CRC_Calculate(&hcrc, (uint32_t *) ReceivedFrame,
	PAYLOAD_SIZE);

	if (CRC32_1 != ReceivedFrame[CRC1_OFFSET])
		HAL_GPIO_WritePin(GPIOE, LED10_RED_Pin, GPIO_PIN_SET);
	else
		HAL_GPIO_WritePin(GPIOE, LED7_GREEN_Pin, GPIO_PIN_SET);

	if (CRC32_2 != ReceivedFrame[CRC2_OFFSET])
		HAL_GPIO_WritePin(GPIOE, LED3_RED_Pin, GPIO_PIN_SET);
	else
		HAL_GPIO_WritePin(GPIOE, LED6_GREEN_Pin, GPIO_PIN_SET);

}

/* USER CODE END 4 */
void HAL_UART_TxCpltCallback(UART_HandleTypeDef *UartHandle) {
	/* Set transmission flag: transfer complete */
	UartReady = SET;

	/* Turn LED3 on: Transfer in transmission process is correct */
	HAL_GPIO_WritePin(GPIOE, LED4_BLUE_Pin, GPIO_PIN_SET);

}

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *UartHandle) {
	/* Set transmission flag: transfer complete */
	UartReady = SET;

	/* Turn LED5 on: Transfer in reception process is correct */
	HAL_GPIO_WritePin(GPIOE, LED9_BLUE_Pin, GPIO_PIN_SET);

}

/**
 * @brief  UART error callbacks
 * @param  UartHandle: UART handle
 * @note   This example shows a simple way to report transfer error, and you can
 *         add your own implementation.
 * @retval None
 */
void HAL_UART_ErrorCallback(UART_HandleTypeDef *UartHandle) {
	/* Turn LED6 on: Transfer error in reception/transmission process */
	HAL_GPIO_WritePin(GPIOE, LED3_RED_Pin, GPIO_PIN_SET);
}

#ifdef MASTER_BOARD

void HAL_I2C_MasterTxCpltCallback(I2C_HandleTypeDef *hi2c2) {
	/* Toggle LED7: Transfer in transmission process is correct */
	HAL_GPIO_WritePin(GPIOE, LED4_BLUE_Pin, GPIO_PIN_SET);
}

void HAL_I2C_MasterRxCpltCallback(I2C_HandleTypeDef *hi2c2) {
	/* Toggle LED7: Transfer in reception process is correct */
	HAL_GPIO_WritePin(GPIOE, LED9_BLUE_Pin, GPIO_PIN_SET);

}
#else
void HAL_I2C_SlaveTxCpltCallback(I2C_HandleTypeDef *hi2c2)
{
	/* Toggle LED7: Transfer in transmission process is correct */
	HAL_GPIO_WritePin(GPIOE, LED4_BLUE_Pin, GPIO_PIN_SET);
}

void HAL_I2C_SlaveRxCpltCallback(I2C_HandleTypeDef *hi2c2)
{
	/* Toggle LED7: Transfer in reception process is correct */
	HAL_GPIO_WritePin(GPIOE, LED9_BLUE_Pin, GPIO_PIN_SET);

}
#endif /* MASTER_BOARD */

/**
 * @brief  I2C error callbacks.
 * @param  I2cHandle: I2C handle
 * @note   This example shows a simple way to report transfer error, and you can
 *         add your own implementation.
 * @retval None
 */
void HAL_I2C_ErrorCallback(I2C_HandleTypeDef *hi2c2) {
	/** 1- When Slave don't acknowledge it's address, Master restarts communication.
	 * 2- When Master don't acknowledge the last data transferred, Slave don't care in this example.
	 */
	if (HAL_I2C_GetError(hi2c2) != HAL_I2C_ERROR_AF) {
		/* Turn LED3 on: Transfer error in reception/transmission process */
		HAL_GPIO_WritePin(GPIOE, LED3_RED_Pin, GPIO_PIN_SET);
	}
}

void HAL_SPI_TxCpltCallback(SPI_HandleTypeDef *hspi) {
	/* Turn LED on: Transfer in transmission process is correct */
	HAL_GPIO_WritePin(GPIOE, LED4_BLUE_Pin, GPIO_PIN_SET);
	/* Turn LED on: Transfer in reception process is correct */
	//BSP_LED_On(LED4);
	wTransferState = TRANSFER_COMPLETE;
}

void HAL_SPI_RxCpltCallback(SPI_HandleTypeDef *hspi) {
	/* Turn LED on: Transfer in transmission process is correct */
	//BSP_LED_On(LED3);
	/* Turn LED on: Transfer in reception process is correct */
	HAL_GPIO_WritePin(GPIOE, LED9_BLUE_Pin, GPIO_PIN_SET);
	wTransferState = TRANSFER_COMPLETE;
}

/**
 * @brief  SPI error callbacks.
 * @param  hspi: SPI handle
 * @note   This example shows a simple way to report transfer error, and you can
 *         add your own implementation.
 * @retval None
 */
void HAL_SPI_ErrorCallback(SPI_HandleTypeDef *hspi) {
	wTransferState = TRANSFER_ERROR;
}

/**
 * @brief EXTI line detection callbacks
 * @param GPIO_Pin: Specifies the pins connected EXTI line
 * @retval None
 */
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin) {
	if (GPIO_Pin == USER_BTN_Pin) {
		UserButtonStatus = 1;
	}
}

/**
 * @brief  This function is executed in case of error occurrence.
 * @retval None
 */
void Error_Handler(void) {
	/* USER CODE BEGIN Error_Handler_Debug */
	/* User can add his own implementation to report the HAL error return state */
	HAL_GPIO_WritePin(GPIOE, LED3_RED_Pin, GPIO_PIN_SET);
	/* USER CODE END Error_Handler_Debug */
}

#ifdef  USE_FULL_ASSERT
/**
 * @brief  Reports the name of the source file and the source line number
 *         where the assert_param error has occurred.
 * @param  file: pointer to the source file name
 * @param  line: assert_param error line source number
 * @retval None
 */
void assert_failed(char *file, uint32_t line)
{
	/* USER CODE BEGIN 6 */
	/* User can add his own implementation to report the file name and line number,
	 tex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
	/* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
