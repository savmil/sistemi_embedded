/**
  ******************************************************************************
  * @file    main.c
  * @author  Ac6
  * @version V1.0
  * @date    01-December-2013
  * @brief   Default main function.
  ******************************************************************************
*/


#include "stm32f3xx.h"
			
/**
  ******************************************************************************
  * @file    CRC/CRC_UserDefinedPolynomial/Src/main.c
  * @author  MCD Application Team
  * @brief   This sample code shows how to use the STM32F3xx CRC HAL API
  *          to get a CRC code of a given buffer of data word(32-bit),
  *          based on a fixed generator polynomial(0x4C11DB7).
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT(c) 2016 STMicroelectronics</center></h2>
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of STMicroelectronics nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "main.h"
UART_HandleTypeDef UartHandle;
__IO ITStatus UartReady = RESET;
__IO uint32_t UserButtonStatus = 0;  /* set to 1 after User Button interrupt  */

/* Buffer used for transmission */
uint8_t aTxBuffer[] = " ****UART_TwoBoards_ComIT****  ****UART_TwoBoards_ComIT****  ****UART_TwoBoards_ComIT**** ";

/* Buffer used for reception */
uint8_t aRxBuffer[RXBUFFERSIZE];

static uint16_t Buffercmp(uint8_t* pBuffer1, uint8_t* pBuffer2, uint16_t BufferLength);
/** @addtogroup STM32F3xx_HAL_Examples
  * @{
  */

/** @addtogroup CRC_UserDefinedPolynomial
  * @{
  */

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* aDataBuffer is 32 bit long*/
#define BUFFER_SIZE 1

/* The user defined polynomial*/
#define CRC_POLYNOMIAL_8B 0x9B /* X^7 + X^4 + X^3 + X + 1 */

/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* CRC handler declaration */
CRC_HandleTypeDef   CrcHandle;

/* Used for storing CRC Value */
__IO uint32_t uwCRCValue = 0;

/* Buffer containing the data on which the CRC will be calculated*/
static const uint32_t aDataBuffer = 0x1234;

/* Expected CRC Value */
uint32_t uwExpectedCRCValue = 0xEF;

/* Private function prototypes -----------------------------------------------*/
static void SystemClock_Config(void);
static void Error_Handler(void);

/* Private functions ---------------------------------------------------------*/

/**
  * @brief  Main program
  * @param  None
  * @retval None
  */
