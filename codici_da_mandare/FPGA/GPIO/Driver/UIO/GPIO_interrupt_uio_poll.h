#ifndef UART_INTERRUPT_UIO_POLL_H_
#define UART_INTERRUPT_UIO_POLL_H_
/**
 * @file GPIO_interrupt_uio_poll.h
 * @brief header file GPIO_interrupt_uio_poll.c
 */
void wait_for_interrupt(int fd0, int fd1, int fd2, void *addr_0, void *addr_1, void *addr_2);
unsigned int read_reg(void *addr, unsigned int offset);
void write_reg(void *addr, unsigned int offset, unsigned int value);

#endif /* UART_INTERRUPT_UIO_POLL_H_ */
