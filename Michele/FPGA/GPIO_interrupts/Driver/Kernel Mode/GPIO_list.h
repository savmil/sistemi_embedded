#ifndef __GPIO_DEVICE_LIST__
#define __GPIO_DEVICE_LIST__

#include "GPIO.h"

/**
 * @brief Struttura dati per la gestione di più device GPIO da parte del driver      
 */
typedef struct {
	GPIO **device_list;	    // 	array di puntatori a GPIO, ciascuno dei quali si riferisce ad un device
	uint32_t list_size;			//	dimensione della lista, ovvero il numero massimo di device gestibili
	uint32_t device_count;		// 	numero di device attivi e gestiti dal driver */
} GPIO_list;

extern int GPIO_list_Init(GPIO_list *list, uint32_t list_size);

extern void GPIO_list_Destroy(GPIO_list* list);

extern int GPIO_list_add(GPIO_list *list, GPIO *device);

extern GPIO* GPIO_list_find_by_pdev(GPIO_list *list, struct platform_device *op);

extern GPIO* GPIO_list_find_by_minor(GPIO_list *list, dev_t dev);

extern GPIO* GPIO_list_find_irq_line(GPIO_list *list, int irq_line);

extern uint32_t GPIO_list_device_count(GPIO_list *list);

#endif
