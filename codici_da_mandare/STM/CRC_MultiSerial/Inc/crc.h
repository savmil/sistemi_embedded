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

#endif

/* Includes ------------------------------------------------------------------*/
#include "main.h"

extern CRC_HandleTypeDef hcrc;

void MX_CRC_Init(uint32_t CRC_Polynomial, uint32_t CRC_DefaultValue);

#endif /*__ crc_H */

