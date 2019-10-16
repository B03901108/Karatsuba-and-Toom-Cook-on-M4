#include "schoolbook.h"

void ref_schoolbook_mult(int16_t *h, const int16_t *c, const int16_t *f) {
  int32_t result;
  int i, j, j2;

  /* for (i = 0; i < 761; ++i) {
    result = 0;
    for (j = 0; j <= i; ++j) result = modq_freeze(result + c[j] * f[i - j]);
    h[i] = result;
  }
  for (i = 761; i < 1521; ++i) {
    result = 0;
    for (j = i - 760; j < 761; ++j) result = modq_freeze(result + c[j] * f[i - j]);
    h[i] = result;
  }

  for (i = 1520; i >= 761; --i) {
    h[i - 761] = modq_freeze(h[i - 761] + h[i]);
    h[i - 760] = modq_freeze(h[i - 760] + h[i]);
  } */
  for (i = 0; i < 761; ++i) {
    result = 0;
    for (j = 0; j <= i; ++j) result += c[j] * f[i - j];
    h[i] = modq_freeze(result);
  }
  for (i = 761; i < 1521; ++i) {
    result = 0;
    for (j = i - 760; j < 761; ++j) result += c[j] * f[i - j];
    h[i] = modq_freeze(result);
  }
  j2 = h[761];
  result = h[0] + j2;
  h[0] = modq_freeze(result);
  result = h[760] + h[1520];
  h[760] = modq_freeze(result);
  for (i = 1; i < 760; ++i) {
    j = j2; j2 = h[i + 761];
    result = h[i] +j + j2;
    h[i] = modq_freeze(result);
  }
}

// h[2 * UNITLEN - 1], c[UNITLEN], f[UNITLEN]
void schoolbook_mult(int16_t *h, const int16_t *c, const int16_t *f) {
  int i, j;
  int32_t a;

  for (i = 0; i < UNITLEN; ++i) {
    j = 1 - (i & 1);
    a = (j) ? (c[0] * f[i]) : (0);
    for (; j <= i; j += 2)
      a = __SMLADX((*(uint32_t *)(c + j)), (*(uint32_t *)(f + i - j - 1)), a);
    // a -= ((a * 7 + 0x4000) >> 15) * 4591;
    // a -= 4591 * ((228 * a) >> 20);
    // a -= 4591 * ((58470 * a + 134217728) >> 28);
    h[i] = barrett_32(a);
  }

  for (i = UNITLEN; i < (UNITLEN << 1) - 1; ++i) {
    j = 1 - (i & 1);
    a = (j) ? (c[i - UNITLEN + 1] * f[UNITLEN - 1]) : (0);
    for (j += i - UNITLEN + 1; j < UNITLEN; j += 2)
      a = __SMLADX((*(uint32_t *)(c + j)), (*(uint32_t *)(f + i - j - 1)), a);
    // a -= ((a * 7 + 0x4000) >> 15) * 4591;
    // a -= 4591 * ((228 * a) >> 20);
    // a -= 4591 * ((58470 * a + 134217728) >> 28);
    // h[i] = a;
    h[i] = barrett_32(a);
  }

  h[(UNITLEN << 1) - 1] = 0;
}
