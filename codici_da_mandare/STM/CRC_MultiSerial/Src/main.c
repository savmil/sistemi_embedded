/**
 * @file 
 * @brief          programma main che permette a board di comunicare
 *		   utilizzando i seguenti protocolli: UART, SPI, I2C CAN.
 *		   La board definita come Master calcola due CRC di un
 *		   messaggio, li accoda ai frame da trasmettere
 *		   e procede alla trasmissione sui canali selezionati.
*/

/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "can.h"
#include "crc.h"
#include "i2c.h"
#include "spi.h"
#include "usart.h"
#include "gpio.h"

/** Specifica le periferiche da utilizzare per effettuare la trasmissione */
#define SERIAL_SELECTED UART_MODE

/** Specifica il tipo di trasferimento */
#define UNICAST 0
#define MULTICAST 1
#define BROADCAST 2

/** Se il parametro è definito la board si comporta da master*/
#define MASTER_BOARD

/** Indirizzo del nodo e del gruppo a cui appartiene*/
#ifdef MASTER_BOARD

#define NODE_ADDRESS 0x05
#define GROUP_ADDRESS 0x07
#define SEND_ADDRESS 0x4
#define RECEIVE_ADDRESS 0x4

#else

#define NODE_ADDRESS 0x04
#define GROUP_ADDRESS 0x06
#define SEND_ADDRESS 0x05
#define RECEIVE_ADDRESS 0x5

#endif

/** Contatore delle Callback di trasmissione tramite CAN */
int tx_callback_count = 0;
/** Contatore della Callback di ricezione tramite CAN */
int rx_callback_count = 0;

/** Settato a 1 dopo la ricezione dell'interruzione scatenata dalla pressione dell' User Button  */
__IO uint32_t UserButtonStatus = 0;
__IO uint32_t wTransferState = TRANSFER_WAIT;
__IO ITStatus UartReady = RESET;
__IO ITStatus CanReady = RESET;
CAN_TxHeaderTypeDef   TxHeader;
CAN_RxHeaderTypeDef   RxHeader;

/** Messaggio da trasmettere */
//static uint32_t Frame[FRAME_SIZE] = { 0x00001234, 0x00001234, 0x0, 0x0 };

static uint32_t Frame[FRAME_SIZE];


/** Buffer utilizzati per gestire le trasmissioni e le ricezioni su ogni protocollo */
uint8_t UART_RxBuffer[BUFFER_SIZE];
uint8_t I2C_RxBuffer[BUFFER_SIZE];
uint8_t CAN_RxBuffer[BUFFER_SIZE];
uint8_t SPI_RxBuffer[BUFFER_SIZE];

uint8_t  aTxBuffer[BUFFER_SIZE];
uint8_t  CanTx_Frame[8];
uint8_t  CanRx_Frame[8];
uint8_t	 CanTxData[BUFFER_SIZE];
uint8_t	 CanRxData[BUFFER_SIZE];
uint32_t TxMailbox;

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);

void CRC_Check(uint32_t * ReceivedFrame);
uint8_t Receive_CRC(uint32_t * ReceivedData, uint8_t channel, uint16_t address);
uint8_t Send_CRC(uint32_t * MSG,uint16_t address, uint8_t channel, uint8_t mode);
void Configure_Peripheral(uint8_t peripheral, uint16_t nodeAddress, uint16_t groupAddress);

uint16_t getSSPin(uint16_t address);

/**
  * @brief  il main dell'applicazione
  */
