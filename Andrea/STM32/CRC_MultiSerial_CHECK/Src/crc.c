/**
  ******************************************************************************
  *@file           : crc.c
  *Permetta la configurazione della periferica CRC
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "crc.h"

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

CRC_HandleTypeDef hcrc;

/* CRC init function */
/**
 * @brief  Funzione di configurazione della periferica CRC
 * @param  CRC_Polynomial polinomio utilizzato per calcolare il CRC
 * @param  CRC_DefaultValue valore utilizzato per effettura una operazione
 * di XOR prima che il CRC venga calcolato 
 * a cui il nodo appartiene
 */
void MX_CRC_Init(uint32_t CRC_Polynomial, uint32_t CRC_DefaultValue) {

	hcrc.Instance = CRC;
	hcrc.Init.DefaultPolynomialUse = DEFAULT_POLYNOMIAL_DISABLE;
	hcrc.Init.GeneratingPolynomial = CRC_Polynomial;
	hcrc.Init.CRCLength = CRC_POLYLENGTH_32B;
	hcrc.Init.DefaultInitValueUse = CRC_DefaultValue;
	hcrc.Init.InputDataInversionMode = CRC_INPUTDATA_INVERSION_NONE;
	hcrc.Init.OutputDataInversionMode = CRC_OUTPUTDATA_INVERSION_DISABLE;
	hcrc.InputDataFormat = CRC_INPUTDATA_FORMAT_BYTES;
	if (HAL_CRC_Init(&hcrc) != HAL_OK) {
		Error_Handler();
	}

}
/**
 * @brief  Configura opportunamente l' handler della periferica CRC
 * ed i pin associati ad essa
 * @param  crcHandle handler della periferica CRC
 */
void HAL_CRC_MspInit(CRC_HandleTypeDef* crcHandle)
{

  if(crcHandle->Instance==CRC)
  {
  /* USER CODE BEGIN CRC_MspInit 0 */

  /* USER CODE END CRC_MspInit 0 */
    /* CRC clock enable */
    __HAL_RCC_CRC_CLK_ENABLE();
  /* USER CODE BEGIN CRC_MspInit 1 */

  /* USER CODE END CRC_MspInit 1 */
  }
}
/**
 * @brief  Disabilita la periferica CRC
 * @param  crcHandle handler della periferica CRC
 */
void HAL_CRC_MspDeInit(CRC_HandleTypeDef* crcHandle)
{

  if(crcHandle->Instance==CRC)
  {
  /* USER CODE BEGIN CRC_MspDeInit 0 */

  /* USER CODE END CRC_MspDeInit 0 */
    /* Peripheral clock disable */
    __HAL_RCC_CRC_CLK_DISABLE();
  /* USER CODE BEGIN CRC_MspDeInit 1 */

  /* USER CODE END CRC_MspDeInit 1 */
  }
} 

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
