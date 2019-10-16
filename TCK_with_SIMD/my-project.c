#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/usart.h>
#include <libopencm3/cm3/systick.h>

#include <stdlib.h>
#include "Toom.h"
#include "my_stm32fIO.h"

static void clock_setup(void)
{
	/* Enable GPIOG clock for USARTs. (LED: RCC_GPIOG) */
	rcc_periph_clock_enable(RCC_GPIOA);

	/* Enable clocks for USART2. */
	rcc_periph_clock_enable(RCC_USART2);
}

static void usart_setup(void)
{
	/* Setup USART2 parameters. */
	usart_set_baudrate(USART2, 115200);
	usart_set_databits(USART2, 8);
	usart_set_stopbits(USART2, USART_STOPBITS_1);
	usart_set_mode(USART2, USART_MODE_TX);
	usart_set_parity(USART2, USART_PARITY_NONE);
	usart_set_flow_control(USART2, USART_FLOWCONTROL_NONE);

	/* Finally enable the USART. */
	usart_enable(USART2);
}

static void gpio_setup(void)
{
	/* Setup GPIO pins for USART2 transmit. */
	gpio_mode_setup(GPIOA, GPIO_MODE_AF, GPIO_PUPD_NONE, GPIO2 | GPIO3);

	/* Setup USART2 TX pin as alternate function. */
	gpio_set_af(GPIOA, GPIO_AF7, GPIO2 | GPIO3);
}

/****************TINER_FUNCTIONS****************/
#define NUM_CYCLE_RELOAD 16777216llu
static void systick_setup(void) {
	systick_set_clocksource(STK_CSR_CLKSOURCE_AHB);
	systick_set_reload(NUM_CYCLE_RELOAD - 1);
	systick_interrupt_enable();
	systick_counter_enable();
}

static volatile uint64_t overflowcnt = 0;
static void sys_tick_handler(void) { ++overflowcnt; }
static uint64_t hal_get_time(void) { return (overflowcnt + 1) * NUM_CYCLE_RELOAD - systick_get_value(); }
/****************TINER_FUNCTIONS****************/

static void mock_mult(int16_t *h, const int16_t *c, const int16_t *f, const int16_t len) {
  int i, j;
  int32_t a;

  for (i = 0; i < len; ++i) {
  	j = 1 - (i & 1);
    a = (j) ? (c[0] * f[i]) : (0);
    for (; j <= i; j += 2)
      a = __SMLADX(*(uint32_t *)(c + j), *(uint32_t *)(f + i - j - 1), a);
    h[i] = barrett_32(a);
  }

  for (; i < len * 2 - 1; ++i) {
  	j = 1 - (i & 1);
    a = (j) ? (c[i - len + 1] * f[len - 1]) : (0);
    for (j += i - len + 1; j < len; j += 2)
      a = __SMLADX(*(uint32_t *)(c + j), *(uint32_t *)(f + i - j - 1), a);
    h[i] = barrett_32(a);
  }

  h[i] = 0;
}

static void mock_Karatsuba_mult(int16_t *h, int16_t *c, int16_t *f, const int16_t len, int8_t inputScale) {
  int i, j, k;
  int32_t a;
  int16_t sublen = len >> 1;
  int16_t cS[sublen];
  int16_t fS[sublen];
  int16_t cSfS[len];

  if (inputScale == 8) {
    for (i = 0; i < len; i += 2) *(uint32_t *)(c + i) = barrett_16x2(*(uint32_t *)(c + i));
    inputScale = 1;
  }

  for (i = 0, j = sublen; i < sublen; i += 2, j += 2) {
    *(uint32_t *)(cS + i) = __SADD16(*(uint32_t *)(c + i), *(uint32_t *)(c + j));
    *(uint32_t *)(fS + i) = __SADD16(*(uint32_t *)(f + i), *(uint32_t *)(f + j));
  }

  if (sublen > 24) {
    mock_Karatsuba_mult(h, c, f, sublen, inputScale);
    mock_Karatsuba_mult(h + len, c + sublen, f + sublen, sublen, inputScale);
    mock_Karatsuba_mult(cSfS, cS, fS, sublen, inputScale << 1);
  } else {
    mock_mult(h, c, f, 24);
    mock_mult(h + len, c + sublen, f + sublen, 24);
    mock_mult(cSfS, cS, fS, 24);
  }

  for (i = sublen, j = len; i < len; i += 2, j += 2)
    (*(uint32_t *)(h + i)) = __SSUB16((*(uint32_t *)(h + j)), (*(uint32_t *)(h + i)));
  for (k = sublen; j < (len << 1); i += 2, j += 2, k += 2)
    (*(uint32_t *)(h + i)) = __SSUB16((*(uint32_t *)(h + j)), (*(uint32_t *)(h + k)));
  for (i = sublen, j = 0; j < sublen; i += 2, j += 2)
    (*(uint32_t *)(h + i)) = __SADD16((*(uint32_t *)(h + i)), (*(uint32_t *)(h + j)));
  for (i = sublen, j = 0; j < len; i += 2, j += 2)
    (*(uint32_t *)(h + i)) = __SSUB16((*(uint32_t *)(cSfS + j)), (*(uint32_t *)(h + i)));

  if ((len == 96) || (len == 384)) {
    for (i = 0; i < (len << 1) - 2; i += 2)
  	  *(uint32_t *)(h + i) = barrett_16x2(*(uint32_t *)(h + i));
  	h[i] = barrett_32(h[i]);
  }
}