int main(void){

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* Configure the system clock */
  SystemClock_Config();

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  Configure_Peripheral((uint8_t)SERIAL_SELECTED, NODE_ADDRESS, GROUP_ADDRESS);

#ifdef MASTER_BOARD


  	/*GENERAZIONE PSEUDO RANDOM DEL FRAME DA INVIARE */
  	srand(time(NULL));

  	for(int i=0;i<PAYLOAD_SIZE;i++){
		Frame[i] = (uint32_t) rand();
	}

  	/*posizione occupate dai CRC */
  	Frame[FRAME_SIZE-1] = 0;
  	Frame[FRAME_SIZE-2] = 0;


  	HAL_GPIO_WritePin(GPIOE, LED4_BLUE_Pin, GPIO_PIN_RESET);

	MX_CRC_Init(CRC_POLYNOMIAL_1, CRC_DEFAULTVALUE_1);
	uint32_t CRC32_1 = HAL_CRC_Calculate(&hcrc, (uint32_t *) &Frame,
	PAYLOAD_SIZE);

	MX_CRC_Init(CRC_POLYNOMIAL_2, CRC_DEFAULTVALUE_2);
	uint32_t CRC32_2 = HAL_CRC_Calculate(&hcrc, (uint32_t *) &Frame,
	PAYLOAD_SIZE);

	Frame[CRC1_OFFSET] = CRC32_1;
	Frame[CRC2_OFFSET] = CRC32_2;

	Send_CRC(Frame,SEND_ADDRESS,SERIAL_SELECTED,UNICAST);

#endif

  /* Infinite loop */
	while (1){
		LedOff();
		Receive_CRC(Frame, SERIAL_SELECTED,RECEIVE_ADDRESS);
		LedOff();
		Send_CRC(Frame,SEND_ADDRESS,SERIAL_SELECTED,UNICAST);
	}
}

/**
  * @brief Gestisce il clock di sistema
  */
void SystemClock_Config(void){

  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};
  RCC_PeriphCLKInitTypeDef PeriphClkInit = {0};

  /** Initializes the CPU, AHB and APB busses clocks */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI|RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_ON;
  RCC_OscInitStruct.HSEPredivValue = RCC_HSE_PREDIV_DIV1;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL6;

  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK){
    Error_Handler();
  }
  /** Initializes the CPU, AHB and APB busses clocks */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK|RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
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
/**
 * @brief  Converte un frame da un formato uint32_t ad uno uint8_t
 * @param  in_buffer32 puntatore ad un dato di tipo uint32_t
 * @param  out_buffer8  puntatore ad un dato di tipo uint8_t
 */
void Frame32to8(uint32_t * in_buffer32, uint8_t * out_buffer8) {

	uint8_t chunk = 0;

	for (int i = 0; i < FRAME_SIZE; i++) {
		for (int j = 0; j < 4; j++) {
			chunk = in_buffer32[i] >> j * 8 & 255;
			out_buffer8[4 * i + j] = chunk;
		}
	}

}

/**
 * @brief  Converte un frame da un formato uint8_t ad uno uint32_t
 * @param  in_buffer8 puntatore ad un dato  di tipo uint8_t
 * @param  out_buffer32 puntatore ad un dato di tipo uint32_t
 */
