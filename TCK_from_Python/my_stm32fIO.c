#include "my_stm32fIO.h"

#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/usart.h>

/*
 * console_putc(char c)
 *
 * Send the character 'c' to the USART, wait for the USART
 * transmit buffer to be empty first.
 */
void console_putc(char c)
{
	uint32_t	reg;
	do {
		reg = USART_SR(CONSOLE_UART);
	} while ((reg & USART_SR_TXE) == 0);
	USART_DR(CONSOLE_UART) = (uint16_t) c & 0xff;
}

/*
 * char = console_getc(int wait)
 *
 * Check the console for a character. If the wait flag is
 * non-zero. Continue checking until a character is received
 * otherwise return 0 if called and no character was available.
 */
char console_getc(int wait)
{
	uint32_t	reg;
	do {
		reg = USART_SR(CONSOLE_UART);
	} while ((wait != 0) && ((reg & USART_SR_RXNE) == 0));
	return (reg & USART_SR_RXNE) ? USART_DR(CONSOLE_UART) : '\000';
}

/*
 * void console_puts(char *s)
 *
 * Send a string to the console, one character at a time, return
 * after the last character, as indicated by a NUL character, is
 * reached.
 */
void console_puts(char *s)
{
	while (*s != '\000') {
		console_putc(*s);
		/* Add in a carraige return, after sending line feed */
		if (*s == '\n') {
			console_putc('\r');
		}
		s++;
	}
}

/*
 * int console_gets(char *s, int len)
 *
 * Wait for a string to be entered on the console, limited
 * support for editing characters (back space and delete)
 * end when a <CR> character is received.
 */
int console_gets(char *s, int len)
{
	char *t = s;
	char c;

	*t = '\000';
	/* read until a <CR> is received */
	while ((c = console_getc(1)) != '\r') {
		if ((c == '\010') || (c == '\127')) {
			if (t > s) {
				/* send ^H ^H to erase previous character */
				console_puts("\010 \010");
				t--;
			}
		} else {
			*t = c;
			console_putc(c);
			if ((t - s) < len) {
				t++;
			}
		}
		/* update end of string with NUL */
		*t = '\000';
	}
	return t - s;
}

void console_putint(int64_t numIn) {
	if (!numIn) { console_putc('0'); return; }
	int i, j;
	bool isNeg = (numIn < 0);
	char numOut[21] = { 0 };
	if (isNeg) { numIn = -numIn; console_putc('-'); }

	for (j = 0; numIn != 0; ++j, numIn /= 10) numOut[j] = ('0' + numIn % 10);
	for (i = 0, j -= 1; i < j; ++i, --j) {
		numOut[i] ^= numOut[j];
		numOut[j] ^= numOut[i];
		numOut[i] ^= numOut[j];
	}
	console_puts(numOut);
}

void console_puthex(uint64_t bitstr) {
	int i, j;
	uint8_t hexChar;
	char numOut[17];

	for (i = 15; i >= 0; --i, bitstr >>= 4) {
		hexChar = bitstr & 15;
		if (hexChar > 9) numOut[i] = hexChar + 'A' - 10;
		else numOut[i] = hexChar + '0';
	}
	numOut[16] = '\0';
	console_puts(numOut);
}