int main(void) {
	/* add your own code */
	clock_setup();
	gpio_setup();
	usart_setup();
	systick_setup();

	int i, j;
	int32_t a, x, y, z, counter;
	uint64_t t0, t1;
	int16_t h1[1536], h2[1536], h3[1536];
	int16_t c[768] = { 0 };
	int16_t f[768] = { 0 };

	console_puts("\nStart of Testing\r\n\n");

	// srand(hal_get_time());
	srand(53589793); // 31415926
	for (counter = 0; counter < 100; ++counter) {
		for (i = 0; i < 761; ++i) c[i] = (rand() % 1531) * 3 - 2295;
		for (i = 0; i < 761; ++i) f[i] = (rand() % 3) - 1;
		for (i = 0; i < 1536; ++i) h1[i] = h2[i] = h3[i] = 0;

		t0 = hal_get_time();
		mock_mult(h1, c, f, 761);
		y = h1[761];
		a = h1[0] + y;
		h1[0] = barrett_32(a);
		a = h1[760] + h1[1520];
		h1[760] = barrett_32(a);
		for (i = 1; i < 760; ++i) {
			x = y; y = h1[i + 761];
			a = h1[i] + x + y;
			h1[i] = barrett_32(a);
		}
		t1 = hal_get_time();
		console_putint(t1 - t0);
		console_puts(" clock cycles (mock_mult)\r\n");

		/* t0 = hal_get_time();
		ref_schoolbook_mult(h1, c, f);
		t1 = hal_get_time();
		console_putint(t1 - t0);
		console_puts(" clock cycles (ref_mult)\r\n"); */

		t0 = hal_get_time();
		Toom4_mult(h2, c, f);

		y = h2[761];
		a = h2[0] + y;
		h2[0] = barrett_32(a);
		a = h2[760] + h2[1520];
		h2[760] = barrett_32(a);
		for (i = 1; i < 760; ++i) {
			x = y; y = h2[i + 761];
			a = h2[i] + x + y;
			h2[i] = barrett_32(a);
		}
		
		/* y = *(int32_t *)h2;
		for (i = 761; i < 1522; i += 2) {
			a = *(int32_t *)(h2 + i);
			x = y; y = *(int32_t *)(h2 + i - 759);
			x = __SADD16(x, a);

			z = *(((int16_t *)&x) + 1);
			*(((int16_t *)&z) + 1) = *(int16_t *)&y;
			z = __SADD16(z, a);

			*(((int16_t *)&x) + 1) = *(int16_t *)&z;
			*(int16_t *)&y = *(((int16_t *)&z) + 1);
			*(uint32_t *)(h2 + i - 761) = barrett_16x2(x);
		} */

		t1 = hal_get_time();
		console_putint(t1 - t0);
		console_puts(" clock cycles (Toom4_mult)\r\n");

		t0 = hal_get_time();
		mock_Karatsuba_mult(h3, c, f, 768, 1);
		y = h3[761];
		a = h3[0] + y;
		h3[0] = barrett_32(a);
		a = h3[760] + h3[1520];
		h3[760] = barrett_32(a);
		for (i = 1; i < 760; ++i) {
			x = y; y = h3[i + 761];
			a = h3[i] + x + y;
			h3[i] = barrett_32(a);
		}
		t1 = hal_get_time();
		console_putint(t1 - t0);
		console_puts(" clock cycles (mock_Karatsuba_mult)\r\n");

		for (i = 0; i < 761; ++i) if (h1[i] != h2[i]) {
			console_puts("h1 vs. h2 -- ");
			console_putint(i);
			console_puts(": WRONG!!! => ");
			console_putint(h1[i]);
			console_puts(" != ");
			console_putint(h2[i]);
			console_puts("\r\n");
		}
		for (i = 0; i < 761; ++i) if (h1[i] != h3[i]) {
			console_puts("h1 vs. h3 -- ");
			console_putint(i);
			console_puts(": WRONG!!! => ");
			console_putint(h1[i]);
			console_puts(" != ");
			console_putint(h3[i]);
			console_puts("\r\n");
		}
		for (i = 0; i < 761; ++i) if (h2[i] != h3[i]) {
			console_puts("h2 vs. h3 -- ");
			console_putint(i);
			console_puts(": WRONG!!! => ");
			console_putint(h2[i]);
			console_puts(" != ");
			console_putint(h3[i]);
			console_puts("\r\n");
		}
	}

	console_puts("\nEnd of Testing\r\n\n");
	return 0;
}