int main(void)
{
  /* STM32F3xx HAL library initialization:
       - Configure the Flash prefetch
       - Systick timer is configured by default as source of time base, but user
         can eventually implement his proper time base source (a general purpose
         timer for example or other time source), keeping in mind that Time base
         duration should be kept 1ms since PPP_TIMEOUT_VALUEs are defined and
         handled in milliseconds basis.
       - Set NVIC Group Priority to 4
       - Low Level Initialization
     */
  HAL_Init();

  /* Configure LED1 and LED3 */
  BSP_LED_Init(LED6);
  BSP_LED_Init(LED5);
  BSP_LED_Init(LED4);
  BSP_LED_Init(LED3);

  /* Configure the system clock to 72 MHz */
  SystemClock_Config();

  /*##-1- Configure the CRC peripheral #######################################*/
  CrcHandle.Instance = CRC;

  /* The default polynomial is not used. It is required to defined it in CrcHandle.Init.GeneratingPolynomial*/
  CrcHandle.Init.DefaultPolynomialUse    = DEFAULT_POLYNOMIAL_DISABLE;

  /* Set the value of the polynomial */
  CrcHandle.Init.GeneratingPolynomial    = CRC_POLYNOMIAL_8B;

  /* The size of the polynomial to configure the IP is 8b*/
  CrcHandle.Init.CRCLength               = CRC_POLYLENGTH_8B;

  /* The default init value is used */
  CrcHandle.Init.DefaultInitValueUse     = DEFAULT_INIT_VALUE_ENABLE;

  /* The input data are not inverted */
  CrcHandle.Init.InputDataInversionMode  = CRC_INPUTDATA_INVERSION_NONE;

  /* The output data are not inverted */
  CrcHandle.Init.OutputDataInversionMode = CRC_OUTPUTDATA_INVERSION_DISABLE;

  /* The input data are 32 bits lenght */
  CrcHandle.InputDataFormat              = CRC_INPUTDATA_FORMAT_WORDS;

  if (HAL_CRC_Init(&CrcHandle) != HAL_OK)
  {
    /* Initialization Error */
    Error_Handler();
  }

  /*##-2- Compute the CRC of "aDataBuffer" ###################################*/
  uwCRCValue = HAL_CRC_Calculate(&CrcHandle, (uint32_t *)&aDataBuffer, BUFFER_SIZE);

  /*##-3- Compare the CRC value to the Expected one ##########################*/
  if (uwCRCValue != uwExpectedCRCValue)
  {
    /* Wrong CRC value: Turn LED3 on */
    Error_Handler();
  }
  else
  {
    /* Right CRC value: Turn LED1 on */
    BSP_LED_On(LED6);
  }
  UartHandle.Instance        = USARTx;

    UartHandle.Init.BaudRate   = 9600;
    UartHandle.Init.WordLength = UART_WORDLENGTH_8B;
    UartHandle.Init.StopBits   = UART_STOPBITS_1;
    UartHandle.Init.Parity     = UART_PARITY_NONE;
    UartHandle.Init.HwFlowCtl  = UART_HWCONTROL_NONE;
    UartHandle.Init.Mode       = UART_MODE_TX_RX;
    UartHandle.AdvancedInit.AdvFeatureInit = UART_ADVFEATURE_NO_INIT;
    if(HAL_UART_DeInit(&UartHandle) != HAL_OK)
    {
      Error_Handler();
    }
    if(HAL_UART_Init(&UartHandle) != HAL_OK)
    {
      Error_Handler();
    }

  #ifdef TRANSMITTER_BOARD

    /* Configure User push-button in Interrupt mode */
    BSP_PB_Init(BUTTON_USER, BUTTON_MODE_EXTI);

    /* Wait for User push-button press before starting the Communication.
       In the meantime, LED4 is blinking */
    while(UserButtonStatus == 0)
    {
        /* Toggle LED4*/
        BSP_LED_Toggle(LED4);
        HAL_Delay(100);
    }

    BSP_LED_Off(LED4);

    /* The board sends the message and expects to receive it back */

    /*##-2- Start the transmission process #####################################*/
    /* While the UART in reception process, user can transmit data through
       "aTxBuffer" buffer */
    if(HAL_UART_Transmit_IT(&UartHandle, (uint8_t*)aTxBuffer, TXBUFFERSIZE)!= HAL_OK)
    {
      Error_Handler();
    }

    /*##-3- Wait for the end of the transfer ###################################*/
    while (UartReady != SET)
    {
    }

    /* Reset transmission flag */
    UartReady = RESET;

    /*##-4- Put UART peripheral in reception process ###########################*/
    if(HAL_UART_Receive_IT(&UartHandle, (uint8_t *)aRxBuffer, RXBUFFERSIZE) != HAL_OK)
    {
      Error_Handler();
    }

  #else

    /* The board receives the message and sends it back */

    /*##-2- Put UART peripheral in reception process ###########################*/
    if(HAL_UART_Receive_IT(&UartHandle, (uint8_t *)aRxBuffer, RXBUFFERSIZE) != HAL_OK)
    {
      Error_Handler();
    }

    /*##-3- Wait for the end of the transfer ###################################*/
    /* While waiting for message to come from the other board, LED4 is
       blinking according to the following pattern: a double flash every half-second */
    while (UartReady != SET)
    {
        BSP_LED_On(LED4);
        HAL_Delay(100);
        BSP_LED_Off(LED4);
        HAL_Delay(100);
        BSP_LED_On(LED4);
        HAL_Delay(100);
        BSP_LED_Off(LED4);
        HAL_Delay(500);
    }

    /* Reset transmission flag */
    UartReady = RESET;
    BSP_LED_Off(LED4);

    /*##-4- Start the transmission process #####################################*/
    /* While the UART in reception process, user can transmit data through
       "aTxBuffer" buffer */
    if(HAL_UART_Transmit_IT(&UartHandle, (uint8_t*)aTxBuffer, TXBUFFERSIZE)!= HAL_OK)
    {
      Error_Handler();
    }

  #endif /* TRANSMITTER_BOARD */

    /*##-5- Wait for the end of the transfer ###################################*/
    while (UartReady != SET)
    {
    }

    /* Reset transmission flag */
    UartReady = RESET;

    /*##-6- Compare the sent and received buffers ##############################*/
    if(Buffercmp((uint8_t*)aTxBuffer,(uint8_t*)aRxBuffer,RXBUFFERSIZE))
    {
      Error_Handler();
    }
  /* Infinite loop */
  while (1)
  {
  }
}