void Frame8to32(uint8_t * in_buffer8, uint32_t * out_buffer32) {

	uint32_t chunk32 = 0;
	uint32_t temp = 0;

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

/**
 * @brief  Invia il messaggio sulle varie periferiche
 * @param  MSG messaggio da inviare
 * @param  address indirizzo della periferica da contattare se previsto dalla
 * 		   modalità di comunicazione
 * @param channel indica le periferiche sulle queli effettuare la trasmissione
 */
uint8_t Send_CRC(uint32_t * MSG,uint16_t address, uint8_t channel, uint8_t mode) {

	bool UART_ENABLED =  UART_MODE == (UART_MODE & channel) ;
	bool I2C_ENABLED =  I2C_MODE == (I2C_MODE & channel) ;
	bool SPI_ENABLED =  SPI_MODE == (SPI_MODE & channel) ;
	bool CAN_ENABLED =  CAN_MODE == (CAN_MODE & channel) ;

	uint8_t completedChannel = 0;

/** Viene effettuato il controllo sulla compatibilità della modalità di trasmissione scelta e i canali selezionati */
	if(((mode == MULTICAST)||(mode == BROADCAST)) && (channel != CAN_MODE)){
			completedChannel = -1;
			return completedChannel;
		}
/** Attesa di pressione User Button */
	#ifdef MASTER_BOARD
		while (UserButtonStatus == 0) {
			HAL_GPIO_TogglePin(GPIOE, LED4_BLUE_Pin);
			HAL_Delay(100);
		}
	#endif

	uint8_t aTxBuffer[BUFFER_SIZE];
/** Le funzioni fornite dall'Hardware Abstraction Layer per la trasmissione e ricezione utilizzano
 *  buffer da 8 bit. E' necessario dunque convertire il messaggio originale, contenuto in un buffer di FRAME_SIZE
 *  valori da 32 bit, in un buffer contenente BUFFER_SIZE valori da 8 bit*/
	Frame32to8(MSG, aTxBuffer);

/** Se è stata richiesta la trasmissione sul canale UART viene effettuata la trasmissione */
	if (UART_ENABLED){
/** La trasmissione è effettuata chiamando la seguente funzione, passando l'UART handler, un puntatore al buffer contenente
 *  il messaggio da trasmettere e la sua dimensione */
		if (HAL_UART_Transmit_IT(&huart2, (uint8_t*) aTxBuffer, BUFFER_SIZE) != HAL_OK)
			Error_Handler();
/** Il programma attende finchè il valore della variabile UartReady è RESET. All'avvenuto completamento della trasmissione la callback
 *  HAL_UART_TxCpltCallback setterà il valore permettendo di avanzare con l'esecuzione */
		while (UartReady != SET) {
		}

		UartReady = RESET;
/** Viene aggiornato il parametro relativo ai canali sui quali è terminata la trasmissione */
		completedChannel |= UART_MODE;

	}

	if (I2C_ENABLED){

		HAL_Delay(100);

		if (HAL_I2C_Master_Transmit_IT(&hi2c2, (uint16_t) address, (uint8_t*) aTxBuffer, BUFFER_SIZE) != HAL_OK) {

/** Se l'errore di trasmissione è dato dal mancato ack da parte dello slave esso viene ignorato*/
			 if (HAL_I2C_GetError(&hi2c2) != HAL_I2C_ERROR_AF)
			      Error_Handler();
		}
/** Il programma attende finchè lo stato di I2C non è uguale a READY */
		while (HAL_I2C_GetState(&hi2c2) != HAL_I2C_STATE_READY){
		}

		completedChannel |= I2C_MODE;
	}

	if(CAN_ENABLED){

/** Standard CAN Identifier: identificativo del messaggio codificato su 11 bit secondo il protocollo CAN Standard */
		TxHeader.StdId = address;
/** Extended CAN Identifier: identificativo del messaggio codificato su 29 bit secondo il protocollo CAN Extended */
		TxHeader.ExtId = 0x00;
/** Tipo di messaggio */
		TxHeader.RTR = CAN_RTR_DATA;
/** Tipo di identificativo per il messaggio da trasmettere: Standard o Extended */
		TxHeader.IDE = CAN_ID_STD;
/** Lunghezza in byte del messaggio da trasmettere. Può assumere un valore da 0 ad 8 */
		TxHeader.DLC = 8;
/** Timestamp acquisito all'avvio della trasmissione del Frame. Se abilitato viene aggiunto al messaggio. */
		TxHeader.TransmitGlobalTime = DISABLE;
/** Dal momento che il campo Data Bytes del frame CAN, ovvero il messaggio da trasmettere, può essere massimo di 8 bytes
 *  vengono effettuate più chiamate alla funzione HAL_CAN_AddTxMessage. Questa prende in ingresso l'handler di CAN, l'header
 *  del messaggio appena costruito e un buffer contenente dati di 8 bit. Ha il compito di aggiungere il messaggio alla
 *  prima mailbox di trasmissione che rileva libera. L'identificativo della mailbox nella quale ha deposto il messaggio
 *  viene ritornato mediante il parametro TxMailbox */
		for(int i=0;i<BUFFER_SIZE/8;i++){
			for(int j=0;j<8;j++){
				CanTx_Frame[j] = aTxBuffer[i*8+j];
			}

			HAL_CAN_AddTxMessage(&CanHandle, &TxHeader, CanTx_Frame, &TxMailbox);
			HAL_Delay(50);
		}
/** Quando è stato eseguito un numero di callback di trasmissione che indica l'avvenuto trasferimento di tutti i chunk
 *  da 8 bytes trasmessi, viene aggiornato il parametro relativo ai canali sui quali è terminata la trasmissione*/
		while(tx_callback_count < CAN_CALLBACK_COUNT){

		}
			completedChannel |= CAN_MODE;
	}

	if(SPI_ENABLED){

/** L'indirizzo del nodo destinazione viene utilizzato per calcolare quale Slave Select deve essere deasserito
 *  per selezionare lo slave al quale si vuole trasmettere il messaggio */
	#ifdef MASTER_BOARD
		uint16_t slaveSelectPin = getSSPin(address);
		HAL_GPIO_WritePin(SPI_EN_OUTPUT_GPIO_Port,slaveSelectPin ,
				GPIO_PIN_RESET);

/** Se la board non è master prima di poter effettuare la trasmissione è necessario attendere che il master porti al valore
 *  basso lo Slave Select */
	#else
		while(HAL_GPIO_ReadPin(SPI_EN_OUTPUT_GPIO_Port, SPI_EN_INPUT_Pin) != GPIO_PIN_RESET){}
	#endif

	if (HAL_SPI_Transmit_IT(&hspi2, (uint8_t*) aTxBuffer, BUFFER_SIZE) != HAL_OK)
			Error_Handler();

/** Il programma attende che il trasferimento sia completo. All'avvenuto completamento della trasmissione, la callback
 *  HAL_SPI_TxCpltCallback setterà il valore dello stato a TRANSFER_COMPLETE permettendo di avanzare con l'esecuzione */
	while (wTransferState != TRANSFER_COMPLETE) {}

/** Viene riportato al valore alto lo Slave Select e resettato il valore dello stato */
	#ifdef MASTER_BOARD
		HAL_GPIO_WritePin(SPI_EN_OUTPUT_GPIO_Port, slaveSelectPin, GPIO_PIN_SET);
	#endif

	wTransferState = TRANSFER_WAIT;

	completedChannel |= SPI_MODE;

	}

	return completedChannel;
}
/**
 * @brief  Abilita la ricezione del frame sulle periferiche selezionate
 * @param  ReceivedData struttura contenete i dati ricevuti
 * @param  channel indica le periferiche da cui effettuare la ricezione
 * @param  address indica lo slave SPI con cui voglio comunicare, permettendo
 * 		   di scegliere lo slave select opportuno
 */
uint8_t Receive_CRC(uint32_t * ReceivedData, uint8_t channel, uint16_t address) {

		uint8_t receivedChannel = 0x0;

		bool UART_ENABLED 	    =	(UART_MODE	& channel) == 	UART_MODE;
		bool I2C_ENABLED		= 	((I2C_MODE	& channel) == 	I2C_MODE);
		bool SPI_ENABLED		=	(SPI_MODE	& channel) ==	 SPI_MODE;
		bool CAN_ENABLED		=	(CAN_MODE	& channel) == 	CAN_MODE;

		if (UART_ENABLED){

			//while(HAL_UART_GetState(&huart2) == HAL_UART_STATE_BUSY_RX){}

/** La ricezione è effettuata chiamando la seguente funzione, passando l'UART handler, un puntatore al buffer
 *  in cui salvare il messaggio ricevuto e la sua dimensione */
			if (HAL_UART_Receive_IT(&huart2, (uint8_t *) UART_RxBuffer, BUFFER_SIZE) != HAL_OK)
				Error_Handler();

/** Il programma attende finchè il valore della variabile UartReady è RESET. All'avvenuto completamento della ricezione la callback
 *  HAL_UART_RxCpltCallback setterà il valore permettendo di avanzare con l'esecuzione */
			while(UartReady != SET){
			}
				UartReady = RESET;
/** Le funzioni fornite dall'Hardware Abstraction Layer per la trasmissione e ricezione utilizzano
*   buffer da 8 bit. E' necessario dunque riconvertire il messaggio ricevuto, contenuto in un buffer di BUFFER_SIZE valori da 8 bit
*   in un buffer contenente FRAME_SIZE valori da 32 bit */
				Frame8to32(UART_RxBuffer, ReceivedData);

/** La seguente chiamata provvede a ricalcolare i due CRC dal payload del messggio ricevuto
 *  e a confrontarli con quelli contenuti nel messaggio. Queste ultime due chiamate vengono
 *  ripetute esattamente nelle successive sezioni relative alle altre periferiche. */
				CRC_Check(ReceivedData);

				receivedChannel = receivedChannel | UART_MODE;
			  }

		if (I2C_ENABLED){


			if(HAL_I2C_Slave_Receive_IT(&hi2c2, (uint8_t *)I2C_RxBuffer, BUFFER_SIZE) != HAL_OK)
				Error_Handler();

/** Il programma attende finchè lo stato di I2C non è uguale a READY */
			while(HAL_I2C_GetState(&hi2c2) != HAL_I2C_STATE_READY){
			}

				Frame8to32(I2C_RxBuffer, ReceivedData);
				CRC_Check(ReceivedData);

				receivedChannel = receivedChannel | I2C_MODE;
			}

		if(CAN_ENABLED){

/** La ricezione su CAN è effettuata nella callback relativa all'avvenuta ricezione. Vedi documentazione esterna */
/*	while(rx_callback_count < CAN_CALLBACK_COUNT){}

				Frame8to32(CAN_RxBuffer, ReceivedData);
				CRC_Check(ReceivedData);

				receivedChannel = receivedChannel | CAN_MODE;
*/
		}

		if(SPI_ENABLED){
			#ifdef MASTER_BOARD

/** L'indirizzo del nodo dal quale si vuole ricevere viene utilizzato dal master per calcolare quale Slave Select
 *  deve essere deasserito per selezionare lo slave dal quale si vuole ricevere */
				uint16_t slaveSelectPin = getSSPin(address);
				HAL_GPIO_WritePin(SPI_EN_OUTPUT_GPIO_Port, slaveSelectPin, GPIO_PIN_RESET);

/** Se la board non è master prima di poter effettuare la ricezione è necessario attendere che il master porti al valore
*  basso lo Slave Select */
			#else
				while (HAL_GPIO_ReadPin(SPI_EN_INPUT_GPIO_Port, SPI_EN_INPUT_Pin) == GPIO_PIN_SET) {}
			#endif

			if (HAL_SPI_Receive_IT(&hspi2, (uint8_t*) SPI_RxBuffer, BUFFER_SIZE) != HAL_OK)
				Error_Handler();

/** Il programma attende che la trasmissione sia completa. All'avvenuto completamento della ricezione la callback
*   HAL_SPI_RxCpltCallback setterà il valore dello stato a TRANSFER_COMPLETE permettendo di avanzare con l'esecuzione */
			while((wTransferState != TRANSFER_COMPLETE)){}

/** Viene riportato al valore alto lo Slave Select e resettato il valore dello stato */
			#ifdef MASTER_BOARD
				HAL_GPIO_WritePin(SPI_EN_OUTPUT_GPIO_Port, slaveSelectPin, GPIO_PIN_SET);
			#endif


			wTransferState = TRANSFER_WAIT;

			Frame8to32(SPI_RxBuffer, ReceivedData);
			CRC_Check(ReceivedData);

			receivedChannel = receivedChannel | SPI_MODE;


			}

		return receivedChannel;
}

/**
 * @brief  Ricalcola i due CRC del messaggio e li confronta con quelli ricevuti
 * @param  ReceivedFrame messaggio ricevuto
 */
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

/** Reinserisce i due CRC ricalcolati dal messaggio alla fine dello stesso */
	ReceivedFrame[CRC1_OFFSET] = CRC32_1;
	ReceivedFrame[CRC2_OFFSET] = CRC32_2;

}

