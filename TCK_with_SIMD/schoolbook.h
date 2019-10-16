#ifndef schoolbook_h
#define schoolbook_h

#include <stdint.h>
#include "mult_params.h"
#include "polymul_16x16.h"

void ref_schoolbook_mult(int16_t *, const int16_t *, const int16_t *);
void schoolbook_mult(int16_t *, const int16_t *, const int16_t *);

static inline int16_t modq_freeze(int32_t numIn) {
	int32_t a = numIn;
	a -= 4591 * ((228 * a) >> 20);
	a -= 4591 * ((58470 * a + 134217728) >> 28);
	return a;
}

static inline int16_t modq_squeeze(int16_t numIn){
	int32_t a;
	__asm__ volatile("rsb %0, %1, %1, lsl #3"
		: "=r" (a)
		: "r" (numIn)
		: "cc"
	);
	__asm__ volatile("add %0, %0, #16384; asrs %0, %0, #15"
		: "=r" (a)
		: "0" (a)
		: "cc"
	);
	return numIn -4591 * a;
}

#endif
