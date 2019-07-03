/**
  ******************************************************************************
  * @file           : spi.h
  * @brief header file per la configurazione della periferica SPI
  ******************************************************************************
  */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef DOXYGEN_SHOULD_SKIP_THIS
#ifndef __spi_H
#define __spi_H
#ifdef __cplusplus

 extern "C" {
#endif
#endif
/* Includes ------------------------------------------------------------------*/
#include "main.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

extern SPI_HandleTypeDef hspi2;

/* USER CODE BEGIN Private defines */
enum {
			TRANSFER_WAIT,
			TRANSFER_COMPLETE,
			TRANSFER_ERROR
};


/* transfer state */

/* USER CODE END Private defines */

void MX_SPI2_Init(void);

/* USER CODE BEGIN Prototypes */

/* USER CODE END Prototypes */

#ifdef __cplusplus
}
#endif
#endif /*__ spi_H */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
