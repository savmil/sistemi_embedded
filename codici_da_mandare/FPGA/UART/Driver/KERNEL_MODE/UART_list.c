#include "UART_list.h"
#include <linux/slab.h>
#include <linux/module.h>

MODULE_LICENSE("GPL");
/**
 * @file UART_list.c
 * @brief Gestisce una lista di device UART
 */

/**
 * @brief Inizializza una struttura dati UART_list
 *			Istanzia una lista di dimensione pari a list_size dispositivi 
*			e inizializza i relativi puntatori al valore null
*
 * @param list puntatore a lista da inizializzare
 * @param list_size numero massimo di device che la struttra dati potrà contenere
 * @retval -ENOMEM nel caso in cui la struttura non possa essere allocata in memoria
 * @retval 0 se non si manifestano errori
 */
int UART_list_Init(UART_list *list, uint32_t list_size) {
	uint32_t i;
	list->list_size = list_size;																				
	list->device_count = 0;																						
	list->device_list = kmalloc(list->list_size * sizeof(UART*), GFP_KERNEL);

	if (list->device_list == NULL)
		return -ENOMEM;

	for (i=0; i<list->list_size; i++)
		list->device_list[i] = NULL;

	return 0;
}

/**
 * @brief Dealloca gli oggetti internamente contenuti nella UART_list
 *
 * @param list puntatore a UART_list, lista da distruggere
 */
void UART_list_Destroy(UART_list* list) {
	
	kfree(list->device_list);
}

/**
 * @brief Aggiunge un oggetto UART alla lista
 * @param list 	puntatore a UART_list, lista a cui aggiungere l'oggetto
 * @param device	puntatore a UART, oggetto da aggiungere alla lista
 * @retval -1 se è ststo già inserito il numero massimo di device
 * @retval 0 se l'inserimento è avvenuto correttamente
 */
int UART_list_add(UART_list *list, UART *device) {
	if (list->device_count >= list->list_size)
		return -1;
	
	list->device_list[list->device_count] = device;
	list->device_count++;
	return 0;
}

/**
 * @brief Ricerca un oggetto UART all'interno della lista tramite il campo pdev
 * @param list 	puntatore a UART_list in cui effettuare la ricerca
 * @param pdev	puntatore a struct platform_device
 * @return indirizzo dell'oggetto UART, se è contenuto nella lista, NULL altrimenti
 */
UART* UART_list_find_by_pdev(UART_list *list, struct platform_device *pdev) {
	uint32_t i = 0;
	do {
		if (list->device_list[i]->pdev == pdev)
			return list->device_list[i];
		i++;
	} while (i < list->device_count);
	return NULL;
}

/**
 * @brief Ricerca un oggetto UART all'interno della lista tramite il minor number associato al device
 * @param list 	puntatore a UART_list, lista in cui effettuare la ricerca
 * @param dev	major/minor number associato al device, parametro con cui viene invocata la open() o la release()
 * @return indirizzo dell'oggetto UART, se è presente nella lista, NULL altrimenti
 */
UART* UART_list_find_by_minor(UART_list *list, dev_t dev) {
	uint32_t i = 0;
	do {
		if (list->device_list[i]->Mm == dev)
			return list->device_list[i];
		i++;
	} while (i < list->device_count);
	return NULL;
}

/**
 * @brief Ricerca un oggetto UART all'interno della lista tramite l' interrupt-number
 * @param list puntatore a UART_list, lista in cui effettuare la ricerca
 * @param irq_line linea di interruzione alla quale il device è connesso
 * @return indirizzo dell'oggetto UART, se è presente nella lista, NULL altrimenti
 */
UART* UART_list_find_irq_line(UART_list *list, int irq_line) {
	uint32_t i = 0;
	do {
		if (list->device_list[i]->irqNumber == irq_line)
			return list->device_list[i];
		i++;
	} while (i < list->device_count);
	return NULL;
}
		
/**
 * @brief Restituisce il numero di device presenti nella lista
 * @param list puntatore a UART_list, lista di cui si intende conoscere il numero di oggetti UART contenuti
 * @return numero di device presenti nella lista
 */
uint32_t UART_list_device_count(UART_list *list) {
	return list->device_count;
}
