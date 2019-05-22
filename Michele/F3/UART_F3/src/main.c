#include "main.h"

/** @addtogroup STM32F3xx_HAL_Examples
  * @{
  */

/** @addtogroup UART_TwoBoards_ComIT
  * @{
  */

#define CRC_BUFFER_SIZE 4
#define CRC_DIM 8;
#define CRC_POLYNOMIAL_8B 0x9B /* X^8 + X^7 + X^4 + X^3 + X + 1 */
#define UART_BUFFER_SIZE 2+CRC_BUFFER_SIZE*4


#define TRANSMITTER_BOARD

/* UART handler declaration */
UART_HandleTypeDef UartHandle;
__IO ITStatus UartReady = RESET;
__IO uint32_t UserButtonStatus = 0;  /* set to 1 after User Button interrupt  */

/* Buffer used for transmission */
uint8_t aTxBuffer[UART_BUFFER_SIZE];

/* Buffer used for reception */
uint8_t aRxBuffer[UART_BUFFER_SIZE];

CRC_HandleTypeDef   CrcHandle;
__IO uint32_t uwCRCValue = 0;


static const uint32_t crcDataBuffer[CRC_BUFFER_SIZE] = {0x00001234,0x00001234,0x00001234,0x00001234 };


/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
static void Error_Handler(void);


void CRC_Config();
void UART_Config();



/* Private functions ---------------------------------------------------------*/

/**
  * @brief  Main program
  * @param  None
  * @retval None
  */
int main(void)
{

  HAL_Init();

  /* Configure the system clock to 72 MHz */
  SystemClock_Config();

  /* Configure LED3, LED4, LED5 and LED6 */
  BSP_LED_Init(LED3);
  BSP_LED_Init(LED4);
  BSP_LED_Init(LED5);
  BSP_LED_Init(LED6);
  BSP_LED_Init(LED7);


  CRC_Config();
  UART_Config();

   /*##-2- Compute the CRC of "aDataBuffer" ###################################*/
   uwCRCValue = HAL_CRC_Calculate(&CrcHandle, (uint32_t *)&crcDataBuffer, CRC_BUFFER_SIZE);

   uint8_t chunk =0;

   int j=0;

   for(int i=0;i<CRC_BUFFER_SIZE;i++){
      for (int j=0;j<4;j++){
          chunk = crcDataBuffer[i] >> j*8 & 255;
          aTxBuffer[4*i+j]=chunk;
      }
   }

   aTxBuffer[UART_BUFFER_SIZE-2]=uwCRCValue;
   aTxBuffer[UART_BUFFER_SIZE-1]=uwCRCValue;


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

  /*##-2- Start the transmission process #####################################*/
  /* While the UART in reception process, user can transmit data through
     "aTxBuffer" buffer */
  if(HAL_UART_Transmit_IT(&UartHandle, (uint8_t*)aTxBuffer, UART_BUFFER_SIZE)!= HAL_OK)
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
//  if(HAL_UART_Receive_IT(&UartHandle, (uint8_t *)aRxBuffer, UART_BUFFER_SIZE) != HAL_OK)
//  {
//    Error_Handler();
//  }

#else

  /* The board receives the message and sends it back */

  /*##-2- Put UART peripheral in reception process ###########################*/
  if(HAL_UART_Receive_IT(&UartHandle, (uint8_t *)aRxBuffer, UART_BUFFER_SIZE) != HAL_OK)
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

  uint32_t receivedData[CRC_BUFFER_SIZE];
  uint32_t chunk32=0;
  uint32_t temp=0;

  for (int i=0;i<CRC_BUFFER_SIZE;i++){
      for (int j=0;j<4;j++){
            temp = aRxBuffer[(4*i)+j];
            temp = temp << 8*j;
            chunk32 = chunk32+temp;
            temp=0;
         // chunk32 = (chunk32 << 8) + aRxBuffer[(4*i)-j];
         // chunk32 = (chunk32 << 8) + aRxBuffer[(4*i)-j];
      }
          receivedData[i] = chunk32;
          chunk32 = 0;
  }


  uint8_t crc = HAL_CRC_Calculate(&CrcHandle, (uint32_t *)&receivedData, CRC_BUFFER_SIZE);

  if(crc == aRxBuffer[UART_BUFFER_SIZE-1]){
      BSP_LED_On(LED7);
  }else Error_Handler();

  /*##-4- Start the transmission process #####################################*/
  /* While the UART in reception process, user can transmit data through
     "aTxBuffer" buffer */
//  if(HAL_UART_Transmit_IT(&UartHandle, (uint8_t*)aTxBuffer, UART_BUFFER_SIZE)!= HAL_OK)
//  {
//    Error_Handler();
//  }

#endif /* TRANSMITTER_BOARD */

  /*##-5- Wait for the end of the transfer ###################################*/
//  while (UartReady != SET)
//  {
//  }

  /* Reset transmission flag */
//  UartReady = RESET;

  /*##-6- Compare the sent and received buffers ##############################*/
//  if(Buffercmp((uint8_t*)aTxBuffer,(uint8_t*)aRxBuffer,UART_BUFFER_SIZE))
//  {
//    Error_Handler();
//  }

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
void SystemClock_Config(void)
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
    /* Initialization Error */
    while(1);
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
    /* Initialization Error */
    while(1);
  }
}
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

/**
  * @brief  This function is executed in case of error occurrence.
  * @param  None
  * @retval None
  */
static void Error_Handler(void)
{
    /* Turn LED6 on */
  BSP_LED_On(LED6);

}


void CRC_Config(){

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
}

void UART_Config(){
    /*##-1- Configure the UART peripheral ######################################*/
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
}
