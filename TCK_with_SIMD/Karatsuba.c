#include "Karatsuba.h"

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
      // a -= ((a * 7 + 0x4000) >> 15) * 4591;
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
  // if ((len == LEN2) || (len == LEN4)) for (i = 0; i < (len << 1) - 1; ++i) {
  if (len == LEN2) for (i = 0; i < (len << 1) - 1; ++i) {
    a = h[i];
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    // a -= ((a * 7 + 0x4000) >> 15) * 4591;
    h[i] = a;
  }
}

// 192x192 -> 3-layer Karatsuba
// TODO: generalization
void iter_Karatsuba_mult(int16_t *h, int16_t *c, int16_t *f) {
  int i, j1, j2, k, auxlen;
  int32_t a;
  // int8_t scaleIn[648]; // TODO: dynamic checking
  int16_t c_ext[648], f_ext[648], h_ext[1296];
  int16_t * cf, * cSfS, * bndry;
  int16_t len = 192, offset = 192, offsetArr[3] = { 864, 576, 384 };

  for (i = 0; i < 192; i += 2) {
    __asm__ volatile("ldr %0, [%1]"
      : "=r" (*(uint32_t *)(c_ext + i))
      : "r" (c + i)
      : "cc");
    __asm__ volatile("ldr %0, [%1]"
      : "=r" (*(uint32_t *)(f_ext + i))
      : "r" (f + i)
      : "cc");
  }
  for (i = 0; i < 3; ++i, len = auxlen, offset += (offset >> 1)) {
    auxlen = len >> 1;
    for (j1 = auxlen, j2 = 0, k = offset; j1 < offset; j1 += 2, j2 += 2, k += 2) {
      if (j2 == auxlen) { j1 += auxlen; j2 = 0; }
      // TODO: input modular arithmetic: dynamic checking? pre-computating?
      (*(uint32_t *)(c_ext + k)) = __SADD16((*(uint32_t *)(c_ext + j1)), (*(uint32_t *)(c_ext + j1 - auxlen)));
      (*(uint32_t *)(f_ext + k)) = __SADD16((*(uint32_t *)(f_ext + j1)), (*(uint32_t *)(f_ext + j1 - auxlen)));
    }
  }

  for (i = 0; i < 648; i += 24) schoolbook_mult(h_ext + (i << 1), c_ext + i, f_ext + i);

  for (i = 0; i < 3; ++i, len = auxlen) {
    bndry = h_ext + offsetArr[i];
    auxlen = len << 1;
    for (cf = h_ext, cSfS = bndry; cf < bndry; cf += (auxlen << 1), cSfS += auxlen) {
      for (j1 = len, j2 = auxlen; j1 < auxlen; j1 += 2, j2 += 2)
        (*(uint32_t *)(cf + j1)) = __SSUB16((*(uint32_t *)(cf + j2)), (*(uint32_t *)(cf + j1)));

      for (k = len; j2 < (auxlen << 1); j1 += 2, j2 += 2, k += 2)
        (*(uint32_t *)(cf + j1)) = __SSUB16((*(uint32_t *)(cf + j2)), (*(uint32_t *)(cf + k)));

      for (j1 = len, j2 = 0; j2 < len; j1 += 2, j2 += 2)
        (*(uint32_t *)(cf + j1)) = __SADD16((*(uint32_t *)(cf + j1)), (*(uint32_t *)(cf + j2)));

      for (j1 = len, j2 = 0; j2 < auxlen; j1 += 2, j2 += 2)
        (*(uint32_t *)(cf + j1)) = __SSUB16((*(uint32_t *)(cSfS + j2)), (*(uint32_t *)(cf + j1)));
    }
    if (i == 1) for (j1 = 0; j1 < offsetArr[i]; j1 += 2)
      (*(uint32_t *)(h_ext + j1)) = barrett_16x2((*(uint32_t *)(h_ext + j1)));
  }
  for (i = 0; i < 383; ++i) h[i] = h_ext[i];
}