/**
  * @brief  System Clock Configuration
  *         The system Clock is configured as follow :
  *            System Clock source            = PLL (HSE)
  *            SYSCLK(Hz)                     = 72000000
  *            HCLK(Hz)                       = 72000000
  *            AHB Prescaler                  = 1
  *            APB1 Prescaler                 = 2
  *            APB2 Prescaler                 = 1
  *            HSE Frequency(Hz)              = 8000000
  *            HSE PREDIV                     = 1
  *            PLLMUL                         = RCC_PLL_MUL9 (9)
  *            Flash Latency(WS)              = 2
  * @param  None
  * @retval None
  */
static void SystemClock_Config(void)
{
  RCC_ClkInitTypeDef RCC_ClkInitStruct;
  RCC_OscInitTypeDef RCC_OscInitStruct;

  /* Enable HSE Oscillator and activate PLL with HSE as source */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_ON;
  RCC_OscInitStruct.HSEPredivValue = RCC_HSE_PREDIV_DIV1;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL9;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct)!= HAL_OK)
  {
    Error_Handler();
  }

  /* Select PLL as system clock source and configure the HCLK, PCLK1 and PCLK2
     clocks dividers */
  RCC_ClkInitStruct.ClockType = (RCC_CLOCKTYPE_SYSCLK | RCC_CLOCKTYPE_HCLK | RCC_CLOCKTYPE_PCLK1 | RCC_CLOCKTYPE_PCLK2);
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;
  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2)!= HAL_OK)
  {
    Error_Handler();
  }
}
/**
  * @brief  This function is executed in case of error occurrence.
  * @param  None
  * @retval None
  */
static void Error_Handler(void)
{
  /* Turn LED3 on */
  BSP_LED_On(LED3);
  while (1)
  {
  }
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
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif

/**
  * @brief  Tx Transfer completed callback
  * @param  UartHandle: UART handle.
  * @note   This example shows a simple way to report end of IT Tx transfer, and
  *         you can add your own implementation.
  * @retval None
  */
void HAL_UART_TxCpltCallback(UART_HandleTypeDef *UartHandle)
{
  /* Set transmission flag: transfer complete */
  UartReady = SET;

  /* Turn LED3 on: Transfer in transmission process is correct */
  BSP_LED_On(LED3);

}

/**
  * @brief  Rx Transfer completed callback
  * @param  UartHandle: UART handle
  * @note   This example shows a simple way to report end of DMA Rx transfer, and
  *         you can add your own implementation.
  * @retval None
  */
void HAL_UART_RxCpltCallback(UART_HandleTypeDef *UartHandle)
{
  /* Set transmission flag: transfer complete */
  UartReady = SET;

  /* Turn LED5 on: Transfer in reception process is correct */
  BSP_LED_On(LED5);

}

/**
  * @brief  UART error callbacks
  * @param  UartHandle: UART handle
  * @note   This example shows a simple way to report transfer error, and you can
  *         add your own implementation.
  * @retval None
  */
void HAL_UART_ErrorCallback(UART_HandleTypeDef *UartHandle)
{
  /* Turn LED6 on: Transfer error in reception/transmission process */
  BSP_LED_On(LED6);
}


/**
  * @brief EXTI line detection callbacks
  * @param GPIO_Pin: Specifies the pins connected EXTI line
  * @retval None
  */
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
{
  if(GPIO_Pin == USER_BUTTON_PIN)
  {
    UserButtonStatus = 1;
  }
}
/**
  * @brief  Compares two buffers.
  * @param  pBuffer1, pBuffer2: buffers to be compared.
  * @param  BufferLength: buffer's length
  * @retval 0  : pBuffer1 identical to pBuffer2
  *         >0 : pBuffer1 differs from pBuffer2
  */
static uint16_t Buffercmp(uint8_t* pBuffer1, uint8_t* pBuffer2, uint16_t BufferLength)
{
  while (BufferLength--)
  {
    if ((*pBuffer1) != *pBuffer2)
    {
      return BufferLength;
    }
    pBuffer1++;
    pBuffer2++;
  }

  return 0;
}

