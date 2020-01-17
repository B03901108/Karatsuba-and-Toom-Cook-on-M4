#ifndef my_stm32fIO_h
#define my_stm32fIO_h

#include <stdint.h>

#define CONSOLE_UART	USART2

void console_putc(char c);
char console_getc(int wait);
void console_puts(char *s);
int console_gets(char *s, int len);

void console_putint(int64_t numIn);
void console_puthex(uint64_t bitstr);

#endif
