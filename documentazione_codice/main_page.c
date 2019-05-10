/** @mainpage Documentazione codice sistemi embedded
 * @par Table of Contents
 * @section GPIO
 * 	@subsection Driver
 *		- Funzioni driver GPIO @ref gpio_int.c
 *	@subsection Hardware
 *		- Controlla la generazione dell' interrupt @ref GPIO_v1_0_S00_AXI.vhd
 *		- Top level entity del componente  GPIO_v1_0_S00_AXI @ref GPIO_v1_0.vhd
 * @section UART
 *	@subsection Driver
 *		@subsubsection UIO
 *			- gestione del componente UART utilizzando il driver uio @ref UART_interrupt_uio.c
 *		@subsubsection KERNEL
 *			- gestione del componente UART in modalità kernel @ref UART_interrupt_kernel_mode.c 
 *      @subsection Hardware
 *		- Controlla la generazione dell' interrupt @ref UART_v1_0_S00_AXI.vhd
 *		- Top level entity del componente UART_v1_0_S00_AXI @ref UART_v1_0.vhd
 */
