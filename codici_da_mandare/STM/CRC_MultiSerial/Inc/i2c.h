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

#endif
/* Includes ------------------------------------------------------------------*/
#include "main.h"

extern I2C_HandleTypeDef hi2c2;

void MX_I2C2_Init(uint16_t nodeAddress, uint16_t groupAddress);

#endif /*__ i2c_H */
