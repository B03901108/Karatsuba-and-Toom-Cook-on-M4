#include "Karatsuba.h"

extern void gf_polymul_64x64sh_unreduced (int *h, int *f, int *g, int cut);
extern void gf_polymul_192x192sh_unreduced (int *h, int *f, int *g, int cut);

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
void iter_Karatsuba_mult(int32_t *h, uint32_t *c, uint32_t *f) {
  int i, j1, j2, k;
  int16_t mono_c, mono_f;
  int16_t *c_sch, *f_sch;
  uint32_t r0, r1, r2, r3, r4, r5, r6, r7;
  uint32_t *c_to, *f_to, *c_from1, *f_from1, *c_from2, *f_from2;
  uint32_t c_ext[324], f_ext[324];
  int32_t accum, ir0, ir1, ir2, ir3, ir4, ir5, ir6, ir7, ir8, ir9, ir10, ir11;
  int32_t *cf, *cSfS, *bndry, *op_accum, *op_tmp, *op_tmp2;
  int32_t h_ext[1296];

  c_to = c_ext; f_to = f_ext; c_from1 = c; f_from1 = f;
  for (i = 0; i < 96; i += 4) {
    r0 = *(c_from1++);
    r1 = *(c_from1++);
    r2 = *(c_from1++);
    r3 = *(c_from1++);
    r4 = *(f_from1++);
    r5 = *(f_from1++);
    r6 = *(f_from1++);
    r7 = *(f_from1++);
    *(c_to++) = r0;
    *(c_to++) = r1;
    *(c_to++) = r2;
    *(c_to++) = r3;
    *(f_to++) = r4;
    *(f_to++) = r5;
    *(f_to++) = r6;
    *(f_to++) = r7;
  }
  c_from2 = c_to - 48; c_from1 = c_to - 96; f_from2 = f_to - 48; f_from1 = f_to - 96;
  for (j1 = 48; j1 < 96; ++j1) {
    r0 = *(c_from1++);
    r1 = *(c_from2++);
    r2 = *(f_from1++);
    r3 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r0 = barrett_16x2(r0);
    *(f_to++) = r2;
    *(c_to++) = r0;
  }
  c_from2 = c_to - 120; c_from1 = c_to - 144; f_from2 = f_to - 120; f_from1 = f_to - 144;
  for (i = 0, j1 = 24; j1 < 144; ++i, ++j1) {
    if (i == 24) { i = 0; j1 += 24; c_from1 += 24; c_from2 += 24; f_from1 += 24; f_from2 += 24; }
    r0 = *(c_from1++);
    r1 = *(c_from2++);
    r2 = *(f_from1++);
    r3 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r0 = barrett_16x2(r0);
    *(f_to++) = r2;
    *(c_to++) = r0;
  }
  c_from2 = c_to - 204; c_from1 = c_to - 216; f_from2 = f_to - 204; f_from1 = f_to - 216;
  for (i = 0, j1 = 12; j1 < 216; ++i, ++j1) {
    if (i == 12) { i = 0; j1 += 12; c_from1 += 12; c_from2 += 12; f_from1 += 12; f_from2 += 12; }
    r0 = *(c_from1++);
    r1 = *(c_from2++);
    r2 = *(f_from1++);
    r3 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r0 = barrett_16x2(r0);
    *(f_to++) = r2;
    *(c_to++) = r0;
  }

  c_to -= 324;
  c_from1 = c_to;
  f_to -= 324;
  f_from1 = f_to;
  cf = h_ext;
  cSfS = cf + 1296;
  while (cf != cSfS) {
    c_to -= 1;
    f_to -= 1;
    bndry = cf + 24;
    r2 = *(c_from1 + 1);
    r1 = *((uint32_t *)(((int16_t *)c_from1) + 1));
    r0 = *(c_from1--);
    ir0 = 0;
    ir1 = 0;
    ir2 = 0;
    while (cf != bndry) {
      r4 = *(f_from1 + 1);
      r3 = *(f_from1--);
      ir1 = __SMLADX(r0, r3, ir1);
      ir3 = __SMUADX(r0, r4);
      ir3 = __SMLADX(r2, r3, ir3);
      ir5 = __SMUADX(r2, r4);
      ir0 = __SMLABB(r0, r3, ir0);
      ir2 = __SMLADX(r1, r3, ir2);
      ir2 = __SMLABB(r0, r4, ir2);
      ir4 = __SMUADX(r1, r4);  
      ir4 = __SMLATT(r2, r3, ir4);
      ir6 = __SMULTT(r2, r4);
      c_from1 += 3;
      while (f_from1 != f_to) {
        r1 = *((uint32_t *)(((int16_t *)c_from1) + 1));
        r0 = *(c_from1++);
        r2 = *(c_from1++);
        r4 = *(f_from1--);
        r3 = *(f_from1--);
        ir1 = __SMLADX(r0, r3, ir1);
        ir3 = __SMLADX(r0, r4, ir3);
        ir3 = __SMLADX(r2, r3, ir3);
        ir5 = __SMLADX(r2, r4, ir5);
        ir0 = __SMLABB(r0, r3, ir0);
        ir2 = __SMLADX(r1, r3, ir2);
        ir2 = __SMLABB(r0, r4, ir2);
        ir4 = __SMLADX(r1, r4, ir4);  
        ir4 = __SMLATT(r2, r3, ir4);
        ir6 = __SMLATT(r2, r4, ir6);
      }
      *(cf++) = ir0;
      *(cf++) = ir1;
      *(cf++) = ir2;
      *(cf++) = ir3;

      r2 = *(c_from1 + 1);
      r1 = *((uint32_t *)(((int16_t *)c_from1) + 1));
      r0 = *(c_from1--);
      ir5 = __SMLADX(r0, r3, ir5);
      ir3 = __SMUADX(r0, r4);
      ir3 = __SMLADX(r2, r3, ir3);
      ir1 = __SMUADX(r2, r4);
      ir4 = __SMLABB(r0, r3, ir4);
      ir6 = __SMLADX(r1, r3, ir6);
      ir6 = __SMLABB(r0, r4, ir6);
      ir0 = __SMUADX(r1, r4);  
      ir0 = __SMLATT(r2, r3, ir0);
      ir2 = __SMULTT(r2, r4);
      f_from1 += 3;
      while (c_from1 != c_to) {
        r2 = *(c_from1--);
        r1 = *((uint32_t *)(((int16_t *)c_from1) + 1));
        r0 = *(c_from1--);
        r3 = *(f_from1++);
        r4 = *(f_from1++);
        ir5 = __SMLADX(r0, r3, ir5);
        ir3 = __SMLADX(r0, r4, ir3);
        ir3 = __SMLADX(r2, r3, ir3);
        ir1 = __SMLADX(r2, r4, ir1);
        ir4 = __SMLABB(r0, r3, ir4);
        ir6 = __SMLADX(r1, r3, ir6);
        ir6 = __SMLABB(r0, r4, ir6);
        ir0 = __SMLADX(r1, r4, ir0);  
        ir0 = __SMLATT(r2, r3, ir0);
        ir2 = __SMLATT(r2, r4, ir2);
      }
      *(cf++) = ir4;
      *(cf++) = ir5;
      *(cf++) = ir6;
      *(cf++) = ir3;
    }
    bndry += 16;
    c_to += 13;
    f_to += 13;
    while (1) {
      c_from1 += 3;
      r1 = *((uint32_t *)(((int16_t *)c_from1) + 1));
      r0 = *(c_from1++);
      r2 = *(c_from1++);
      ir1 = __SMLADX(r0, r3, ir1);
      ir3 = __SMUADX(r0, r4);
      ir3 = __SMLADX(r2, r3, ir3);
      ir5 = __SMUADX(r2, r4);
      ir0 = __SMLABB(r0, r3, ir0);
      ir2 = __SMLADX(r1, r3, ir2);
      ir2 = __SMLABB(r0, r4, ir2);
      ir4 = __SMUADX(r1, r4);  
      ir4 = __SMLATT(r2, r3, ir4);
      ir6 = __SMULTT(r2, r4);

      if (cf == bndry) {
        *(cf++) = ir0;
        *(cf++) = ir1;
        *(cf++) = ir2;
        *(cf++) = ir3;
        *(cf++) = ir4;
        *(cf++) = ir5;
        *(cf++) = ir6;
        *(cf++) = 0;
        break;
      }

      f_from1 -= 3;
      while (c_from1 != c_to) {
        r1 = *((uint32_t *)(((int16_t *)c_from1) + 1));
        r0 = *(c_from1++);
        r2 = *(c_from1++);
        r4 = *(f_from1--);
        r3 = *(f_from1--);
        ir1 = __SMLADX(r0, r3, ir1);
        ir3 = __SMLADX(r0, r4, ir3);
        ir3 = __SMLADX(r2, r3, ir3);
        ir5 = __SMLADX(r2, r4, ir5);
        ir0 = __SMLABB(r0, r3, ir0);
        ir2 = __SMLADX(r1, r3, ir2);
        ir2 = __SMLABB(r0, r4, ir2);
        ir4 = __SMLADX(r1, r4, ir4);  
        ir4 = __SMLATT(r2, r3, ir4);
        ir6 = __SMLATT(r2, r4, ir6);
      }
      *(cf++) = ir0;
      *(cf++) = ir1;
      *(cf++) = ir2;
      *(cf++) = ir3;

      f_from1 += 3;
      r3 = *(f_from1++);
      r4 = *(f_from1++);
      ir5 = __SMLADX(r0, r3, ir5);
      ir3 = __SMUADX(r0, r4);
      ir3 = __SMLADX(r2, r3, ir3);
      ir1 = __SMUADX(r2, r4);
      ir4 = __SMLABB(r0, r3, ir4);
      ir6 = __SMLADX(r1, r3, ir6);
      ir6 = __SMLABB(r0, r4, ir6);
      ir0 = __SMUADX(r1, r4);  
      ir0 = __SMLATT(r2, r3, ir0);
      ir2 = __SMULTT(r2, r4);
      c_from1 -= 3;
      while (f_from1 != f_to) {
        r2 = *(c_from1--);
        r1 = *((uint32_t *)(((int16_t *)c_from1) + 1));
        r0 = *(c_from1--);
        r3 = *(f_from1++);
        r4 = *(f_from1++);
        ir5 = __SMLADX(r0, r3, ir5);
        ir3 = __SMLADX(r0, r4, ir3);
        ir3 = __SMLADX(r2, r3, ir3);
        ir1 = __SMLADX(r2, r4, ir1);
        ir4 = __SMLABB(r0, r3, ir4);
        ir6 = __SMLADX(r1, r3, ir6);
        ir6 = __SMLABB(r0, r4, ir6);
        ir0 = __SMLADX(r1, r4, ir0);  
        ir0 = __SMLATT(r2, r3, ir0);
        ir2 = __SMLATT(r2, r4, ir2);
      }
      *(cf++) = ir4;
      *(cf++) = ir5;
      *(cf++) = ir6;
      *(cf++) = ir3;
    }
  }
  /* cf = h_ext; c_sch = (int16_t *)(c_to - 324); f_sch = ((int16_t *)(f_to - 324)) - 1;
  while (c_sch != (int16_t *)c_to) {
    for (i = 1; i < 25; ++i) {
      j1 = i & 1;
      if (j1) {
        mono_c = *c_sch;
        mono_f = *(++f_sch); 
        accum = mono_c * mono_f;
        c_from1 = (uint32_t *)(c_sch + 1);
        f_from1 = (uint32_t *)(f_sch + (-2));
      } else {
        accum = 0;
        c_from1 = (uint32_t *)c_sch;
        f_from1 = (uint32_t *)f_sch;
        f_sch += 1;
      }
      for (; j1 < i; j1 += 2) {
        r0 = *(c_from1++);
        r1 = *(f_from1--);
        accum = __SMLADX(r0, r1, accum);
      }
      *(cf++) = accum;
    }
    for (i = 1; i < 24; ++i) {
      j1 = i & 1;
      if (j1) {
        mono_c = *(++c_sch);
        mono_f = *f_sch; 
        accum = mono_c * mono_f;
        c_from1 = (uint32_t *)(c_sch + 1);
        f_from1 = (uint32_t *)(f_sch + (-2));
      } else {
        accum = 0;
        c_sch += 1;
        c_from1 = (uint32_t *)c_sch;
        f_from1 = (uint32_t *)(f_sch + (-1));
      }
      for (j1 += i; j1 < 24; j1 += 2) {
        r0 = *(c_from1++);
        r1 = *(f_from1--);
        accum = __SMLADX(r0, r1, accum);
      }
      *(cf++) = accum;
    }
    *(cf++) = 0;
    c_sch += 1;
  } */

  cf = h_ext; bndry = cf + 864; cSfS = bndry;
  for (; cf < bndry; cf += 96) {
    op_accum = cf + 24; op_tmp = cf + 48;
    for (j1 = 0; j1 < 24; j1 += 4) {
      ir0 = *op_accum;
      ir1 = *(op_tmp++);
      ir2 = *(op_accum + 1);
      ir3 = *(op_tmp++);
      ir4 = *(op_accum + 2);
      ir5 = *(op_tmp++);
      ir6 = *(op_accum + 3);
      ir7 = *(op_tmp++);

      ir0 = ir1 - ir0;
      ir2 = ir3 - ir2;
      ir4 = ir5 - ir4;
      ir6 = ir7 - ir6;
      *(op_accum++) = ir0;
      *(op_accum++) = ir2;
      *(op_accum++) = ir4;
      *(op_accum++) = ir6;
    }
    op_tmp2 = cf + 24;
    for (j1 = 0; j1 < 24; j1 += 3) {
      ir0 = *(op_tmp++);
      ir1 = *(op_tmp2++);
      ir2 = *(op_tmp++);
      ir3 = *(op_tmp2++);
      ir4 = *(op_tmp++);
      ir5 = *(op_tmp2++);

      ir0 = ir0 - ir1;
      ir2 = ir2 - ir3;
      ir4 = ir4 - ir5;
      *(op_accum++) = ir0;
      *(op_accum++) = ir2;
      *(op_accum++) = ir4;
    }
    op_accum = cf + 24; op_tmp = cf;
    for (j1 = 0; j1 < 24; j1 += 4) {
      ir0 = *op_accum;
      ir1 = *(op_tmp++);
      ir2 = *(op_accum + 1);
      ir3 = *(op_tmp++);
      ir4 = *(op_accum + 2);
      ir5 = *(op_tmp++);
      ir6 = *(op_accum + 3);
      ir7 = *(op_tmp++);

      ir0 = ir0 + ir1;
      ir2 = ir2 + ir3;
      ir4 = ir4 + ir5;
      ir6 = ir6 + ir7;
      *(op_accum++) = ir0;
      *(op_accum++) = ir2;
      *(op_accum++) = ir4;
      *(op_accum++) = ir6;
    }
    op_accum = cf + 24;
    for (j1 = 0; j1 < 48; j1 += 4) {
      ir0 = *op_accum;
      ir1 = *(cSfS++);
      ir2 = *(op_accum + 1);
      ir3 = *(cSfS++);
      ir4 = *(op_accum + 2);
      ir5 = *(cSfS++);
      ir6 = *(op_accum + 3);
      ir7 = *(cSfS++);

      ir0 = ir1 - ir0;
      ir2 = ir3 - ir2;
      ir4 = ir5 - ir4;
      ir6 = ir7 - ir6;
      *(op_accum++) = ir0;
      *(op_accum++) = ir2;
      *(op_accum++) = ir4;
      *(op_accum++) = ir6;
    }
  }

  cf = h_ext; bndry = cf + 576; cSfS = bndry;
  for (; cf < bndry; cf += 192) {
    op_accum = cf + 48; op_tmp = cf + 96;
    for (j1 = 0; j1 < 48; j1 += 4) {
      ir0 = *op_accum;
      ir1 = *(op_tmp++);
      ir2 = *(op_accum + 1);
      ir3 = *(op_tmp++);
      ir4 = *(op_accum + 2);
      ir5 = *(op_tmp++);
      ir6 = *(op_accum + 3);
      ir7 = *(op_tmp++);

      ir0 = ir1 - ir0;
      ir2 = ir3 - ir2;
      ir4 = ir5 - ir4;
      ir6 = ir7 - ir6;
      *(op_accum++) = ir0;
      *(op_accum++) = ir2;
      *(op_accum++) = ir4;
      *(op_accum++) = ir6;
    }
    op_tmp2 = cf + 48;
    for (j1 = 0; j1 < 48; j1 += 3) {
      ir0 = *(op_tmp++);
      ir1 = *(op_tmp2++);
      ir2 = *(op_tmp++);
      ir3 = *(op_tmp2++);
      ir4 = *(op_tmp++);
      ir5 = *(op_tmp2++);

      ir0 = ir0 - ir1;
      ir2 = ir2 - ir3;
      ir4 = ir4 - ir5;
      *(op_accum++) = ir0;
      *(op_accum++) = ir2;
      *(op_accum++) = ir4;
    }
    op_accum = cf + 48; op_tmp = cf;
    for (j1 = 0; j1 < 48; j1 += 4) {
      ir0 = *op_accum;
      ir1 = *(op_tmp++);
      ir2 = *(op_accum + 1);
      ir3 = *(op_tmp++);
      ir4 = *(op_accum + 2);
      ir5 = *(op_tmp++);
      ir6 = *(op_accum + 3);
      ir7 = *(op_tmp++);

      ir0 = ir0 + ir1;
      ir2 = ir2 + ir3;
      ir4 = ir4 + ir5;
      ir6 = ir6 + ir7;
      *(op_accum++) = ir0;
      *(op_accum++) = ir2;
      *(op_accum++) = ir4;
      *(op_accum++) = ir6;
    }
    op_accum = cf + 48;
    for (j1 = 0; j1 < 96; j1 += 4) {
      ir0 = *op_accum;
      ir1 = *(cSfS++);
      ir2 = *(op_accum + 1);
      ir3 = *(cSfS++);
      ir4 = *(op_accum + 2);
      ir5 = *(cSfS++);
      ir6 = *(op_accum + 3);
      ir7 = *(cSfS++);

      ir0 = ir1 - ir0;
      ir2 = ir3 - ir2;
      ir4 = ir5 - ir4;
      ir6 = ir7 - ir6;
      *(op_accum++) = ir0;
      *(op_accum++) = ir2;
      *(op_accum++) = ir4;
      *(op_accum++) = ir6;
    }
  }

  cf = h_ext; cSfS = cf + 384;
  op_accum = cf + 96; op_tmp = cf + 192;
  for (j1 = 0; j1 < 96; j1 += 4) {
    ir0 = *op_accum;
    ir1 = *(op_tmp++);
    ir2 = *(op_accum + 1);
    ir3 = *(op_tmp++);
    ir4 = *(op_accum + 2);
    ir5 = *(op_tmp++);
    ir6 = *(op_accum + 3);
    ir7 = *(op_tmp++);

    ir0 = ir1 - ir0;
    ir2 = ir3 - ir2;
    ir4 = ir5 - ir4;
    ir6 = ir7 - ir6;
    *(op_accum++) = ir0;
    *(op_accum++) = ir2;
    *(op_accum++) = ir4;
    *(op_accum++) = ir6;
  }
  op_tmp2 = cf + 96;
  for (j1 = 0; j1 < 96; j1 += 3) {
    ir0 = *(op_tmp++);
    ir1 = *(op_tmp2++);
    ir2 = *(op_tmp++);
    ir3 = *(op_tmp2++);
    ir4 = *(op_tmp++);
    ir5 = *(op_tmp2++);

    ir0 = ir0 - ir1;
    ir2 = ir2 - ir3;
    ir4 = ir4 - ir5;
    *(op_accum++) = ir0;
    *(op_accum++) = ir2;
    *(op_accum++) = ir4;
  }
  op_accum = cf + 96; op_tmp = cf;
  for (j1 = 0; j1 < 96; j1 += 4) {
    ir0 = *op_accum;
    ir1 = *(op_tmp++);
    ir2 = *(op_accum + 1);
    ir3 = *(op_tmp++);
    ir4 = *(op_accum + 2);
    ir5 = *(op_tmp++);
    ir6 = *(op_accum + 3);
    ir7 = *(op_tmp++);

    ir0 = ir0 + ir1;
    ir2 = ir2 + ir3;
    ir4 = ir4 + ir5;
    ir6 = ir6 + ir7;
    *(op_accum++) = ir0;
    *(op_accum++) = ir2;
    *(op_accum++) = ir4;
    *(op_accum++) = ir6;
  }
  op_accum = cf + 96;
  for (j1 = 0; j1 < 192; j1 += 4) {
    ir0 = *op_accum;
    ir1 = *(cSfS++);
    ir2 = *(op_accum + 1);
    ir3 = *(cSfS++);
    ir4 = *(op_accum + 2);
    ir5 = *(cSfS++);
    ir6 = *(op_accum + 3);
    ir7 = *(cSfS++);

    ir0 = ir1 - ir0;
    ir2 = ir3 - ir2;
    ir4 = ir5 - ir4;
    ir6 = ir7 - ir6;
    *(op_accum++) = ir0;
    *(op_accum++) = ir2;
    *(op_accum++) = ir4;
    *(op_accum++) = ir6;
  }

  op_accum = h; op_tmp = h_ext;
  for (i = 0; i < 384; i += 12) {
    ir0 = *(op_tmp++);
    ir1 = *(op_tmp++);
    ir2 = *(op_tmp++);
    ir3 = *(op_tmp++);
    ir4 = *(op_tmp++);
    ir5 = *(op_tmp++);
    ir6 = *(op_tmp++);
    ir7 = *(op_tmp++);
    ir8 = *(op_tmp++);
    ir9 = *(op_tmp++);
    ir10 = *(op_tmp++);
    ir11 = *(op_tmp++);
    *(op_accum++) = ir0;
    *(op_accum++) = ir1;
    *(op_accum++) = ir2;
    *(op_accum++) = ir3;
    *(op_accum++) = ir4;
    *(op_accum++) = ir5;
    *(op_accum++) = ir6;
    *(op_accum++) = ir7;
    *(op_accum++) = ir8;
    *(op_accum++) = ir9;
    *(op_accum++) = ir10;
    *(op_accum++) = ir11;
  }
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
  int i, j1, j2, k;
  uint32_t c_ext[288], f_ext[288];
  int32_t h_ext[1152];
  int32_t *cf, *cSfS, *bndry;

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

  if (scaleIn > 1) { // 2 2 2 2 4 4 4 4 8
    for (i = 0; i < 288; ++i) c_ext[i] = barrett_16x2(c_ext[i]);
    gf_polymul_64x64sh_unreduced((int *)h_ext, (int *)c_ext, (int *)f_ext, 14);
    gf_polymul_64x64sh_unreduced((int *)(h_ext + 128), (int *)(c_ext + 32), (int *)(f_ext + 32), 14);
    gf_polymul_64x64sh_unreduced((int *)(h_ext + 256), (int *)(c_ext + 64), (int *)(f_ext + 64), 14);
    gf_polymul_64x64sh_unreduced((int *)(h_ext + 384), (int *)(c_ext + 96), (int *)(f_ext + 96), 14);
    gf_polymul_64x64sh_unreduced((int *)(h_ext + 512), (int *)(c_ext + 128), (int *)(f_ext + 128), 7);
    gf_polymul_64x64sh_unreduced((int *)(h_ext + 640), (int *)(c_ext + 160), (int *)(f_ext + 160), 7);
    gf_polymul_64x64sh_unreduced((int *)(h_ext + 768), (int *)(c_ext + 192), (int *)(f_ext + 192), 7);
    gf_polymul_64x64sh_unreduced((int *)(h_ext + 896), (int *)(c_ext + 224), (int *)(f_ext + 224), 7);
    gf_polymul_64x64sh_unreduced((int *)(h_ext + 1024), (int *)(c_ext + 256), (int *)(f_ext + 256), 3);
  } else { // 1 1 1 1 2 2 2 2 4
    for (i = 128; i < 288; ++i) c_ext[i] = barrett_16x2(c_ext[i]);
    gf_polymul_64x64sh_unreduced((int *)h_ext, (int *)c_ext, (int *)f_ext, 28);
    gf_polymul_64x64sh_unreduced((int *)(h_ext + 128), (int *)(c_ext + 32), (int *)(f_ext + 32), 28);
    gf_polymul_64x64sh_unreduced((int *)(h_ext + 256), (int *)(c_ext + 64), (int *)(f_ext + 64), 28);
    gf_polymul_64x64sh_unreduced((int *)(h_ext + 384), (int *)(c_ext + 96), (int *)(f_ext + 96), 28);
    gf_polymul_64x64sh_unreduced((int *)(h_ext + 512), (int *)(c_ext + 128), (int *)(f_ext + 128), 14);
    gf_polymul_64x64sh_unreduced((int *)(h_ext + 640), (int *)(c_ext + 160), (int *)(f_ext + 160), 14);
    gf_polymul_64x64sh_unreduced((int *)(h_ext + 768), (int *)(c_ext + 192), (int *)(f_ext + 192), 14);
    gf_polymul_64x64sh_unreduced((int *)(h_ext + 896), (int *)(c_ext + 224), (int *)(f_ext + 224), 14);
    gf_polymul_64x64sh_unreduced((int *)(h_ext + 1024), (int *)(c_ext + 256), (int *)(f_ext + 256), 7);
  }
  // for (i = 0; i < 288; i += 32) gf_polymul_64x64sh_unreduced((int *)(h_ext + (i << 2)), (int *)(c_ext + i), (int *)(f_ext + i));
  // for (i = 0; i < 288; i += 32) smlal_mult_64(h_ext + (i << 2), (int16_t *)(c_ext + i), (int16_t *)(f_ext + i));

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

// 768x768 Karatsuba ft. smlal
void Karatsuba_on_smlal(uint32_t *h, uint32_t *c, uint32_t *f) {
  int i, j1, j2, k;
  int16_t mono_c, mono_f;
  int16_t *c_sch, *f_sch;
  uint32_t r0, r1, r2, r3, r4, r5, r6, r7;
  uint32_t *c_to, *f_to, *c_from1, *f_from1, *c_from2, *f_from2;
  uint32_t c_ext[864], f_ext[864];
  int32_t accum, ir0, ir1, ir2, ir3, ir4, ir5, ir6, ir7, ir8, ir9, ir10, ir11;
  int32_t *cf, *cSfS, *bndry, *op_accum, *op_tmp, *op_tmp2;
  int32_t h_ext[3456];

  c_to = c_ext; f_to = f_ext; c_from1 = c; f_from1 = f;
  for (i = 0; i < 384; i += 4) {
    r0 = *(c_from1++);
    r1 = *(c_from1++);
    r2 = *(c_from1++);
    r3 = *(c_from1++);
    r4 = *(f_from1++);
    r5 = *(f_from1++);
    r6 = *(f_from1++);
    r7 = *(f_from1++);
    *(c_to++) = r0;
    *(c_to++) = r1;
    *(c_to++) = r2;
    *(c_to++) = r3;
    *(f_to++) = r4;
    *(f_to++) = r5;
    *(f_to++) = r6;
    *(f_to++) = r7;
  }
  c_from2 = c_to - 192; c_from1 = c_to - 384; f_from2 = f_to - 192; f_from1 = f_to - 384;
  for (j1 = 192; j1 < 384; ++j1) {
    r0 = *(c_from1++);
    r1 = *(c_from2++);
    r2 = *(f_from1++);
    r3 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r0 = barrett_16x2(r0);
    *(f_to++) = r2;
    *(c_to++) = r0;
  }
  c_from2 = c_to - 480; c_from1 = c_to - 576; f_from2 = f_to - 480; f_from1 = f_to - 576;
  for (i = 0, j1 = 96; j1 < 576; ++i, ++j1) {
    if (i == 96) { i = 0; j1 += 96; c_from1 += 96; c_from2 += 96; f_from1 += 96; f_from2 += 96; }
    r0 = *(c_from1++);
    r1 = *(c_from2++);
    r2 = *(f_from1++);
    r3 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r0 = barrett_16x2(r0);
    *(f_to++) = r2;
    *(c_to++) = r0;
  }

  // call smlal with customized scale
  gf_polymul_192x192sh_unreduced((int *)h_ext, (int *)c_ext, (int *)f_ext, 28);
  gf_polymul_192x192sh_unreduced((int *)(h_ext + 384), (int *)(c_ext + 96), (int *)(f_ext + 96), 28);
  gf_polymul_192x192sh_unreduced((int *)(h_ext + 768), (int *)(c_ext + 192), (int *)(f_ext + 192), 28);
  gf_polymul_192x192sh_unreduced((int *)(h_ext + 1152), (int *)(c_ext + 288), (int *)(f_ext + 288), 28);
  gf_polymul_192x192sh_unreduced((int *)(h_ext + 1536), (int *)(c_ext + 384), (int *)(f_ext + 384), 14);
  gf_polymul_192x192sh_unreduced((int *)(h_ext + 1920), (int *)(c_ext + 480), (int *)(f_ext + 480), 14);
  gf_polymul_192x192sh_unreduced((int *)(h_ext + 2304), (int *)(c_ext + 576), (int *)(f_ext + 576), 14);
  gf_polymul_192x192sh_unreduced((int *)(h_ext + 2688), (int *)(c_ext + 672), (int *)(f_ext + 672), 14);
  gf_polymul_192x192sh_unreduced((int *)(h_ext + 3072), (int *)(c_ext + 768), (int *)(f_ext + 768), 7);

  cf = h_ext; bndry = cf + 2304; cSfS = bndry;
  for (; cf < bndry; cf += 768) {
    op_accum = cf + 192; op_tmp = cf + 384;
    for (j1 = 0; j1 < 192; j1 += 4) {
      ir0 = *op_accum;
      ir1 = *(op_tmp++);
      ir2 = *(op_accum + 1);
      ir3 = *(op_tmp++);
      ir4 = *(op_accum + 2);
      ir5 = *(op_tmp++);
      ir6 = *(op_accum + 3);
      ir7 = *(op_tmp++);

      ir0 = ir1 - ir0;
      ir2 = ir3 - ir2;
      ir4 = ir5 - ir4;
      ir6 = ir7 - ir6;
      *(op_accum++) = ir0;
      *(op_accum++) = ir2;
      *(op_accum++) = ir4;
      *(op_accum++) = ir6;
    }
    op_tmp2 = cf + 192;
    for (j1 = 0; j1 < 192; j1 += 3) {
      ir0 = *(op_tmp++);
      ir1 = *(op_tmp2++);
      ir2 = *(op_tmp++);
      ir3 = *(op_tmp2++);
      ir4 = *(op_tmp++);
      ir5 = *(op_tmp2++);

      ir0 = ir0 - ir1;
      ir2 = ir2 - ir3;
      ir4 = ir4 - ir5;
      *(op_accum++) = ir0;
      *(op_accum++) = ir2;
      *(op_accum++) = ir4;
    }
    op_accum = cf + 192; op_tmp = cf;
    for (j1 = 0; j1 < 192; j1 += 4) {
      ir0 = *op_accum;
      ir1 = *(op_tmp++);
      ir2 = *(op_accum + 1);
      ir3 = *(op_tmp++);
      ir4 = *(op_accum + 2);
      ir5 = *(op_tmp++);
      ir6 = *(op_accum + 3);
      ir7 = *(op_tmp++);

      ir0 = ir0 + ir1;
      ir2 = ir2 + ir3;
      ir4 = ir4 + ir5;
      ir6 = ir6 + ir7;
      *(op_accum++) = ir0;
      *(op_accum++) = ir2;
      *(op_accum++) = ir4;
      *(op_accum++) = ir6;
    }
    op_accum = cf + 192;
    for (j1 = 0; j1 < 384; j1 += 4) {
      ir0 = *op_accum;
      ir1 = *(cSfS++);
      ir2 = *(op_accum + 1);
      ir3 = *(cSfS++);
      ir4 = *(op_accum + 2);
      ir5 = *(cSfS++);
      ir6 = *(op_accum + 3);
      ir7 = *(cSfS++);

      ir0 = ir1 - ir0;
      ir2 = ir3 - ir2;
      ir4 = ir5 - ir4;
      ir6 = ir7 - ir6;
      *(op_accum++) = ir0;
      *(op_accum++) = ir2;
      *(op_accum++) = ir4;
      *(op_accum++) = ir6;
    }
  }

  cf = h_ext; cSfS = cf + 1536;
  op_accum = cf + 384; op_tmp = cf + 768;
  for (j1 = 0; j1 < 384; j1 += 4) {
    ir0 = *op_accum;
    ir1 = *(op_tmp++);
    ir2 = *(op_accum + 1);
    ir3 = *(op_tmp++);
    ir4 = *(op_accum + 2);
    ir5 = *(op_tmp++);
    ir6 = *(op_accum + 3);
    ir7 = *(op_tmp++);

    ir0 = ir1 - ir0;
    ir2 = ir3 - ir2;
    ir4 = ir5 - ir4;
    ir6 = ir7 - ir6;
    *(op_accum++) = ir0;
    *(op_accum++) = ir2;
    *(op_accum++) = ir4;
    *(op_accum++) = ir6;
  }
  op_tmp2 = cf + 384;
  for (j1 = 0; j1 < 384; j1 += 3) {
    ir0 = *(op_tmp++);
    ir1 = *(op_tmp2++);
    ir2 = *(op_tmp++);
    ir3 = *(op_tmp2++);
    ir4 = *(op_tmp++);
    ir5 = *(op_tmp2++);

    ir0 = ir0 - ir1;
    ir2 = ir2 - ir3;
    ir4 = ir4 - ir5;
    *(op_accum++) = ir0;
    *(op_accum++) = ir2;
    *(op_accum++) = ir4;
  }
  op_accum = cf + 384; op_tmp = cf;
  for (j1 = 0; j1 < 384; j1 += 4) {
    ir0 = *op_accum;
    ir1 = *(op_tmp++);
    ir2 = *(op_accum + 1);
    ir3 = *(op_tmp++);
    ir4 = *(op_accum + 2);
    ir5 = *(op_tmp++);
    ir6 = *(op_accum + 3);
    ir7 = *(op_tmp++);

    ir0 = ir0 + ir1;
    ir2 = ir2 + ir3;
    ir4 = ir4 + ir5;
    ir6 = ir6 + ir7;
    *(op_accum++) = ir0;
    *(op_accum++) = ir2;
    *(op_accum++) = ir4;
    *(op_accum++) = ir6;
  }
  op_accum = cf + 384;
  for (j1 = 0; j1 < 768; j1 += 4) {
    ir0 = *op_accum;
    ir1 = *(cSfS++);
    ir2 = *(op_accum + 1);
    ir3 = *(cSfS++);
    ir4 = *(op_accum + 2);
    ir5 = *(cSfS++);
    ir6 = *(op_accum + 3);
    ir7 = *(cSfS++);

    ir0 = ir1 - ir0;
    ir2 = ir3 - ir2;
    ir4 = ir5 - ir4;
    ir6 = ir7 - ir6;
    *(op_accum++) = ir0;
    *(op_accum++) = ir2;
    *(op_accum++) = ir4;
    *(op_accum++) = ir6;
  }

  op_tmp = h_ext;
  for (i = 0; i < 1536; i += 8) {
    ir0 = *(op_tmp++);
    ir1 = *(op_tmp++);
    ir2 = *(op_tmp++);
    ir3 = *(op_tmp++);
    ir4 = *(op_tmp++);
    ir5 = *(op_tmp++);
    ir6 = *(op_tmp++);
    ir7 = *(op_tmp++);

    ir0 = barrett_32(ir0);
    ir1 = barrett_32(ir1);
    ir0 = __PKHBT(ir0, ir1, 16);
    ir2 = barrett_32(ir2);
    ir3 = barrett_32(ir3);
    ir2 = __PKHBT(ir2, ir3, 16);
    ir4 = barrett_32(ir4);
    ir5 = barrett_32(ir5);
    ir4 = __PKHBT(ir4, ir5, 16);
    ir6 = barrett_32(ir6);
    ir7 = barrett_32(ir7);
    ir6 = __PKHBT(ir6, ir7, 16);

    *(h++) = ir0;
    *(h++) = ir2;
    *(h++) = ir4;
    *(h++) = ir6;
  }
}
