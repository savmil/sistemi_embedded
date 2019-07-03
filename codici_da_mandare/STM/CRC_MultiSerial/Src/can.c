/**
  ******************************************************************************
  * @file           : can.c
  * Permette la configurazione della periferica CAN
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "can.h"

CAN_HandleTypeDef CanHandle;
CAN_FilterTypeDef sFilterConfig;
CAN_FilterTypeDef sFilterBroadcastConfig;

/* CAN init function */
/**
 * @brief  Funzione di configurazione della periferica CAN
 * modalità di utilizzo, filtri
 * @param  nodeAddress setta l' indentificativo del nodo 
 * @param  groupAddress setta l' identificato del gruppo
 * a cui il nodo appartiene
 */
void MX_CAN_Init(uint16_t nodeAddress, uint16_t groupAddress)
{

  /*##-1- Configure the CAN peripheral #######################################*/
  CanHandle.Instance = CAN;

  CanHandle.Init.TimeTriggeredMode = DISABLE;
  CanHandle.Init.AutoBusOff = DISABLE;
  CanHandle.Init.AutoWakeUp = DISABLE;
  CanHandle.Init.AutoRetransmission = ENABLE;
  CanHandle.Init.ReceiveFifoLocked = DISABLE;
  CanHandle.Init.TransmitFifoPriority = DISABLE;
  CanHandle.Init.Mode = CAN_MODE_LOOPBACK;
  CanHandle.Init.SyncJumpWidth = CAN_SJW_1TQ;
  CanHandle.Init.TimeSeg1 = CAN_BS1_4TQ;
  CanHandle.Init.TimeSeg2 = CAN_BS2_2TQ;
  CanHandle.Init.Prescaler = 6;

  if(HAL_CAN_Init(&CanHandle) != HAL_OK){
    /* Initialization Error */
	 Error_Handler();
  }

  /*##-2- Configure the CAN Filter ###########################################*/
  sFilterConfig.FilterBank = 0;

 /** messaggi sono filtrati utilizzando una lista di ID */
  sFilterConfig.FilterMode = CAN_FILTERMODE_IDLIST;

/** si utilizzano due da filtri 16 bit, dato che limite della rete risulta essere i 10 bit dell'indirizzo di I2C*/
  sFilterConfig.FilterScale = CAN_FILTERSCALE_16BIT;
/** indirizzo dispositivo */
  sFilterConfig.FilterIdHigh = nodeAddress<<5;
/** indirizzo gruppo */
  sFilterConfig.FilterIdLow = groupAddress<<5;

  sFilterConfig.FilterFIFOAssignment = CAN_RX_FIFO0;
  sFilterConfig.FilterActivation = ENABLE;
  sFilterConfig.SlaveStartFilterBank = 0;

  if(HAL_CAN_ConfigFilter(&CanHandle, &sFilterConfig) != HAL_OK){
	/* Filter configuration Error */
	Error_Handler();
  }

  sFilterBroadcastConfig.FilterBank = 1;

  sFilterBroadcastConfig.FilterMode = CAN_FILTERMODE_IDLIST;

  sFilterBroadcastConfig.FilterScale = CAN_FILTERSCALE_16BIT;
  sFilterBroadcastConfig.FilterMaskIdLow = BROADCAST_ADDRESS<<5;

  sFilterBroadcastConfig.FilterFIFOAssignment = CAN_RX_FIFO0;
  sFilterBroadcastConfig.FilterActivation = ENABLE;
  sFilterBroadcastConfig.SlaveStartFilterBank = 14;

   if(HAL_CAN_ConfigFilter(&CanHandle, &sFilterBroadcastConfig) != HAL_OK){
  	Error_Handler();
    }


  /*##-3- Start the CAN peripheral ###########################################*/
  if (HAL_CAN_Start(&CanHandle) != HAL_OK){
    /* Start Error */
	Error_Handler();
  }

  if (HAL_CAN_ActivateNotification(&CanHandle, CAN_IT_RX_FIFO0_MSG_PENDING | CAN_IT_TX_MAILBOX_EMPTY) != HAL_OK){
    /* Notification Error */
	Error_Handler();
  }
}
/**
 * @brief  Configura opportunamente l' handler della periferica CAN
 * 		   ed i pin associati ad essa
 * @param  canHandle handler della periferica CAN
 */
void HAL_CAN_MspInit(CAN_HandleTypeDef* canHandle)
{

GPIO_InitTypeDef   GPIO_InitStruct;

  /*##-1- Enable peripherals and GPIO Clocks #################################*/
  /* CAN1 Periph clock enable */
  CANx_CLK_ENABLE();
  /* Enable GPIO clock ****************************************/
  CANx_GPIO_CLK_ENABLE();

  /*##-2- Configure peripheral GPIO ##########################################*/
  /* CAN TX GPIO pin configuration */
  GPIO_InitStruct.Pin = CANx_TX_PIN;
  GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
  GPIO_InitStruct.Pull = GPIO_PULLUP;
  GPIO_InitStruct.Alternate =  CANx_TX_AF;

  HAL_GPIO_Init(CANx_TX_GPIO_PORT, &GPIO_InitStruct);

  /* CAN RX GPIO pin configuration */
  GPIO_InitStruct.Pin = CANx_RX_PIN;
  GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
  GPIO_InitStruct.Pull = GPIO_PULLUP;
  GPIO_InitStruct.Alternate =  CANx_RX_AF;

  HAL_GPIO_Init(CANx_TX_GPIO_PORT, &GPIO_InitStruct);

  /* CAN interrupt Init */
  HAL_NVIC_SetPriority(USB_HP_CAN_TX_IRQn, 0, 0);
  HAL_NVIC_EnableIRQ(USB_HP_CAN_TX_IRQn);
  HAL_NVIC_SetPriority(USB_LP_CAN_RX0_IRQn, 0, 0);
  HAL_NVIC_EnableIRQ(USB_LP_CAN_RX0_IRQn);

}
/**
 * @brief  Disabilita la periferica CAN
 * @param  canHandle handler della periferica CAN
 */
void HAL_CAN_MspDeInit(CAN_HandleTypeDef* canHandle)
{

  /*##-1- Reset peripherals ##################################################*/
  CANx_FORCE_RESET();
  CANx_RELEASE_RESET();

  /*##-2- Disable peripherals and GPIO Clocks ################################*/
  /* De-initialize the CAN1 TX GPIO pin */
  HAL_GPIO_DeInit(CANx_TX_GPIO_PORT, CANx_TX_PIN);
  /* De-initialize the CAN1 RX GPIO pin */
  HAL_GPIO_DeInit(CANx_RX_GPIO_PORT, CANx_RX_PIN);

  HAL_GPIO_DeInit(GPIOD, GPIO_PIN_0|GPIO_PIN_1);

  HAL_NVIC_DisableIRQ(USB_HP_CAN_TX_IRQn);
  HAL_NVIC_DisableIRQ(USB_LP_CAN_RX0_IRQn);

}
