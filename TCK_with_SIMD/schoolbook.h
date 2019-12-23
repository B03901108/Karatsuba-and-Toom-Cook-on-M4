#ifndef schoolbook_h
#define schoolbook_h

#include <stdint.h>
#include "mult_params.h"
#include "polymul_16x16.h"

void ref_schoolbook_mult(int16_t *, const int16_t *, const int16_t *);
void schoolbook_mult(int16_t *, const int16_t *, const int16_t *);
void schoolbook_mult_unreduced(int32_t *, const int16_t *, const int16_t *);

void smlal_mult(int16_t *, const int16_t *, const int16_t *, const int16_t);
void smlal_mult_64(int32_t *, const int16_t *, const int16_t *);

static inline int16_t modq_freeze(int32_t numIn) {
	int32_t a = numIn;
	a -= 4591 * ((228 * a) >> 20);
	a -= 4591 * ((58470 * a + 134217728) >> 28);
	return a;
}

#endif
