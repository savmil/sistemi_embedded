/**
  ******************************************************************************
  * @file           : i2c.h
  * @brief header file per la configurazione della periferica I2C
  ******************************************************************************
  */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef DOXYGEN_SHOULD_SKIP_THIS
#ifndef __i2c_H
#define __i2c_H
#ifdef __cplusplus

 extern "C" {
#endif
#endif
/* Includes ------------------------------------------------------------------*/
#include "main.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

extern I2C_HandleTypeDef hi2c2;

/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

void MX_I2C2_Init(uint16_t nodeAddress, uint16_t groupAddress);

/* USER CODE BEGIN Prototypes */

/* USER CODE END Prototypes */

#ifdef __cplusplus
}
#endif
#endif /*__ i2c_H */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
