#include "Karatsuba.h"
#include "cmsis.h"

extern void hybrid_mult_asm(int32_t *, uint32_t *, uint32_t*);

void compose_output_coefs(int32_t * cf) {
  int j1;
  int32_t ir0, ir1, ir2, ir3, ir4, ir5, ir6, ir7, ir8, ir9;
  int32_t *bndry, *cSfS, *op_accum, *op_tmp, *op_tmp2;
  /* bndry = cf + 864; cSfS = bndry;
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

  cf -= 864; */ bndry = cf + 576; cSfS = bndry;
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

  cf -= 576; cSfS = cf + 384;
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
}

uint32_t* extend_input_coefs_f(uint32_t * f_to) {
  uint32_t r0, r1, r2, r3, r4, r5, r6, r7;
  uint32_t *f_from1, *f_from2, *brake;

  f_from2 = f_to - 48; f_from1 = f_from2 - 48; brake = f_from2;
  while (f_from1 != brake) {
    r0 = *(f_from1++); r1 = *(f_from2++);
    r2 = *(f_from1++); r3 = *(f_from2++);
    r4 = *(f_from1++); r5 = *(f_from2++);
    r6 = *(f_from1++); r7 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);
    r6 = __SADD16(r6, r7);
    *(f_to++) = r0;
    *(f_to++) = r2;
    *(f_to++) = r4;
    *(f_to++) = r6;
  }

  f_from2 = f_to - 120; f_from1 = f_from2 - 24; brake = f_from2;
  while (f_from1 != brake) {
    r0 = *(f_from1++); r1 = *(f_from2++);
    r2 = *(f_from1++); r3 = *(f_from2++);
    r4 = *(f_from1++); r5 = *(f_from2++);
    r6 = *(f_from1++); r7 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);
    r6 = __SADD16(r6, r7);
    *(f_to++) = r0;
    *(f_to++) = r2;
    *(f_to++) = r4;
    *(f_to++) = r6;
  }
  f_from1 += 24; f_from2 += 24; brake = f_from2;
  while (f_from1 != brake) {
    r0 = *(f_from1++); r1 = *(f_from2++);
    r2 = *(f_from1++); r3 = *(f_from2++);
    r4 = *(f_from1++); r5 = *(f_from2++);
    r6 = *(f_from1++); r7 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);
    r6 = __SADD16(r6, r7);
    *(f_to++) = r0;
    *(f_to++) = r2;
    *(f_to++) = r4;
    *(f_to++) = r6;
  }
  f_from1 += 24; f_from2 += 24; brake = f_from2;
  while (f_from1 != brake) {
    r0 = *(f_from1++); r1 = *(f_from2++);
    r2 = *(f_from1++); r3 = *(f_from2++);
    r4 = *(f_from1++); r5 = *(f_from2++);
    r6 = *(f_from1++); r7 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);
    r6 = __SADD16(r6, r7);
    *(f_to++) = r0;
    *(f_to++) = r2;
    *(f_to++) = r4;
    *(f_to++) = r6;
  }

  /* f_from2 = f_to - 204; f_from1 = f_from2 - 12; brake = f_from2;
  while (f_from1 != brake) {
    r0 = *(f_from1++); r1 = *(f_from2++);
    r2 = *(f_from1++); r3 = *(f_from2++);
    r4 = *(f_from1++); r5 = *(f_from2++);
    r6 = *(f_from1++); r7 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);
    r6 = __SADD16(r6, r7);
    *(f_to++) = r0;
    *(f_to++) = r2;
    *(f_to++) = r4;
    *(f_to++) = r6;
  }
  f_from1 += 12; f_from2 += 12; brake = f_from2;
  while (f_from1 != brake) {
    r0 = *(f_from1++); r1 = *(f_from2++);
    r2 = *(f_from1++); r3 = *(f_from2++);
    r4 = *(f_from1++); r5 = *(f_from2++);
    r6 = *(f_from1++); r7 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);
    r6 = __SADD16(r6, r7);
    *(f_to++) = r0;
    *(f_to++) = r2;
    *(f_to++) = r4;
    *(f_to++) = r6;
  }
  f_from1 += 12; f_from2 += 12; brake = f_from2;
  while (f_from1 != brake) {
    r0 = *(f_from1++); r1 = *(f_from2++);
    r2 = *(f_from1++); r3 = *(f_from2++);
    r4 = *(f_from1++); r5 = *(f_from2++);
    r6 = *(f_from1++); r7 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);
    r6 = __SADD16(r6, r7);
    *(f_to++) = r0;
    *(f_to++) = r2;
    *(f_to++) = r4;
    *(f_to++) = r6;
  }
  f_from1 += 12; f_from2 += 12; brake = f_from2;
  while (f_from1 != brake) {
    r0 = *(f_from1++); r1 = *(f_from2++);
    r2 = *(f_from1++); r3 = *(f_from2++);
    r4 = *(f_from1++); r5 = *(f_from2++);
    r6 = *(f_from1++); r7 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);
    r6 = __SADD16(r6, r7);
    *(f_to++) = r0;
    *(f_to++) = r2;
    *(f_to++) = r4;
    *(f_to++) = r6;
  }
  f_from1 += 12; f_from2 += 12; brake = f_from2;
  while (f_from1 != brake) {
    r0 = *(f_from1++); r1 = *(f_from2++);
    r2 = *(f_from1++); r3 = *(f_from2++);
    r4 = *(f_from1++); r5 = *(f_from2++);
    r6 = *(f_from1++); r7 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);
    r6 = __SADD16(r6, r7);
    *(f_to++) = r0;
    *(f_to++) = r2;
    *(f_to++) = r4;
    *(f_to++) = r6;
  }
  f_from1 += 12; f_from2 += 12; brake = f_from2;
  while (f_from1 != brake) {
    r0 = *(f_from1++); r1 = *(f_from2++);
    r2 = *(f_from1++); r3 = *(f_from2++);
    r4 = *(f_from1++); r5 = *(f_from2++);
    r6 = *(f_from1++); r7 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);
    r6 = __SADD16(r6, r7);
    *(f_to++) = r0;
    *(f_to++) = r2;
    *(f_to++) = r4;
    *(f_to++) = r6;
  }
  f_from1 += 12; f_from2 += 12; brake = f_from2;
  while (f_from1 != brake) {
    r0 = *(f_from1++); r1 = *(f_from2++);
    r2 = *(f_from1++); r3 = *(f_from2++);
    r4 = *(f_from1++); r5 = *(f_from2++);
    r6 = *(f_from1++); r7 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);
    r6 = __SADD16(r6, r7);
    *(f_to++) = r0;
    *(f_to++) = r2;
    *(f_to++) = r4;
    *(f_to++) = r6;
  }
  f_from1 += 12; f_from2 += 12; brake = f_from2;
  while (f_from1 != brake) {
    r0 = *(f_from1++); r1 = *(f_from2++);
    r2 = *(f_from1++); r3 = *(f_from2++);
    r4 = *(f_from1++); r5 = *(f_from2++);
    r6 = *(f_from1++); r7 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);
    r6 = __SADD16(r6, r7);
    *(f_to++) = r0;
    *(f_to++) = r2;
    *(f_to++) = r4;
    *(f_to++) = r6;
  }
  f_from1 += 12; f_from2 += 12; brake = f_from2;
  while (f_from1 != brake) {
    r0 = *(f_from1++); r1 = *(f_from2++);
    r2 = *(f_from1++); r3 = *(f_from2++);
    r4 = *(f_from1++); r5 = *(f_from2++);
    r6 = *(f_from1++); r7 = *(f_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);
    r6 = __SADD16(r6, r7);
    *(f_to++) = r0;
    *(f_to++) = r2;
    *(f_to++) = r4;
    *(f_to++) = r6;
  } */

  return f_to;
}

