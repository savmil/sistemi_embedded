#include "main.h"


//#define MASTER_BOARD

/* UART handler declaration */
UART_HandleTypeDef UartHandle;
__IO ITStatus UartReady = RESET;
__IO uint32_t UserButtonStatus = 0;  /* set to 1 after User Button interrupt  */

/* CRC handler declaration */
CRC_HandleTypeDef   CrcHandle;

static  uint32_t Frame[FRAME_SIZE]= {0x00001234,0x0,0x0 };

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
static void Error_Handler(void);

void CRC_Config(uint32_t CRC_Polynomial,uint32_t CRC_DefaultValue);
void Send_CRC(uint32_t * MSG,uint8_t channel);
void UART_Config(uint32_t Baudrate);
void LedConfig();
void CRC_Check(uint32_t  * ReceivedFrame);
void Receive_CRC(uint32_t * ReceivedData, uint8_t channel);



/**
  * @brief  Main program
  * @param  None
  * @retval None
  */
int main(void)
{

	HAL_Init();

	SystemClock_Config();
	LedConfig();

#ifdef MASTER_BOARD
	CRC_Config(CRC_POLYNOMIAL_1,CRC_DEFAULTVALUE_1);
	uint32_t CRC32_1 = HAL_CRC_Calculate(&CrcHandle, (uint32_t *)&Frame, PAYLOAD_SIZE);

	CRC_Config(CRC_POLYNOMIAL_2,CRC_DEFAULTVALUE_2);
	uint32_t CRC32_2 = HAL_CRC_Calculate(&CrcHandle, (uint32_t *)&Frame, PAYLOAD_SIZE);

	Frame[CRC1_OFFSET]=CRC32_1;
	Frame[CRC2_OFFSET]=CRC32_2;
 #else
	Receive_CRC(Frame,UART);
#endif

	Send_CRC(Frame,UART);
	Receive_CRC(Frame,UART);

	while (1){}
}

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
  * @brief  This function is executed in case of error occurrence.
  * @param  None
  * @retval None
  */
static void Error_Handler(void)
{
    /* Turn LED6 on */
  BSP_LED_On(LED6);

}

void CRC_Check(uint32_t  * ReceivedFrame){

	CRC_Config(CRC_POLYNOMIAL_1,CRC_DEFAULTVALUE_1);
	uint32_t CRC32_1 = HAL_CRC_Calculate(&CrcHandle, (uint32_t *)ReceivedFrame, PAYLOAD_SIZE);

	CRC_Config(CRC_POLYNOMIAL_2,CRC_DEFAULTVALUE_2);
	uint32_t CRC32_2 = HAL_CRC_Calculate(&CrcHandle, (uint32_t *)ReceivedFrame, PAYLOAD_SIZE);

	if (CRC32_1 != ReceivedFrame[CRC1_OFFSET])
		Error_Handler();
	else
		BSP_LED_On(LED7);

	if (CRC32_2 != ReceivedFrame[CRC2_OFFSET])
		Error_Handler();
	else
		BSP_LED_On(LED9);

}

void LedConfig(){
	  /* Configure LED3, LED4, LED5 and LED6 */
	  BSP_LED_Init(LED3);
	  BSP_LED_Init(LED4);
	  BSP_LED_Init(LED5);
	  BSP_LED_Init(LED6);
	  BSP_LED_Init(LED7);
	  BSP_LED_Init(LED9);
}

void Frame32to8(uint32_t * in_buffer32,uint8_t * out_buffer8){

	uint8_t chunk =0;

	   for(int i=0;i<FRAME_SIZE;i++){
		  for (int j=0;j<4;j++){
			  chunk = in_buffer32[i] >> j*8 & 255;
			  out_buffer8[4*i+j]=chunk;
		  }
	   }

}

void Frame8to32(uint8_t * in_buffer8, uint32_t * out_buffer32){

	  uint32_t chunk32=0;
	  uint32_t temp=0;

	  for (int i=0;i<FRAME_SIZE;i++){
		  for (int j=0;j<4;j++){
			  	temp = in_buffer8[(4*i)+j];
			  	temp = temp << 8*j;
			  	chunk32 = chunk32+temp;
			  	temp=0;
		  }
		  out_buffer32[i] = chunk32;
		  	  chunk32 = 0;
	  }

}

void CRC_Config(uint32_t CRC_Polynomial,uint32_t CRC_DefaultValue){

/*	 if (HAL_CRC_DeInit(&CrcHandle) != HAL_OK)
		   {

		     Error_Handler();
		   }
*/
	/*##-1- Configure the CRC peripheral #######################################*/
	   CrcHandle.Instance = CRC;

	   /* The default polynomial is not used. It is required to defined it in CrcHandle.Init.GeneratingPolynomial*/
	   CrcHandle.Init.DefaultPolynomialUse    = DEFAULT_POLYNOMIAL_DISABLE;

	   /* Set the value of the polynomial */
	   CrcHandle.Init.GeneratingPolynomial    = CRC_Polynomial;

	   /* The size of the polynomial to configure the IP is 8b*/
	   CrcHandle.Init.CRCLength               = CRC_POLYLENGTH_32B;

	   /* The default init value is used */
	   CrcHandle.Init.DefaultInitValueUse     = CRC_DefaultValue;

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

void UART_Config(uint32_t Baudrate){
	/*##-1- Configure the UART peripheral ######################################*/
	  UartHandle.Instance        = USARTx;

	  UartHandle.Init.BaudRate   = Baudrate;
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

void Send_CRC(uint32_t * MSG,uint8_t channel){

	switch (channel){

	case 0:
		UART_Config(UART_BAUDRATE);

		uint8_t  aTxBuffer[UART_BUFFER_SIZE];
		Frame32to8(MSG,aTxBuffer);

		BSP_PB_Init(BUTTON_USER, BUTTON_MODE_EXTI);

		while(UserButtonStatus == 0)
		{
			BSP_LED_Toggle(LED4);
			HAL_Delay(100);
		}

		BSP_LED_Off(LED4);

		if(HAL_UART_Transmit_IT(&UartHandle, (uint8_t*)aTxBuffer, UART_BUFFER_SIZE)!= HAL_OK)
			Error_Handler();

		while (UartReady != SET){}

		UartReady = RESET;

}
}
void Receive_CRC(uint32_t * ReceivedData, uint8_t channel){

	switch(channel){

		case 0:
			UART_Config(UART_BAUDRATE);
			uint8_t  aRxBuffer[UART_BUFFER_SIZE];

			if(HAL_UART_Receive_IT(&UartHandle, (uint8_t *)aRxBuffer, UART_BUFFER_SIZE) != HAL_OK)
				Error_Handler();

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

			UartReady = RESET;
			BSP_LED_Off(LED4);


			Frame8to32(aRxBuffer,ReceivedData);
			CRC_Check(ReceivedData);

	}




}

