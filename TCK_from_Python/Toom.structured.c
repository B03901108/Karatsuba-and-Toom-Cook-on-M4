#include "Toom.h"
#include "cmsis.h"

// specialized for 768x768
void Toom4_mult(int32_t *h, uint32_t *c, uint32_t *f) {
  int i;

  int32_t ir_qR2inv, ir_q, ir_2P15, ir0, ir1, ir2, ir3, ir4, ir5, ir6, ir7, ir8, ir9, ir10, ir11;
  int32_t *h0, *h1;
  int32_t h_tmp[1152];
  uint32_t r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12;
  uint32_t *arrIn, *arrOut;
  uint32_t c_eval[480], f_eval[480];

  arrIn = c;
  arrOut= c_eval;
  ir_q = 4591;
  ir_qR2inv = 935519;
  ir_2P15 = 32768;

  for (i = 0; i < 96; ++i) {
    r3 = *(arrIn + 288);
    r2 = *(arrIn + 96);
    r1 = *(arrIn + 192);
    r0 = *(arrIn++);

    r4 = r2 & 0xFFFF7FFF;
    r5 = r3 & 0xFFFF1FFF;
    r4 = r4 << 1;
    r5 = r5 << 3;
    r4 = __SADD16(r4, r5);

    r5 = __SMLAWB(ir_qR2inv, r4, ir_2P15);
    r6 = __SMLAWT(ir_qR2inv, r4, ir_2P15);
    r5 = __SMULBT(ir_q, r5);
    r6 = __SMULBT(ir_q, r6);
    r5 = __PKHBT(r5, r6, 16);
    r4 = __SSUB16(r4, r5);

    r5 = r1 & 0xFFFF3FFF;
    r5 = r5 << 2;
    r5 = __SADD16(r0, r5);

    r6 = __SADD16(r5, r4);
    r5 = __SSUB16(r5, r4);

    r4 = __SMLAWB(ir_qR2inv, r6, ir_2P15);
    r7 = __SMLAWT(ir_qR2inv, r6, ir_2P15);
    r4 = __SMULBT(ir_q, r4);
    r7 = __SMULBT(ir_q, r7);
    r4 = __PKHBT(r4, r7, 16);
    r6 = __SSUB16(r6, r4);

    r4 = __SMLAWB(ir_qR2inv, r5, ir_2P15);
    r7 = __SMLAWT(ir_qR2inv, r5, ir_2P15);
    r4 = __SMULBT(ir_q, r4);
    r7 = __SMULBT(ir_q, r7);
    r4 = __PKHBT(r4, r7, 16);
    r5 = __SSUB16(r5, r4);

    r4 = r0 & 0xFFFF1FFF;
    r7 = r1 & 0xFFFF7FFF;
    r4 = r4 << 3;
    r7 = r7 << 1;
    r4 = __SADD16(r4, r7);
    r0 = __SADD16(r0, r1);

    r1 = __SMLAWB(ir_qR2inv, r4, ir_2P15);
    r7 = __SMLAWT(ir_qR2inv, r4, ir_2P15);
    r1 = __SMULBT(ir_q, r1);
    r7 = __SMULBT(ir_q, r7);
    r1 = __PKHBT(r1, r7, 16);
    r4 = __SSUB16(r4, r1);

    r7 = r2 & 0xFFFF3FFF;
    r7 = r7 << 2;
    r7 = __SADD16(r7, r3);
    r2 = __SADD16(r2, r3);

    r4 = __SADD16(r4, r7);
    r1 = __SMLAWB(ir_qR2inv, r4, ir_2P15);
    r3 = __SMLAWT(ir_qR2inv, r4, ir_2P15);
    r1 = __SMULBT(ir_q, r1);
    r3 = __SMULBT(ir_q, r3);
    r1 = __PKHBT(r1, r3, 16);
    r4 = __SSUB16(r4, r1);

    r1 = __SSUB16(r0, r2);
    r0 = __SADD16(r0, r2);

    r2 = __SMLAWB(ir_qR2inv, r1, ir_2P15);
    r3 = __SMLAWT(ir_qR2inv, r1, ir_2P15);
    r2 = __SMULBT(ir_q, r2);
    r3 = __SMULBT(ir_q, r3);
    r2 = __PKHBT(r2, r3, 16);
    r1 = __SSUB16(r1, r2);

    r2 = __SMLAWB(ir_qR2inv, r0, ir_2P15);
    r3 = __SMLAWT(ir_qR2inv, r0, ir_2P15);
    r2 = __SMULBT(ir_q, r2);
    r3 = __SMULBT(ir_q, r3);
    r2 = __PKHBT(r2, r3, 16);
    r0 = __SSUB16(r0, r2);
    
    *(arrOut + 384) = r4;
    *(arrOut + 288) = r5;
    *(arrOut + 192) = r6;
    *(arrOut + 96) = r1;
    *(arrOut++) = r0;
  }

  arrIn = f;
  arrOut= f_eval;

  // #round halves if #reg 13 -> 14
  for (i = 0; i < 96; ++i) {
    r3 = *(arrIn + 288);
    r2 = *(arrIn + 96);
    r1 = *(arrIn + 192);
    r0 = *(arrIn++);

    r4 = r2 & 0xFFFF7FFF;
    r5 = r3 & 0xFFFF1FFF;
    r4 = r4 << 1;
    r5 = r5 << 3;
    r4 = __SADD16(r4, r5);

    r5 = r1 & 0xFFFF3FFF;
    r5 = r5 << 2;
    r5 = __SADD16(r0, r5);

    r6 = __SADD16(r5, r4);
    r5 = __SSUB16(r5, r4);

    r4 = r0 & 0xFFFF1FFF;
    r7 = r1 & 0xFFFF7FFF;
    r4 = r4 << 3;
    r7 = r7 << 1;
    r4 = __SADD16(r4, r7);
    r0 = __SADD16(r0, r1);

    r7 = r2 & 0xFFFF3FFF;
    r7 = r7 << 2;
    r7 = __SADD16(r7, r3);
    r2 = __SADD16(r2, r3);

    r4 = __SADD16(r4, r7);

    r1 = __SSUB16(r0, r2);
    r0 = __SADD16(r0, r2);
    
    *(arrOut + 384) = r4;
    *(arrOut + 288) = r5;
    *(arrOut + 192) = r6;
    *(arrOut + 96) = r1;
    *(arrOut++) = r0;
  }

  Karatsuba_mult(h, c, f);
  Karatsuba_mult(h_tmp, c_eval + 384, f_eval + 384);
  Karatsuba_mult(h + 384, c_eval, f_eval);
  Karatsuba_mult(h_tmp + 384, c_eval + 96,  f_eval + 96);
  Karatsuba_mult(h + 768, c_eval + 192,  f_eval + 192);
  Karatsuba_mult(h_tmp + 768, c_eval + 288,  f_eval + 288);
  Karatsuba_mult(h + 1152, c + 288, f + 288);

  h0 = h; h1 = h_tmp;
  for (i = 0; i < 383; ++i){
    ir6 = *(h0 + 1152);
    ir0 = *(h0++);
    ir1 = *h1;
    ir2 = *(h0 + 383);
    ir3 = *(h1 + 384);
    ir4 = *(h0 + 767);
    ir5 = *(h1 + 768);

    ir7 = 935519;
    ir8 = 4591;
    ir9 = __SMMULR(ir7, ir0);
    ir0 = __MLS(ir8, ir9, ir0);
    ir9 = __SMMULR(ir7, ir1);
    ir1 = __MLS(ir8, ir9, ir1);
    ir9 = __SMMULR(ir7, ir2);
    ir2 = __MLS(ir8, ir9, ir2);
    ir9 = __SMMULR(ir7, ir3);
    ir3 = __MLS(ir8, ir9, ir3);
    ir9 = __SMMULR(ir7, ir4);
    ir4 = __MLS(ir8, ir9, ir4);
    ir9 = __SMMULR(ir7, ir5);
    ir5 = __MLS(ir8, ir9, ir5);
    ir9 = __SMMULR(ir7, ir6);
    ir6 = __MLS(ir8, ir9, ir6);

    ir0 = __PKHBT(ir0, ir2, 16);
    ir3 = __PKHBT(ir3, ir4, 16);
    ir5 = __PKHBT(ir5, ir6, 16);

    ir2 = 0xFA05FFFE;
    ir4 = 0x05FBFB83;
    ir6 = 0xF70AF70B;
    ir7 = 0x02FD047C;
    ir8 = 0x05FA08F7;
    ir2 = __SMUAD(ir0, ir2);
    ir4 = __SMUAD(ir0, ir4);
    ir6 = __SMUAD(ir0, ir6);
    ir7 = __SMUAD(ir0, ir7);
    ir0 = __SMUAD(ir0, ir8);

    ir8 = 204;
    ir2 -= ir8 * ir1;
    ir8 = 255;
    ir6 += ir8 * ir1;
    ir8 = 51;
    ir0 -= ir8 * ir1;

    ir1 = 0x087803FC;
    ir8 = 0xFFFE08AB;
    ir9 = 0x053B05FB;
    ir10 = 0x0004053B;
    ir2 = __SMLAD(ir3, ir1, ir2);
    ir2 = __SMLAD(ir5, ir8, ir2);
    ir4 = __SMLAD(ir3, ir9, ir4);
    ir4 = __SMLAD(ir5, ir10, ir4);

    ir1 = 0x00FF06F9;
    ir8 = 0xF70B0000;
    ir9 = 0xFAC502FD;
    ir10 = 0xFFFBFAC5;
    ir6 = __SMLAD(ir3, ir1, ir6);
    ir6 = __SMLAD(ir5, ir8, ir6);
    ir7 = __SMLAD(ir3, ir9, ir7);
    ir7 = __SMLAD(ir5, ir10, ir7);

    ir1 = 0x0878FE02;
    ir8 = 0x08F7F755;
    ir0 = __SMLAD(ir3, ir1, ir0);
    ir0 = __SMLAD(ir5, ir8, ir0);

    *(h1++) = ir2;
    *(h0 + 383) = ir4;
    *(h1 + 383) = ir6;
    *(h0 + 767) = ir7;
    *(h1 + 767) = ir0;
  }

  h1 = h_tmp; h0 = h + 192;
  for (i = 0; i < 382; i += 2){
    ir0 = *(h1++);
    ir1 = *h0;
    ir2 = *(h1 + 383);
    ir3 = *(h0 + 384);
    ir4 = *(h1 + 767);
    ir5 = *(h0 + 768);
    ir6 = *(h1++);
    ir7 = *(h0 + 1);
    ir8 = *(h1 + 383);
    ir9 = *(h0 + 385);
    ir10 = *(h1 + 767);
    ir11 = *(h0 + 769);

    ir0 += ir1;
    ir6 += ir7;
    ir2 += ir3;
    ir8 += ir9;
    ir4 += ir5;
    ir10 += ir11;

    *(h0++) = ir0;
    *(h0 + 383) = ir2;
    *(h0 + 767) = ir4;
    *(h0++) = ir6;
    *(h0 + 383) = ir8;
    *(h0 + 767) = ir10;
  }
    ir0 = *(h1++);
    ir1 = *h0;
    ir2 = *(h1 + 383);
    ir3 = *(h0 + 384);
    ir4 = *(h1 + 767);
    ir5 = *(h0 + 768);

    ir0 += ir1;
    ir2 += ir3;
    ir4 += ir5;

    *(h0++) = ir0;
    *(h0 + 383) = ir2;
    *(h0 + 767) = ir4;
}
