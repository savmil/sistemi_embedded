/**
  ******************************************************************************
  * @file           : gpio.h
  * @brief header file per la configurazione dei banchi di GPIO  
  ******************************************************************************
  */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef DOXYGEN_SHOULD_SKIP_THIS
#ifndef __gpio_H
#define __gpio_H

#endif
/* Includes ------------------------------------------------------------------*/
#include "main.h"

void MX_GPIO_Init(void);

/**
 * @brief Spegnimento di tutti i led
 */
void LedOff();

#endif /*__gpio_H */