// int16_t 768x768 => int32_t 1536
void three_way_Karatsuba_mult(int32_t *h, uint32_t *c, uint32_t *f) {
  int i;
  int32_t a0, a1, a2;
  uint32_t cS[128], fS[128];
  int32_t h01[512], h02[512], h12[512];
  uint32_t *c1 = c + 128, *c2 = c + 256, *f1 = f + 128, *f2 = f + 256;
  int32_t *h1 = h + 512, *h2 = h + 1024;

  two_layer_Karatsuba_mult(h, c, f, 1);
  two_layer_Karatsuba_mult(h1, c1, f1, 1);
  two_layer_Karatsuba_mult(h2, c2, f2, 1);

  for (i = 0; i < 128; ++i) { cS[i] = __SADD16(c[i], c1[i]); fS[i] = __SADD16(f[i], f1[i]); }
  two_layer_Karatsuba_mult(h01, cS, fS, 2);
  for (i = 0; i < 128; ++i) { cS[i] = __SADD16(c[i], c2[i]); fS[i] = __SADD16(f[i], f2[i]); }
  two_layer_Karatsuba_mult(h02, cS, fS, 2);
  for (i = 0; i < 128; ++i) { cS[i] = __SADD16(c2[i], c1[i]); fS[i] = __SADD16(f2[i], f1[i]); }
  two_layer_Karatsuba_mult(h12, cS, fS, 2);

  for (i = 0; i < 512; ++i) {
    a0 = h[i]; a1 = h1[i]; a2 = h2[i];
    h01[i] -= (a0 + a1); h12[i] -= (a2 + a1); h1[i] = h02[i] - a2 - a0 + a1;
  }
  h1 -= 256; h2 -= 256;
  for (i = 0; i < 512; ++i) { h1[i] += h01[i]; h2[i] += h12[i]; }
  for (i = 0; i < 1536; ++i) h[i] = barrett_32(h[i]);
}

void two_layer_Karatsuba_mult(int32_t *h, uint32_t *c, uint32_t *f, uint8_t scaleIn) {
  int i, j1, j2, k, auxlen;
  uint32_t c_ext[288], f_ext[288];
  int32_t h_ext[1152];
  int32_t *cf, *cSfS, *bndry;
  int len = 128, offset = 128, offsetArr[2] = { 768, 512 };

  for (i = 0; i < 128; ++i) { c_ext[i] = c[i]; f_ext[i] = f[i]; }
  for (j1 = 0, j2 = 64, k = 128; j2 < 128; ++j1, ++j2, ++k) {
    c_ext[k] = __SADD16(c_ext[j1], c_ext[j2]);
    f_ext[k] = __SADD16(f_ext[j1], f_ext[j2]);
  }
  for (j1 = 0, j2 = 32, k = 192; j2 < 192; ++j1, ++j2, ++k) {
    if (!(j2 & 63)) { j1 += 32; j2 += 32; }
    c_ext[k] = __SADD16(c_ext[j1], c_ext[j2]);
    f_ext[k] = __SADD16(f_ext[j1], f_ext[j2]);
  }

  i = (scaleIn > 1) ? (0) : (128);
  for (; i < 288; ++i) c_ext[i] = barrett_16x2(c_ext[i]);
  for (i = 0; i < 288; i += 32) smlal_mult_64(h_ext + (i << 2), (int16_t *)(c_ext + i), (int16_t *)(f_ext + i));

  bndry = h_ext + 768;
  for (cf = h_ext, cSfS = bndry; cf < bndry; cf += 256, cSfS += 128) {
    for (j1 = 64, j2 = 128; j1 < 128; ++j1, ++j2) cf[j1] = cf[j2] - cf[j1];
    for (k = 64; j2 < 256; ++j1, ++j2, ++k) cf[j1] = cf[j2] - cf[k];
    for (j1 = 64, j2 = 0; j2 < 64; ++j1, ++j2) cf[j1] = cf[j1] + cf[j2];
    for (j1 = 64, j2 = 0; j2 < 128; ++j1, ++j2) cf[j1] = cSfS[j2] - cf[j1];
  }
  bndry = h_ext + 512;
  for (cf = h_ext, cSfS = bndry; cf < bndry; cf += 512, cSfS += 256) {
    for (j1 = 128, j2 = 256; j1 < 256; ++j1, ++j2) cf[j1] = cf[j2] - cf[j1];
    for (k = 128; j2 < 512; ++j1, ++j2, ++k) cf[j1] = cf[j2] - cf[k];
    for (j1 = 128, j2 = 0; j2 < 128; ++j1, ++j2) cf[j1] = cf[j1] + cf[j2];
    for (j1 = 128, j2 = 0; j2 < 256; ++j1, ++j2) cf[j1] = cSfS[j2] - cf[j1];
  }

  for (i = 0; i < 512; ++i) h[i] = h_ext[i];
}
