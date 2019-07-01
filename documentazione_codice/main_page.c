/** @mainpage Documentazione codice sistemi embedded
 * @par Table of Contents
 * @section GPIO
 * 	@subsection Driver
 *		@subsubsection UIO
 *			- Funzioni per la gestione del driver @ref GPIO_interrupt_uio_poll.c
 *		@subsubsection Kernel
 *			- Modulo kernel che permette di interagire con la periferica 
 *			@ref GPIO_kernel_main.c
 *			- Permette la gestione di un gruppo di periferiche dello stesso tipo
 *			@ref GPIO_list.c
 *			- Funzionalità utilizzate per controllare un singolo dipositivo @ref GPIO.c
 *	@subsection Hardware
 *		- Controlla la generazione dell' interrupt @ref GPIO_v1_0_S00_AXI.vhd
 *		- Top level entity del componente  GPIO_v1_0_S00_AXI @ref GPIO_v1_0.vhd
 * @section UART
 *	@subsection Driver
 *		@subsubsection UIO
 *			- gestione del componente UART utilizzando il driver uio @ref UART_interrupt_uio.c
 *		@subsubsection KERNEL
 *			- Modulo kernel che permette di interagire con la periferica 
 *			@ref UART_kernel_main.c
 *			- Permette la gestione di un gruppo di periferiche dello stesso tipo
 *			@ref UART_list.c
 *			- Funzionalità utilizzate per controllare un singolo dipositivo @ref UART.c UART_interrupt_kernel_mode.c 
 *      @subsection Hardware
 *		- Controlla la generazione dell' interrupt @ref UART_v1_0_S00_AXI.vhd
 *		- Top level entity del componente UART_v1_0_S00_AXI @ref UART_v1_0.vhd
 * @section Progetto_finale	 
 *	- gestione dell' invio e ricazione dei dati sulle varie periferiche 
 *	con calcolo e check del CRC @ref main.c
 *	@subsection Periferiche
 *		@subsubsection CAN
 *			- funzioni per configurare la periferica CAN @ref can.c
 *		@subsubsection SPI
 *			- funzioni per configurare la periferica SPI @ref spi.c
 *		@subsubsection I2C
 *			- funzioni per configurare la periferica I2C @ref i2c.c
 *		@subsubsection UART
 *			- funzioni per configurare la periferica UART @ref usart.c
 *		@subsubsection GPIO
 *			- funzioni per configurare i banchi del GPIO @ref gpio.c
 */
