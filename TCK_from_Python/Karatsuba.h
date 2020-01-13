#ifndef Karatsuba_h
#define Karatsuba_h

#include <stdint.h>
#include "cmsis.h"

uint32_t* extend_input_coefs_c(uint32_t *);
uint32_t* extend_input_coefs_f(uint32_t *);
void hybrid_mult(int32_t *, uint32_t *, uint32_t *);
void compose_output_coefs(int32_t *);
void Karatsuba_mult(int32_t *, uint32_t *, uint32_t *);

#endif
