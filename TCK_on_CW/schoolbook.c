#include "schoolbook.h"

// h[2 * UNITLEN - 1], c[UNITLEN], f[UNITLEN]
void schoolbook_mult(int16_t *h, const int16_t *c, const int16_t *f) {
  int i, j;
  int32_t a;
  /* int32_t * cast, * orig;
  int16_t c_cast[UNITLEN + 1];
  int16_t f_ext[UNITLEN + 1];
  int16_t * f_cast = f_ext + 1;

  cast = (int32_t *) c_cast;
  orig = (int32_t *) c;
  for (i = 0; i < UNITLEN >> 1; ++i) cast[i] = orig[i];
  cast = (int32_t *) f_cast;
  orig = (int32_t *) f;
  for (i = 0; i < UNITLEN >> 1; ++i) cast[i] = orig[i];
  c_cast[UNITLEN] = 0; f_ext[0] = 0; */

  for (i = 0; i < UNITLEN; ++i) {
  	a = 0;
    for (j = 0; j <= i; ++j) a += c[j] * f[i - j];
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    // a -= ((a * 7 + 0x4000) >> 15) * 4591;
    h[i] = a;
  }

  for (i = UNITLEN; i < (UNITLEN << 1) - 1; ++i) {
  	a = 0;
    for (j = i - UNITLEN + 1; j < UNITLEN; ++j) a += c[j] * f[i - j];
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    // a -= ((a * 7 + 0x4000) >> 15) * 4591;
    h[i] = a;
  }
}