/**
 * @brief  Configura le periferiche affinchè possano ricevere ed inviare messaggi
 * @param  peripheral valore che indica quale periferiche abilitare
 * @param  nodeAddress indirizzo del nodo da contattare, utilizzato se la comunicazione lo prevede
 * @param  groupAddress indirizzo del gruppo da contattare, utilizzato se la comunicazione lo prevede
 */
void Configure_Peripheral(uint8_t peripheral, uint16_t nodeAddress, uint16_t groupAddress)
{

	if((UART_MODE & peripheral) ==  UART_MODE)
		MX_USART2_UART_Init(UART_BAUDRATE);

	if((I2C_MODE & peripheral) == I2C_MODE)
		MX_I2C2_Init(nodeAddress,groupAddress);

	if((SPI_MODE & peripheral) == SPI_MODE){
		#ifdef MASTER_BOARD
				hspi2.Init.Mode = SPI_MODE_MASTER;
		#else
				hspi2.Init.Mode = SPI_MODE_SLAVE;
		#endif
		MX_SPI2_Init();

	}

	if((CAN_MODE & peripheral) == CAN_MODE)
		MX_CAN_Init(nodeAddress,groupAddress);
}


/**
 * @brief  Callback trasmissione completata sul canale UART
 * @param  UartHandle handler alla struttura che gestisce UART
 */
