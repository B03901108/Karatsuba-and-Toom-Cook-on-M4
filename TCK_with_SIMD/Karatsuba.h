#ifndef Karatsuba_h
#define Karatsuba_h

#include "schoolbook.h"
void Karatsuba_mult(int16_t *, int16_t *, int16_t *, const int16_t, int8_t);
void iter_Karatsuba_mult(int16_t *, int16_t *, int16_t *);
void two_layer_Karatsuba_mult(int32_t *, uint32_t *, uint32_t *, uint8_t);
void three_way_Karatsuba_mult(int32_t *, uint32_t *, uint32_t *);

#endif
