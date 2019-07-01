#ifndef  __UART_LIST__
#define __UART_LIST__

#include "UART.h"
/**
 * @file UART_list.h
 * @brief Header file UART_list
 */

/**
 * @brief Struttura dati per la gestione di più device UART da parte del driver      
 */
typedef struct {
	UART **device_list;	    /**< 	array di puntatori a UART, ciascuno dei quali si riferisce ad un device*/
	uint32_t list_size;			/**< 	dimensione della lista, ovvero il numero massimo di device gestibili*/
	uint32_t device_count;		/**<  	numero di device attivi e gestiti dal driver */
} UART_list;

int UART_list_Init(UART_list *list, uint32_t list_size);

void UART_list_Destroy(UART_list* list);

int UART_list_add(UART_list *list, UART *device);

UART* UART_list_find_by_pdev(UART_list *list, struct platform_device *op);

UART* UART_list_find_by_minor(UART_list *list, dev_t dev);

UART* UART_list_find_irq_line(UART_list *list, int irq_line);

uint32_t UART_list_device_count(UART_list *list);

#endif
