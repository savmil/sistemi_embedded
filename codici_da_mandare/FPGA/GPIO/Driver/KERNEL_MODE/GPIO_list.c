#include "GPIO_list.h"
#include <linux/slab.h>
#include <linux/module.h>

#define DRIVER_NAME "GPIO"

MODULE_LICENSE("GPL");

/**
 * @brief Inizializza una struttura dati GPIO_list
 * @param list puntatore a lista da inizializzare
 * @param list_size numero massimo di device che la struttra dati potrà contenere
 * @retval -ENOMEM nel caso in cui la struttura non possa essere allocata in memoria
 * @retval 0 se non si manifestano errori
 */
int GPIO_list_Init(GPIO_list *list, uint32_t list_size) {
	uint32_t i;
	list->list_size = list_size;
	list->device_count = 0;
	list->device_list = kmalloc(list->list_size * sizeof(GPIO*), GFP_KERNEL);

	if (list->device_list == NULL)
		return -ENOMEM;

	for (i=0; i<list->list_size; i++)
		list->device_list[i] = NULL;

	return 0;
}

/**
 * @brief Dealloca gli oggetti internamente contenuti nella GPIO_list
 *
 * @param list puntatore a GPIO_list, lista da distruggere
 */
void GPIO_list_Destroy(GPIO_list* list) {
	kfree(list->device_list);
}

/**
 * @brief Aggiunge un oggetto GPIO alla lista
 * @param list 	puntatore a GPIO_list, lista a cui aggiungere l'oggetto
 * @param device	puntatore a GPIO, oggetto da aggiungere alla lista
 * @retval -1 se è ststo già inserito il numero massimo di device
 * @retval 0 se non si manifesta nessun errore
 */
int GPIO_list_add(GPIO_list *list, GPIO *device) {
	if (list->device_count >= list->list_size)
		return -1;
	
	list->device_list[list->device_count] = device;
	list->device_count++;
	return 0;
}

/**
 * @brief Ricerca un oggetto GPIO all'interno della lista tramite il campo pdev
 * @param list 	puntatore a GPIO_list in cui effettuare la ricerca
 * @param pdev	puntatore a struct platform_device
 * @return indirizzo dell'oggetto GPIO, se è contenuto nella lista, NULL altrimenti
 */
GPIO* GPIO_list_find_by_pdev(GPIO_list *list, struct platform_device *pdev) {
	uint32_t i = 0;
	do {
		if (list->device_list[i]->pdev == pdev)
			return list->device_list[i];
		i++;
	} while (i < list->device_count);
	return NULL;
}

/**
 * @brief Ricerca un oggetto GPIO all'interno della lista tramite il minor number associato al device
 * @param list 	puntatore a GPIO_list, lista in cui effettuare la ricerca
 * @param dev	major/minor number associato al device, parametro con cui viene invocata la open() o la release()
 * @return indirizzo dell'oggetto GPIO, se è presente nella lista, NULL altrimenti
 */
GPIO* GPIO_list_find_by_minor(GPIO_list *list, dev_t dev) {
	uint32_t i = 0;
	do {
		if (list->device_list[i]->Mm == dev)
			return list->device_list[i];
		i++;
	} while (i < list->device_count);
	return NULL;
}

/**
 * @brief Ricerca un oggetto GPIO all'interno della lista tramite l' interrupt-number
 * @param list puntatore a GPIO_list, lista in cui effettuare la ricerca
 * @param irq_line linea di interruzione alla quale il device è connesso
 * @return indirizzo dell'oggetto GPIO, se è presente nella lista, NULL altrimenti
 */
GPIO* GPIO_list_find_irq_line(GPIO_list *list, int irq_line) {
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
 * @param list puntatore a GPIO_list, lista di cui si intende conoscere il numero di oggetti GPIO contenuti
 * @return numero di device presenti nella lista
 */
uint32_t GPIO_list_device_count(GPIO_list *list) {
	return list->device_count;
}
