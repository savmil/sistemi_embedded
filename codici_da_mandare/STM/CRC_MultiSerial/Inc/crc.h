/**
  ******************************************************************************
  * @file           : crc.h
  * @brief header file per la configurazione della periferica CRC
  ******************************************************************************
  */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef DOXYGEN_SHOULD_SKIP_THIS
#ifndef __crc_H
#define __crc_H
#ifdef __cplusplus

 extern "C" {
#endif
#endif

/* Includes ------------------------------------------------------------------*/
#include "main.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

extern CRC_HandleTypeDef hcrc;

/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

void MX_CRC_Init(uint32_t CRC_Polynomial, uint32_t CRC_DefaultValue);

/* USER CODE BEGIN Prototypes */

/* USER CODE END Prototypes */

#ifdef __cplusplus
}
#endif
#endif /*__ crc_H */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