void HAL_UART_TxCpltCallback(UART_HandleTypeDef *UartHandle) {
	/* Set transmission flag: transfer complete */
	UartReady = SET;

	/* Turn LED3 on: Transfer in transmission process is correct */
	HAL_GPIO_WritePin(GPIOE, LED4_BLUE_Pin, GPIO_PIN_SET);
}


/**
 * @brief  Callback ricezione completata sul canale UART
 * @param  UartHandle handler alla struttura che gestisce UART
 */
void HAL_UART_RxCpltCallback(UART_HandleTypeDef *UartHandle) {
	/* Set transmission flag: transfer complete */
	UartReady = SET;

	/* Turn LED5 on: Transfer in reception process is correct */
	HAL_GPIO_WritePin(GPIOE, LED9_BLUE_Pin, GPIO_PIN_SET);

}

/**
 * @brief Callback per errori di comunicazione sul canale UART
 * @param  UartHandle handler alla struttura che gestisce UART
 */
void HAL_UART_ErrorCallback(UART_HandleTypeDef *UartHandle) {
	/* Turn LED6 on: Transfer error in reception/transmission process */
	HAL_GPIO_WritePin(GPIOE, LED3_RED_Pin, GPIO_PIN_SET);
}

/**
 * @brief  Callback trasmissione completata da parte di un master su I2C
 * @param  hi2c2 handler alla struttura che gestisce I2C
 */
