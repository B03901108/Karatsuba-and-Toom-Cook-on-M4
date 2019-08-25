#include "schoolbook.h"

// h[2 * UNITLEN - 1], c[UNITLEN], f[UNITLEN]
void schoolbook_mult(int16_t *h, const int16_t *c, const int16_t *f) {
  int i, j;
  int32_t a;

  for (i = 0; i < UNITLEN; ++i) {
  	a = 0;
    for (j = 0; j <= i; ++j) a += c[j] * f[i - j];
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    h[i] = a;
  }

  for (i = UNITLEN; i < (UNITLEN << 1) - 1; ++i) {
  	a = 0;
    for (j = i - UNITLEN + 1; j < UNITLEN; ++j) a += c[j] * f[i - j];
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    h[i] = a;
  }
}

// h[2 * len - 1], c[len], f[len], inputScale: |worst-case c_i / 2295|
// TODO: one loop for two array additions or two indep. loops
// TODO: save cS & fS by reusing c & f, cSfS by c0/1f0/1, ...
// TODO: recursive (len > UNITLEN) or verbose (sublen > UNITLEN)
void Karatsuba_mult(int16_t *h, int16_t *c, int16_t *f, const int16_t len, int8_t inputScale) {
  int i, j;
  int32_t a; // for modq_freeze()
  int16_t sublen = len >> 1;
  int16_t cS[sublen];
  int16_t fS[sublen];
  int16_t cSfS[len - 1];

  // cS and fS may crash! (inputScale=16)
  if (inputScale == 8) {
    for (i = 0; i < len; ++i) {
      a = c[i];
      a -= 4591 * ((228 * a) >> 20);
      a -= 4591 * ((58470 * a + 134217728) >> 28);
      c[i] = a;
    }
    inputScale = 1;
  }

  for (i = 0, j = sublen; i < sublen; ++i, ++j) {
    cS[i] = c[i] + c[j];
    fS[i] = f[i] + f[j];
  }

  if (sublen > UNITLEN) {
    Karatsuba_mult(h, c, f, sublen, inputScale);
    Karatsuba_mult(h + len, c + sublen, f + sublen, sublen, inputScale);
    Karatsuba_mult(cSfS, cS, fS, sublen, inputScale << 1);
  } else {
    schoolbook_mult(h, c, f);
    schoolbook_mult(h + len, c + sublen, f + sublen);
    schoolbook_mult(cSfS, cS, fS);
  }
  for (i = sublen, j = len; i < len - 1; ++i, ++j) h[i] -= h[j];
  for (; j < (len << 1) - 1; ++i, ++j) h[i] = -h[j];
  for (i = len + sublen - 2, j = i - sublen; j >= 0; --i, --j) h[i] -= h[j];
  for (i = sublen, j = 0; j < len - 1; ++i, ++j) h[i] += cSfS[j];

  // h may crash! (worst-case middle terms: its scale follows a recursive relation)
  if ((len == LEN2) || (len == LEN4)) for (i = 0; i < (len << 1) - 1; ++i) {
  // if (((len == LEN2) || (len == LEN4)) || (len == LEN6)) for (i = 0; i < (len << 1) - 1; ++i) {
    a = h[i];
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    h[i] = a;
  }
}
