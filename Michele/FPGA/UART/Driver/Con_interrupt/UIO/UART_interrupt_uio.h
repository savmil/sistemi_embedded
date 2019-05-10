#ifndef UART_INTERRUPT_UIO_H_
#define UART_INTERRUPT_UIO_H_

void wait_for_interrupt(int file_descr, void *addr);
unsigned int read_reg(void *addr, unsigned int offset);
void write_reg(void *addr, unsigned int offset, unsigned int value);

#endif /* UART_INTERRUPT_UIO_H_ */