void HAL_I2C_MasterTxCpltCallback(I2C_HandleTypeDef *hi2c2) {
	/* Toggle LED7: Transfer in transmission process is correct */
	HAL_GPIO_WritePin(GPIOE, LED4_BLUE_Pin, GPIO_PIN_SET);
}
/**
 * @brief  Callback ricezione completata da parte di un master su I2C
 * @param  hi2c2 handler alla struttura che gestisce I2C
 */
void HAL_I2C_MasterRxCpltCallback(I2C_HandleTypeDef *hi2c2) {
	/* Toggle LED7: Transfer in reception process is correct */
	HAL_GPIO_WritePin(GPIOE, LED9_BLUE_Pin, GPIO_PIN_SET);

}
/**
 * @brief  Callback trasmissione completata da parte di uno slave su I2C
 * @param  hi2c2 handler alla struttura che gestisce I2C
 */
void HAL_I2C_SlaveTxCpltCallback(I2C_HandleTypeDef *hi2c2)
{
	/* Toggle LED7: Transfer in transmission process is correct */
	HAL_GPIO_WritePin(GPIOE, LED4_BLUE_Pin, GPIO_PIN_SET);
}
/**
 * @brief  Callback ricezione completata da parte di uno slave su I2C
 * @param  hi2c2 handler alla struttura che gestisce I2C
 */
void HAL_I2C_SlaveRxCpltCallback(I2C_HandleTypeDef *hi2c2)
{
	/* Toggle LED7: Transfer in reception process is correct */
	HAL_GPIO_WritePin(GPIOE, LED9_BLUE_Pin, GPIO_PIN_SET);

}


/**
 * @brief  Callback per errori di comunicazione sul canale I2C
 * @param  hi2c2 handler alla struttura che gestisce I2C
 * @retval None
 */
void HAL_I2C_ErrorCallback(I2C_HandleTypeDef *hi2c2) {
	/** 1- When Slave don't acknowledge it's address, Master restarts communication.
	 *  2- When Master don't acknowledge the last data transferred.
	 */
	if (HAL_I2C_GetError(hi2c2) != HAL_I2C_ERROR_AF) {
		/* Turn LED3 on: Transfer error in reception/transmission process */
		HAL_GPIO_WritePin(GPIOE, LED3_RED_Pin, GPIO_PIN_SET);

	}
}
/**
 * @brief  Callback trasmissione completata sul canale SPI
 * @param  hspi handler alla struttura che gestisce SPI
 */
