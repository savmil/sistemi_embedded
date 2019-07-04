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

extern SPI_HandleTypeDef hspi2;

/** transfer states */
enum {
			TRANSFER_WAIT,
			TRANSFER_COMPLETE,
			TRANSFER_ERROR
};

void MX_SPI2_Init(void);

#endif /*__ spi_H */
