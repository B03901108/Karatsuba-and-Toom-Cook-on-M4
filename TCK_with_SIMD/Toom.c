#include "Toom.h"

// Toom3 specialized for 768x768
// TODO: fewer tmp var
void Toom3_mult(int16_t *h, int16_t *c, int16_t *f) {
  int16_t i;
  int32_t a, b, d, e, g;
  int16_t * c1 = c + 256, * c2 = c1 + 256;
  int16_t * f1 = f + 256, * f2 = f1 + 256;
  int16_t Cat1[256], Cat_1[256], Cat10[256];
  int16_t Fat1[256], Fat_1[256], Fat10[256];
  int16_t * h2 = h + 512, * h4 = h2 + 512; 
  int16_t h1[511], h3[511];

  for (i = 0; i < 256; ++i){
    a = c[i] + c2[i];
    b = c1[i];
    a = a + b; b = a - (b << 1);

    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    b -= 4591 * ((228 * b) >> 20);
    b -= 4591 * ((58470 * b + 134217728) >> 28);
    Cat1[i] = a; Cat_1[i] = b;
  }
  for (i = 0; i < 256; ++i){
    a = c[i] + (c1[i] << 1) + (c2[i] << 2);

    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    Cat10[i] = a;
  }

  for (i = 0; i < 256; ++i){
    a = f[i] + f2[i];
    b = f1[i];
    a = a + b; b = a - (b << 1);

    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    b -= 4591 * ((228 * b) >> 20);
    b -= 4591 * ((58470 * b + 134217728) >> 28);
    Fat1[i] = a; Fat_1[i] = b;
  }
  for (i = 0; i < 256; ++i){
    a = f[i] + (f1[i] << 1) + (f2[i] << 2);

    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    Fat10[i] = a;
  }

  Karatsuba_mult(h, c, f, 256, 1);
  Karatsuba_mult(h1, Cat_1, Fat_1, 256, 1);
  Karatsuba_mult(h2, Cat1, Fat1, 256, 1);
  Karatsuba_mult(h3, Cat10, Fat10, 256, 1);
  Karatsuba_mult(h4, c2, f2, 256, 1);

  for (i = 0; i < 511; ++i){
    a = h[i]; b = h1[i]; d = h2[i]; e = h3[i]; g = h4[i];

    // 4104x +/-2295 (+/-9418787) to avoid overflow during freeze
    // use squeeze due to the wide input range 116965x but not speed!!!
    e -= b; // h: 4, h1: 4, h2: 4, h3: 8, h4: 4
    b = d - b; // h: 4, h1: 8, h2: 4, h3: 8, h4: 4
    b = (b + ((-(b & 1)) & 4591)) >> 1; // h: 4, h1: 5, h2: 4, h3: 8, h4: 4
    d -= a;  // h: 4, h1: 5, h2: 8, h3: 8, h4: 4
    e = ((d << 1) + d - e) * 765; // h: 4, h1: 5, h2: 8, h3: 24480, h4: 4
    d -= (b + g); // h: 4, h1: 5, h2: 17, h3: 24480, h4: 4
    e -= (g << 1); // h: 4, h1: 5, h2: 17, h3: 24488, h4: 4
    e -= ((e * 7 + 0x4000) >> 15) * 4591; // h: 4, h1: 5, h2: 17, h3: 473, h4: 4
    b -= e; // h: 4, h1: 478, h2: 17, h3: 473, h4: 4

    b -= 4591 * ((228 * b) >> 20);
    b -= 4591 * ((58470 * b + 134217728) >> 28);
    d -= 4591 * ((228 * d) >> 20);
    d -= 4591 * ((58470 * d + 134217728) >> 28);
    e -= 4591 * ((228 * e) >> 20);
    e -= 4591 * ((58470 * e + 134217728) >> 28); // h: 4, h1: 1, h2: 1, h3: 1, h4: 4
    h1[i] = b; h2[i] = d; h3[i] = e;
  }
  h2 -= 256; h4 -= 256;
  for (i = 0; i < 511; ++i){
    h2[i] += h1[i];
    h4[i] += h3[i];
  }
}