void HAL_SPI_TxCpltCallback(SPI_HandleTypeDef *hspi) {
	/* Turn LED on: Transfer in transmission process is correct */
	HAL_GPIO_WritePin(GPIOE, LED4_BLUE_Pin, GPIO_PIN_SET);
	/* Turn LED on: Transfer in reception process is correct */
	//BSP_LED_On(LED4);
	wTransferState = TRANSFER_COMPLETE;
}
/**
 * @brief  Callback ricezione completata sul canale SPI
 * @param  hspi handler alla struttura che gestisce SPI
 */
void HAL_SPI_RxCpltCallback(SPI_HandleTypeDef *hspi) {
	/* Turn LED on: Transfer in reception process is correct */
	HAL_GPIO_WritePin(GPIOE, LED9_BLUE_Pin, GPIO_PIN_SET);
	wTransferState = TRANSFER_COMPLETE;
}

/**
 * @brief  Callback per errori di comunicazione sul canale SPI
 * @param  hspi handler alla struttura che gestisce SPI
 */
void HAL_SPI_ErrorCallback(SPI_HandleTypeDef *hspi) {
	wTransferState = TRANSFER_ERROR;
}

/**
 * @brief Callback associata alla pressione dell'User Button
 * @param GPIO_Pin il pin del GPIO a cui è collegato il pin
 */
void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin) {
	if (GPIO_Pin == USER_BTN_Pin) {
		UserButtonStatus = 1;
	}
}

/**
 * @brief  Callback trasmimssione completata della Mailbox0 di CAN.
 * 		   Indica che tutti i byte che dovevano essere trasmessi
 * 		   dalla mailbox 0 sono stati inviati.
 * @param  hcan handler alla struttura che gestisce CAN
 */
void HAL_CAN_TxMailbox0CompleteCallback(CAN_HandleTypeDef *hcan)
{
/** Viene incrementato il contatore delle callback di trasmissione per gestire l'invio di più*/
 tx_callback_count++;
}

/**
 * @brief  Callback associata alla presenza di un nuovo messaggio pendente
 * 		   nella coda di ricezione 0.
 * @param  hcan handler alla struttura che gestisce CAN
 */
void HAL_CAN_RxFifo0MsgPendingCallback(CAN_HandleTypeDef *hcan)
{

/** Prelevievo di un messaggio dalla FIFO0 di ricezione */
	HAL_CAN_GetRxMessage(&CanHandle, CAN_RX_FIFO0, &RxHeader, CanRx_Frame);

/** Se l'header ricevuto non contiene il campo tipo, il tipo di identificativo e la lunghezza del data bytes attesi */
	if((RxHeader.RTR != CAN_RTR_DATA) ||  (RxHeader.IDE != CAN_ID_STD) ||(RxHeader.DLC != 8)){
		Error_Handler();
	}
	else{
		/* OK: Turn on LED5 */
		BSP_LED_On(LED5);
		for(int k=0; k<8; k++){
			CAN_RxBuffer[rx_callback_count*8+k] = CanRx_Frame[k];
	 }
	}
  rx_callback_count++;

/** Quando sono stati ricevuti tutti i chunk del messaggio si può procedere con il confronto dei CRC*/
  if(rx_callback_count == CAN_CALLBACK_COUNT){
	  uint32_t ReceivedData[FRAME_SIZE];
	  Frame8to32(CAN_RxBuffer, ReceivedData);
	  CRC_Check(ReceivedData);
  }

}

/**
 * @brief  In caso di un qualsiasi errore viene eseguita questa funzionae
 */
void Error_Handler(void) {

	HAL_GPIO_WritePin(GPIOE, LED3_RED_Pin, GPIO_PIN_SET);
	while(1){
		;;
	}
}
/**
 * @brief  Dato l'indirizzo del dispositivo ritorna il pin GPIO a cui è collegato il suo slave select
 * @param address indirizzo della periferica SPI
 */
uint16_t getSSPin(uint16_t address){
	return SPI_EN_OUTPUT_Pin;
}
