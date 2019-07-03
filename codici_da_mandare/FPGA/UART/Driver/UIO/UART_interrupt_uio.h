#ifndef UART_INTERRUPT_UIO_H_
#define UART_INTERRUPT_UIO_H_
/**
 * @file UART_interrupt_uio.h
 * @brief header file UART_interrupt_uio
 */
void wait_for_interrupt(struct pollfd * poll_fds, void *uart_rx_ptr, void *uart_tx_ptr);
unsigned int read_reg(void *addr, unsigned int offset);
void write_reg(void *addr, unsigned int offset, unsigned int value);

#endif /* UART_INTERRUPT_UIO_H_ */