// specialized for 768x768
void Toom4_mult(int32_t *h, uint32_t *c, uint32_t *f) {
  int i;
  int32_t a, b, d, e, g, k, l, tmp1, tmp2, tmp3, tmp4, tmp5;

  uint32_t *arrIn0, *arrIn1, *arrIn2, *arrIn3, *arrOutPlus, *arrOutMinus;
  uint32_t Cat1[96], Cat_1[96], Cat10[96], Cat_10[96], Cat01[96];
  uint32_t Fat1[96], Fat_1[96], Fat10[96], Fat_10[96], Fat01[96];
  int32_t *h0, *h1, *h2, *h3, *h4, *h5, *h6;
  int32_t h1_tmp[384], h3_tmp[384], h5_tmp[384];

  arrIn0 = c; arrIn1 = arrIn0 + 96; arrIn2 = arrIn1 + 96; arrIn3 = arrIn2 + 96;
  arrOutPlus = Cat1; arrOutMinus = Cat_1;
  for (i = 0; i < 96; ++i){
    a = *(arrIn0++);
    b = *(arrIn2++);
    d = *(arrIn1++);
    e = *(arrIn3++);
    a = __SADD16(a, b);
    b = __SADD16(d, e);

    d = __SADD16(a, b);
    e = __SSUB16(a, b);
    a = barrett_16x2(d);
    b = barrett_16x2(e);
    *(arrOutPlus++) = a;
    *(arrOutMinus++) = b;
  }

  arrIn0 -= 96; arrIn1 -= 96; arrIn2 -= 96; arrIn3 -= 96;
  arrOutPlus = Cat10; arrOutMinus = Cat_10;
  for (i = 0; i < 96; ++i){
    a = *(arrIn0++);
    b = *(arrIn2++);
    d = *(arrIn1++);
    e = *(arrIn3++);
    b = b & 0xFFFF3FFF;
    d = d & 0xFFFF7FFF;
    e = e & 0xFFFF1FFF;
    b = b << 2;
    d = d << 1;
    e = e << 3;
    a = __SADD16(a, b);
    b = __SADD16(d, e);
    e = barrett_16x2(b);

    d = __SADD16(a, e);
    b = __SSUB16(a, e);
    a = barrett_16x2(d);
    e = barrett_16x2(b);
    *(arrOutPlus++) = a;
    *(arrOutMinus++) = e;
  }

  arrIn0 -= 96; arrIn1 -= 96; arrIn2 -= 96; arrIn3 -= 96;
  arrOutPlus = Cat01;
  for (i = 0; i < 96; ++i){
    a = *(arrIn0++);
    b = *(arrIn2++);
    d = *(arrIn1++);
    e = *(arrIn3++);
    a = a & 0xFFFF1FFF;
    b = b & 0xFFFF7FFF;
    d = d & 0xFFFF3FFF;
    a = a << 3;
    b = b << 1;
    d = d << 2;
    a = __SADD16(a, b);
    b = __SADD16(d, e);
    d = barrett_16x2(a);

    e = __SADD16(d, b);
    a = barrett_16x2(e);
    *(arrOutPlus++) = a;
  }

  arrIn0 = f; arrIn1 = arrIn0 + 96; arrIn2 = arrIn1 + 96; arrIn3 = arrIn2 + 96;
  arrOutPlus = Fat1; arrOutMinus = Fat_1;
  for (i = 0; i < 96; ++i){
    a = *(arrIn0++);
    b = *(arrIn2++);
    d = *(arrIn1++);
    e = *(arrIn3++);
    a = __SADD16(a, b);
    b = __SADD16(d, e);

    d = __SADD16(a, b);
    e = __SSUB16(a, b);
    *(arrOutPlus++) = d;
    *(arrOutMinus++) = e;
  }

  arrIn0 -= 96; arrIn1 -= 96; arrIn2 -= 96; arrIn3 -= 96;
  arrOutPlus = Fat10; arrOutMinus = Fat_10;
  for (i = 0; i < 96; ++i){
    a = *(arrIn0++);
    b = *(arrIn2++);
    d = *(arrIn1++);
    e = *(arrIn3++);
    b = b & 0xFFFF3FFF;
    d = d & 0xFFFF7FFF;
    e = e & 0xFFFF1FFF;
    b = b << 2;
    d = d << 1;
    e = e << 3;
    a = __SADD16(a, b);
    b = __SADD16(d, e);

    d = __SADD16(a, b);
    e = __SSUB16(a, b);
    *(arrOutPlus++) = d;
    *(arrOutMinus++) = e;
  }

  arrIn0 -= 96; arrIn1 -= 96; arrIn2 -= 96; arrIn3 -= 96;
  arrOutPlus = Fat01;
  for (i = 0; i < 96; ++i){
    a = *(arrIn0++);
    b = *(arrIn2++);
    d = *(arrIn1++);
    e = *(arrIn3++);
    a = a & 0xFFFF1FFF;
    b = b & 0xFFFF7FFF;
    d = d & 0xFFFF3FFF;
    a = a << 3;
    b = b << 1;
    d = d << 2;
    a = __SADD16(a, b);
    b = __SADD16(d, e);

    d = __SADD16(a, b);
    *(arrOutPlus++) = d;
  }

  h0 = h; h1 = h1_tmp; h2 = h0 + 384; h3 = h3_tmp; h4 = h2 + 384; h5 = h5_tmp; h6 = h4 + 384;
  iter_Karatsuba_mult(h0, c, f);
  iter_Karatsuba_mult(h1_tmp, Cat01, Fat01);
  iter_Karatsuba_mult(h2, Cat1, Fat1);
  iter_Karatsuba_mult(h3_tmp, Cat_1, Fat_1);
  iter_Karatsuba_mult(h4, Cat10, Fat10);
  iter_Karatsuba_mult(h5_tmp, Cat_10, Fat_10);
  iter_Karatsuba_mult(h6, (c + 288), (f + 288));

  /*    1     0     0     0     0     0     0
     -2  -204 -1531  1020  2168  2219    -2
  -1149     0  1531  1531  1339  1339     4
  -2293   255 -2294  1785   255     0 -2293
   1148     0   765   765 -1339 -1339    -5
   2295   -51  1530  -510  2168 -2219  2295
      0     0     0     0     0     0     1 */
  for (i = 0; i < 383; ++i){
    a = *(h0++);
    b = *h1;
    d = *h2;
    e = *h3;
    g = *h4;
    k = *h5;
    l = *(h6++);
    a = barrett_32(a);
    b = barrett_32(b);
    d = barrett_32(d);
    e = barrett_32(e);
    g = barrett_32(g);
    k = barrett_32(k);
    l = barrett_32(l);
    a = __PKHBT(a, d, 16);
    e = __PKHBT(e, g, 16);
    k = __PKHBT(k, l, 16);

    d = (-204) * b;
    d = __SMLAD(a, 0xFA05FFFE, d);
    d = __SMLAD(e, 0x087803FC, d);
    d = __SMLAD(k, 0xFFFE08AB, d);
    
    g = __SMUAD(a, 0x05FBFB83);
    g = __SMLAD(e, 0x053B05FB, g);
    g = __SMLAD(k, 0x0004053B, g);
    
    l = (255) * b;
    l = __SMLAD(a, 0xF70AF70B, l);
    l = __SMLAD(e, 0x00FF06F9, l);
    l = __SMLAD(k, 0xF70B0000, l);

    tmp1 = __SMUAD(a, 0x02FD047C);
    tmp1 = __SMLAD(e, 0xFAC502FD, tmp1);
    tmp1 = __SMLAD(k, 0xFFFBFAC5, tmp1);

    tmp2 = (-51) * b;
    tmp2 = __SMLAD(a, 0x05FA08F7, tmp2);
    tmp2 = __SMLAD(e, 0x0878FE02, tmp2);
    tmp2 = __SMLAD(k, 0x08F7F755, tmp2);

    *(h1++) = d;
    *(h2++) = g;
    *(h3++) = l;
    *(h4++) = tmp1;
    *(h5++) = tmp2;

    /* b += g; // h: 4, h1: 8, h2: 4, h3: 4, h4: 4, h5: 4, h6: 4
    k = g - k; // h: 4, h1: 8, h2: 4, h3: 4, h4: 4, h5: 8, h6: 4

    e = (d - e); // h: 4, h1: 8, h2: 4, h3: 8, h4: 4, h5: 8, h6: 4
    e = (e + (4591 & (-(e & 1)))) >> 1; // h: 4, h1: 8, h2: 4, h3: 5, h4: 4, h5: 8, h6: 4
    // e = (e - d) * 2295;

    g = ((g - a - (l << 6)) << 1) - k; // h: 4, h1: 8, h2: 4, h3: 5, h4: 536, h5: 8, h6: 4
    d -= e; // h: 4, h1: 8, h2: 9, h3: 5, h4: 536, h5: 8, h6: 4

    b -= ((d << 6) + d); // h: 4, h1: 593, h2: 9, h3: 5, h4: 536, h5: 8, h6: 4
    d -= (a + l); // h: 4, h1: 593, h2: 17, h3: 5, h4: 536, h5: 8, h6: 4
    b += d * 45; // h: 4, h1: 1358, h2: 17, h3: 5, h4: 536, h5: 8, h6: 4
    g -= (d << 3); // h: 4, h1: 1358, h2: 17, h3: 5, h4: 672, h5: 8, h6: 4
    g *= (-1339); // h: 4, h1: 1358, h2: 17, h3: 5, h4: 899808, h5: 8, h6: 4

    k -= b; // h: 4, h1: 1358, h2: 17, h3: 5, h4: 899808, h5: 1366, h6: 4
    b -= (e << 4); // h: 4, h1: 1438, h2: 17, h3: 5, h4: 899808, h5: 1366, h6: 4

    b -= (b << 8); // h: 4, h1: 366690, h2: 17, h3: 5, h4: 899808, h5: 1366, h6: 4
    b = barrett_32(b); // h: 4, h1: 1, h2: 17, h3: 5, h4: 899808, h5: 1366, h6: 4

    h3[i] = e - b; // h: 4, h1: 1, h2: 17, h3: 6, h4: 899808, h5: 1366, h6: 4
    k += b * 30; // h: 4, h1: 1, h2: 17, h3: 6, h4: 899808, h5: 1396, h6: 4
    k = (k + (4591 & (-(k & 1)))) >> 1; // h: 4, h1: 1, h2: 17, h3: 6, h4: 899808, h5: 799, h6: 4
    k *= (-153); // h: 4, h1: 1, h2: 17, h3: 6, h4: 899808, h5: 122247, h6: 4
    b -= k; // h: 4, h1: 122248, h2: 17, h3: 6, h4: 899808, h5: 122247, h6: 4
    d -= g; // h: 4, h1: 122248, h2: 899825, h3: 6, h4: 899808, h5: 122247, h6: 4

    h1[i] = barrett_32(b);
    h2[i] = barrett_32(d);
    h4[i] = barrett_32(g);
    h5[i] = barrett_32(k); */
  }

  h1 -= 383; h3 -= 383; h5 -= 383;
  h2 -= 575; h4 -= 575; h6 -= 575;
  for (i = 0; i < 382; i += 2){
    a = *(h1++);
    l = *(h1++);
    b = *h2;
    tmp1 = *(h2 + 1);

    d = *(h3++);
    tmp2 = *(h3++);
    e = *h4;
    tmp3 = *(h4 + 1);

    g = *(h5++);
    tmp4 = *(h5++);
    k = *h6;
    tmp5 = *(h6 + 1);

    b = a + b;
    tmp1 = l + tmp1;
    e = d + e;
    tmp3 = tmp2 + tmp3;
    k = g + k;
    tmp5 = tmp4 + tmp5;

    *(h2++) = b;
    *(h2++) = tmp1;
    *(h4++) = e;
    *(h4++) = tmp3;
    *(h6++) = k;
    *(h6++) = tmp5;
  }
    a = *(h1++);
    b = *h2;
    d = *(h3++);
    e = *h4;
    g = *(h5++);
    k = *h6;

    b = a + b;
    e = d + e;
    k = g + k;

    *(h2++) = b;
    *(h4++) = e;
    *(h6++) = k;
}
