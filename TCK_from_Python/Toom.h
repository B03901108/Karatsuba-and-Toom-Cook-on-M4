#ifndef Toom_h
#define Toom_h

#include "Karatsuba.h"

void eval_input_coefs_c(uint32_t *, uint32_t *);
void eval_input_coefs_f(uint32_t *, uint32_t *);
void interpol_output_coefs(int32_t *, int32_t *);
void copy_output_coefs(int32_t *, int32_t *);
void Toom4_mult(int32_t *, uint32_t *, uint32_t *);

#endif
