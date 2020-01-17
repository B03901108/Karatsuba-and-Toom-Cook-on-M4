#include "Karatsuba.h"
#include "polymul_16x16.h"

// 192x192 3-layer Karatsuba
void Karatsuba_mult(int32_t *h, uint32_t *c, uint32_t *f) {
  int i, j1;
  uint32_t r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10;
  uint32_t *c_to, *f_to, *c_from1, *f_from1, *c_from2, *f_from2;
  uint32_t c_ext[324], f_ext[324];
  int32_t ir0, ir1, ir2, ir3, ir4, ir5, ir6, ir7, ir8, ir9, ir10, ir11;
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
      ir2 = __SMLABB(r0, r4, ir2);
      ir4 = __SMULTT(r2, r3);
      ir6 = __SMULTT(r2, r4);
      r0 = __PKHBT(r2, r0, 0);
      ir2 = __SMLAD(r0, r3, ir2);
      ir4 = __SMLAD(r0, r4, ir4);  
      c_from1 += 3;
      while (f_from1 != f_to) {
        r0 = *(c_from1++);
        r2 = *(c_from1++);
        r4 = *(f_from1--);
        r3 = *(f_from1--);
        ir1 = __SMLADX(r0, r3, ir1);
        ir3 = __SMLADX(r0, r4, ir3);
        ir3 = __SMLADX(r2, r3, ir3);
        ir5 = __SMLADX(r2, r4, ir5);
        ir0 = __SMLABB(r0, r3, ir0);
        ir2 = __SMLABB(r0, r4, ir2);
        ir4 = __SMLATT(r2, r3, ir4);
        ir6 = __SMLATT(r2, r4, ir6);
        r0 = __PKHBT(r2, r0, 0);
        ir2 = __SMLAD(r0, r3, ir2);
        ir4 = __SMLAD(r0, r4, ir4);  
      }
      *(cf++) = ir0;
      *(cf++) = ir1;
      *(cf++) = ir2;
      *(cf++) = ir3;

      r2 = *(c_from1 + 1);
      r0 = *(c_from1--);
      ir5 = __SMLADX(r0, r3, ir5);
      ir3 = __SMUADX(r0, r4);
      ir3 = __SMLADX(r2, r3, ir3);
      ir1 = __SMUADX(r2, r4);
      ir4 = __SMLABB(r0, r3, ir4);
      ir6 = __SMLABB(r0, r4, ir6);
      ir0 = __SMULTT(r2, r3);
      ir2 = __SMULTT(r2, r4);
      r0 = __PKHBT(r2, r0, 0);
      ir6 = __SMLAD(r0, r3, ir6);
      ir0 = __SMLAD(r0, r4, ir0);  
      f_from1 += 3;
      while (c_from1 != c_to) {
        r2 = *(c_from1--);
        r0 = *(c_from1--);
        r3 = *(f_from1++);
        r4 = *(f_from1++);
        ir5 = __SMLADX(r0, r3, ir5);
        ir3 = __SMLADX(r0, r4, ir3);
        ir3 = __SMLADX(r2, r3, ir3);
        ir1 = __SMLADX(r2, r4, ir1);
        ir4 = __SMLABB(r0, r3, ir4);
        ir6 = __SMLABB(r0, r4, ir6);
        ir0 = __SMLATT(r2, r3, ir0);
        ir2 = __SMLATT(r2, r4, ir2);
        r0 = __PKHBT(r2, r0, 0);
        ir6 = __SMLAD(r0, r3, ir6);
        ir0 = __SMLAD(r0, r4, ir0);  
      }
      r0 = *(c_from1 + 1);
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
      r0 = *(c_from1++);
      r2 = *(c_from1++);
      ir1 = __SMLADX(r0, r3, ir1);
      ir3 = __SMUADX(r0, r4);
      ir3 = __SMLADX(r2, r3, ir3);
      ir5 = __SMUADX(r2, r4);
      ir0 = __SMLABB(r0, r3, ir0);
      ir2 = __SMLABB(r0, r4, ir2);
      ir6 = __SMULTT(r2, r4);
      ir4 = __SMULTT(r2, r3);
      r0 = __PKHBT(r2, r0, 0);
      ir2 = __SMLAD(r0, r3, ir2);
      ir4 = __SMLAD(r0, r4, ir4);  

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
        r0 = *(c_from1++);
        r2 = *(c_from1++);
        r4 = *(f_from1--);
        r3 = *(f_from1--);
        ir1 = __SMLADX(r0, r3, ir1);
        ir3 = __SMLADX(r0, r4, ir3);
        ir3 = __SMLADX(r2, r3, ir3);
        ir5 = __SMLADX(r2, r4, ir5);
        ir0 = __SMLABB(r0, r3, ir0);
        ir2 = __SMLABB(r0, r4, ir2);
        ir4 = __SMLATT(r2, r3, ir4);
        ir6 = __SMLATT(r2, r4, ir6);
        r0 = __PKHBT(r2, r0, 0);
        ir2 = __SMLAD(r0, r3, ir2);
        ir4 = __SMLAD(r0, r4, ir4);  
      }
      r0 = *(c_from1 - 2);
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
      ir6 = __SMLABB(r0, r4, ir6);
      ir0 = __SMULTT(r2, r3);
      ir2 = __SMULTT(r2, r4);
      r0 = __PKHBT(r2, r0, 0);
      ir6 = __SMLAD(r0, r3, ir6);
      ir0 = __SMLAD(r0, r4, ir0);  
      c_from1 -= 3;
      while (f_from1 != f_to) {
        r2 = *(c_from1--);
        r0 = *(c_from1--);
        r3 = *(f_from1++);
        r4 = *(f_from1++);
        ir5 = __SMLADX(r0, r3, ir5);
        ir3 = __SMLADX(r0, r4, ir3);
        ir3 = __SMLADX(r2, r3, ir3);
        ir1 = __SMLADX(r2, r4, ir1);
        ir4 = __SMLABB(r0, r3, ir4);
        ir6 = __SMLABB(r0, r4, ir6);
        ir0 = __SMLATT(r2, r3, ir0);
        ir2 = __SMLATT(r2, r4, ir2);
        r0 = __PKHBT(r2, r0, 0);
        ir6 = __SMLAD(r0, r3, ir6);
        ir0 = __SMLAD(r0, r4, ir0);  
      }
      *(cf++) = ir4;
      *(cf++) = ir5;
      *(cf++) = ir6;
      *(cf++) = ir3;
    }
  }

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