uint32_t* extend_input_coefs_c(uint32_t * c_to) {
  uint32_t qR2inv, _2P15, q, r0, r1, r2, r3, r4, r5;
  uint32_t *c_from1, *c_from2, *brake;

  qR2inv = 935519; _2P15 = 32768; q = 4591;
  c_from2 = c_to - 48; c_from1 = c_from2 - 48; brake = c_from2;
  while (c_from1 != brake) {
    r0 = *(c_from1++); r1 = *(c_from2++);
    r2 = *(c_from1++); r3 = *(c_from2++);
    r4 = *(c_from1++); r5 = *(c_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);

    r1 = __SMLAWB(qR2inv, r0, _2P15);
    r3 = __SMLAWT(qR2inv, r0, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r0 = __SSUB16(r0, r1);

    r1 = __SMLAWB(qR2inv, r2, _2P15);
    r3 = __SMLAWT(qR2inv, r2, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r2 = __SSUB16(r2, r1);

    r1 = __SMLAWB(qR2inv, r4, _2P15);
    r3 = __SMLAWT(qR2inv, r4, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r4 = __SSUB16(r4, r1);

    *(c_to++) = r0;
    *(c_to++) = r2;
    *(c_to++) = r4;
  }

  c_from2 = c_to - 120; c_from1 = c_from2 - 24; brake = c_from2;
  while (c_from1 != brake) {
    r0 = *(c_from1++); r1 = *(c_from2++);
    r2 = *(c_from1++); r3 = *(c_from2++);
    r4 = *(c_from1++); r5 = *(c_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);

    r1 = __SMLAWB(qR2inv, r0, _2P15);
    r3 = __SMLAWT(qR2inv, r0, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r0 = __SSUB16(r0, r1);

    r1 = __SMLAWB(qR2inv, r2, _2P15);
    r3 = __SMLAWT(qR2inv, r2, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r2 = __SSUB16(r2, r1);

    r1 = __SMLAWB(qR2inv, r4, _2P15);
    r3 = __SMLAWT(qR2inv, r4, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r4 = __SSUB16(r4, r1);

    *(c_to++) = r0;
    *(c_to++) = r2;
    *(c_to++) = r4;
  }
  c_from1 += 24; c_from2 += 24; brake = c_from2;
  while (c_from1 != brake) {
    r0 = *(c_from1++); r1 = *(c_from2++);
    r2 = *(c_from1++); r3 = *(c_from2++);
    r4 = *(c_from1++); r5 = *(c_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);

    r1 = __SMLAWB(qR2inv, r0, _2P15);
    r3 = __SMLAWT(qR2inv, r0, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r0 = __SSUB16(r0, r1);

    r1 = __SMLAWB(qR2inv, r2, _2P15);
    r3 = __SMLAWT(qR2inv, r2, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r2 = __SSUB16(r2, r1);

    r1 = __SMLAWB(qR2inv, r4, _2P15);
    r3 = __SMLAWT(qR2inv, r4, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r4 = __SSUB16(r4, r1);

    *(c_to++) = r0;
    *(c_to++) = r2;
    *(c_to++) = r4;
  }
  c_from1 += 24; c_from2 += 24; brake = c_from2;
  while (c_from1 != brake) {
    r0 = *(c_from1++); r1 = *(c_from2++);
    r2 = *(c_from1++); r3 = *(c_from2++);
    r4 = *(c_from1++); r5 = *(c_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);

    r1 = __SMLAWB(qR2inv, r0, _2P15);
    r3 = __SMLAWT(qR2inv, r0, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r0 = __SSUB16(r0, r1);

    r1 = __SMLAWB(qR2inv, r2, _2P15);
    r3 = __SMLAWT(qR2inv, r2, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r2 = __SSUB16(r2, r1);

    r1 = __SMLAWB(qR2inv, r4, _2P15);
    r3 = __SMLAWT(qR2inv, r4, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r4 = __SSUB16(r4, r1);

    *(c_to++) = r0;
    *(c_to++) = r2;
    *(c_to++) = r4;
  }

  /* c_from2 = c_to - 204; c_from1 = c_from2 - 12; brake = c_from2;
  while (c_from1 != brake) {
    r0 = *(c_from1++); r1 = *(c_from2++);
    r2 = *(c_from1++); r3 = *(c_from2++);
    r4 = *(c_from1++); r5 = *(c_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);

    r1 = __SMLAWB(qR2inv, r0, _2P15);
    r3 = __SMLAWT(qR2inv, r0, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r0 = __SSUB16(r0, r1);

    r1 = __SMLAWB(qR2inv, r2, _2P15);
    r3 = __SMLAWT(qR2inv, r2, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r2 = __SSUB16(r2, r1);

    r1 = __SMLAWB(qR2inv, r4, _2P15);
    r3 = __SMLAWT(qR2inv, r4, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r4 = __SSUB16(r4, r1);

    *(c_to++) = r0;
    *(c_to++) = r2;
    *(c_to++) = r4;
  }
  c_from1 += 12; c_from2 += 12; brake = c_from2;
  while (c_from1 != brake) {
    r0 = *(c_from1++); r1 = *(c_from2++);
    r2 = *(c_from1++); r3 = *(c_from2++);
    r4 = *(c_from1++); r5 = *(c_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);

    r1 = __SMLAWB(qR2inv, r0, _2P15);
    r3 = __SMLAWT(qR2inv, r0, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r0 = __SSUB16(r0, r1);

    r1 = __SMLAWB(qR2inv, r2, _2P15);
    r3 = __SMLAWT(qR2inv, r2, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r2 = __SSUB16(r2, r1);

    r1 = __SMLAWB(qR2inv, r4, _2P15);
    r3 = __SMLAWT(qR2inv, r4, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r4 = __SSUB16(r4, r1);

    *(c_to++) = r0;
    *(c_to++) = r2;
    *(c_to++) = r4;
  }
  c_from1 += 12; c_from2 += 12; brake = c_from2;
  while (c_from1 != brake) {
    r0 = *(c_from1++); r1 = *(c_from2++);
    r2 = *(c_from1++); r3 = *(c_from2++);
    r4 = *(c_from1++); r5 = *(c_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);

    r1 = __SMLAWB(qR2inv, r0, _2P15);
    r3 = __SMLAWT(qR2inv, r0, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r0 = __SSUB16(r0, r1);

    r1 = __SMLAWB(qR2inv, r2, _2P15);
    r3 = __SMLAWT(qR2inv, r2, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r2 = __SSUB16(r2, r1);

    r1 = __SMLAWB(qR2inv, r4, _2P15);
    r3 = __SMLAWT(qR2inv, r4, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r4 = __SSUB16(r4, r1);

    *(c_to++) = r0;
    *(c_to++) = r2;
    *(c_to++) = r4;
  }
  c_from1 += 12; c_from2 += 12; brake = c_from2;
  while (c_from1 != brake) {
    r0 = *(c_from1++); r1 = *(c_from2++);
    r2 = *(c_from1++); r3 = *(c_from2++);
    r4 = *(c_from1++); r5 = *(c_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);

    r1 = __SMLAWB(qR2inv, r0, _2P15);
    r3 = __SMLAWT(qR2inv, r0, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r0 = __SSUB16(r0, r1);

    r1 = __SMLAWB(qR2inv, r2, _2P15);
    r3 = __SMLAWT(qR2inv, r2, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r2 = __SSUB16(r2, r1);

    r1 = __SMLAWB(qR2inv, r4, _2P15);
    r3 = __SMLAWT(qR2inv, r4, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r4 = __SSUB16(r4, r1);

    *(c_to++) = r0;
    *(c_to++) = r2;
    *(c_to++) = r4;
  }
  c_from1 += 12; c_from2 += 12; brake = c_from2;
  while (c_from1 != brake) {
    r0 = *(c_from1++); r1 = *(c_from2++);
    r2 = *(c_from1++); r3 = *(c_from2++);
    r4 = *(c_from1++); r5 = *(c_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);

    r1 = __SMLAWB(qR2inv, r0, _2P15);
    r3 = __SMLAWT(qR2inv, r0, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r0 = __SSUB16(r0, r1);

    r1 = __SMLAWB(qR2inv, r2, _2P15);
    r3 = __SMLAWT(qR2inv, r2, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r2 = __SSUB16(r2, r1);

    r1 = __SMLAWB(qR2inv, r4, _2P15);
    r3 = __SMLAWT(qR2inv, r4, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r4 = __SSUB16(r4, r1);

    *(c_to++) = r0;
    *(c_to++) = r2;
    *(c_to++) = r4;
  }
  c_from1 += 12; c_from2 += 12; brake = c_from2;
  while (c_from1 != brake) {
    r0 = *(c_from1++); r1 = *(c_from2++);
    r2 = *(c_from1++); r3 = *(c_from2++);
    r4 = *(c_from1++); r5 = *(c_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);

    r1 = __SMLAWB(qR2inv, r0, _2P15);
    r3 = __SMLAWT(qR2inv, r0, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r0 = __SSUB16(r0, r1);

    r1 = __SMLAWB(qR2inv, r2, _2P15);
    r3 = __SMLAWT(qR2inv, r2, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r2 = __SSUB16(r2, r1);

    r1 = __SMLAWB(qR2inv, r4, _2P15);
    r3 = __SMLAWT(qR2inv, r4, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r4 = __SSUB16(r4, r1);

    *(c_to++) = r0;
    *(c_to++) = r2;
    *(c_to++) = r4;
  }
  c_from1 += 12; c_from2 += 12; brake = c_from2;
  while (c_from1 != brake) {
    r0 = *(c_from1++); r1 = *(c_from2++);
    r2 = *(c_from1++); r3 = *(c_from2++);
    r4 = *(c_from1++); r5 = *(c_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);

    r1 = __SMLAWB(qR2inv, r0, _2P15);
    r3 = __SMLAWT(qR2inv, r0, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r0 = __SSUB16(r0, r1);

    r1 = __SMLAWB(qR2inv, r2, _2P15);
    r3 = __SMLAWT(qR2inv, r2, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r2 = __SSUB16(r2, r1);

    r1 = __SMLAWB(qR2inv, r4, _2P15);
    r3 = __SMLAWT(qR2inv, r4, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r4 = __SSUB16(r4, r1);

    *(c_to++) = r0;
    *(c_to++) = r2;
    *(c_to++) = r4;
  }
  c_from1 += 12; c_from2 += 12; brake = c_from2;
  while (c_from1 != brake) {
    r0 = *(c_from1++); r1 = *(c_from2++);
    r2 = *(c_from1++); r3 = *(c_from2++);
    r4 = *(c_from1++); r5 = *(c_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);

    r1 = __SMLAWB(qR2inv, r0, _2P15);
    r3 = __SMLAWT(qR2inv, r0, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r0 = __SSUB16(r0, r1);

    r1 = __SMLAWB(qR2inv, r2, _2P15);
    r3 = __SMLAWT(qR2inv, r2, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r2 = __SSUB16(r2, r1);

    r1 = __SMLAWB(qR2inv, r4, _2P15);
    r3 = __SMLAWT(qR2inv, r4, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r4 = __SSUB16(r4, r1);

    *(c_to++) = r0;
    *(c_to++) = r2;
    *(c_to++) = r4;
  }
  c_from1 += 12; c_from2 += 12; brake = c_from2;
  while (c_from1 != brake) {
    r0 = *(c_from1++); r1 = *(c_from2++);
    r2 = *(c_from1++); r3 = *(c_from2++);
    r4 = *(c_from1++); r5 = *(c_from2++);
    r0 = __SADD16(r0, r1);
    r2 = __SADD16(r2, r3);
    r4 = __SADD16(r4, r5);

    r1 = __SMLAWB(qR2inv, r0, _2P15);
    r3 = __SMLAWT(qR2inv, r0, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r0 = __SSUB16(r0, r1);

    r1 = __SMLAWB(qR2inv, r2, _2P15);
    r3 = __SMLAWT(qR2inv, r2, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r2 = __SSUB16(r2, r1);

    r1 = __SMLAWB(qR2inv, r4, _2P15);
    r3 = __SMLAWT(qR2inv, r4, _2P15);
    r1 = __SMULBT(q, r1);
    r3 = __SMULBT(q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r4 = __SSUB16(r4, r1);

    *(c_to++) = r0;
    *(c_to++) = r2;
    *(c_to++) = r4;
  } */

  return c_to;
}

// 192x192 2-layer Karatsuba
void Karatsuba_mult(int32_t *h, uint32_t *c, uint32_t *f) {
  int i, j1;
  uint32_t r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10;
  uint32_t *c_to, *f_to, *c_from1, *f_from1, *c_from2, *f_from2;
  uint32_t c_ext[216], f_ext[216];
  int32_t ir0, ir1, ir2, ir3, ir4, ir5, ir6, ir7, ir8, ir9, ir10, ir11;
  int32_t *cf, *cSfS, *bndry, *op_accum, *op_tmp, *op_tmp2;
  int32_t h_ext[864];

  f_to = f_ext; f_from1 = f;
  for (i = 0; i < 9; ++i) {
    r0 = *(f_from1++); r1 = *(f_from1++); r2 = *(f_from1++); r3 = *(f_from1++); r4 = *(f_from1++);
    r5 = *(f_from1++); r6 = *(f_from1++); r7 = *(f_from1++); r8 = *(f_from1++); r9 = *(f_from1++);
    *(f_to++) = r0; *(f_to++) = r1; *(f_to++) = r2; *(f_to++) = r3; *(f_to++) = r4;
    *(f_to++) = r5; *(f_to++) = r6; *(f_to++) = r7; *(f_to++) = r8; *(f_to++) = r9;
  }
  r0 = *(f_from1++); r1 = *(f_from1++); r2 = *(f_from1++); r3 = *(f_from1++); r4 = *(f_from1++); r5 = *(f_from1++);
  *(f_to++) = r0; *(f_to++) = r1; *(f_to++) = r2; *(f_to++) = r3; *(f_to++) = r4; *(f_to++) = r5;

  f_to = extend_input_coefs_f(f_to);

  c_to = c_ext; c_from1 = c;
  for (i = 0; i < 9; ++i) {
    r0 = *(c_from1++); r1 = *(c_from1++); r2 = *(c_from1++); r3 = *(c_from1++); r4 = *(c_from1++);
    r5 = *(c_from1++); r6 = *(c_from1++); r7 = *(c_from1++); r8 = *(c_from1++); r9 = *(c_from1++);
    *(c_to++) = r0; *(c_to++) = r1; *(c_to++) = r2; *(c_to++) = r3; *(c_to++) = r4;
    *(c_to++) = r5; *(c_to++) = r6; *(c_to++) = r7; *(c_to++) = r8; *(c_to++) = r9;
  }
  r0 = *(c_from1++); r1 = *(c_from1++); r2 = *(c_from1++); r3 = *(c_from1++); r4 = *(c_from1++); r5 = *(c_from1++);
  *(c_to++) = r0; *(c_to++) = r1; *(c_to++) = r2; *(c_to++) = r3; *(c_to++) = r4; *(c_to++) = r5;

  c_to = extend_input_coefs_c(c_to);

  hybrid_mult_asm(h_ext, c_to - 216, f_to - 216);

  compose_output_coefs(h_ext);

  op_accum = h; op_tmp = h_ext;
  for (i = 0; i < 38; ++i) {
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
  }
  ir0 = *(op_tmp++);
  ir1 = *(op_tmp++);
  ir2 = *(op_tmp++);
  ir3 = *(op_tmp++);
  *(op_accum++) = ir0;
  *(op_accum++) = ir1;
  *(op_accum++) = ir2;
  *(op_accum++) = ir3;
}
