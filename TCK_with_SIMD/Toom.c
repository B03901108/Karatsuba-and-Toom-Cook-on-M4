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
void Toom4_mult(int16_t *h, int16_t *c, int16_t *f) {
  int16_t i;
  int32_t a, b, d, e, g, k, l;
  int16_t * c1 = c + 192, * c2 = c1 + 192, * c3 = c2 + 192;
  int16_t * f1 = f + 192, * f2 = f1 + 192, * f3 = f2 + 192;
  int16_t Cat1[192], Cat_1[192], Cat10[192], Cat_10[192], Cat01[192];
  int16_t Fat1[192], Fat_1[192], Fat10[192], Fat_10[192], Fat01[192];
  int16_t * h2 = h + 384, * h4 = h2 + 384, * h6 = h4 + 384; 
  int16_t h1[383], h3[383], h5[383];

  for (i = 0; i < 192; i += 2){
    a = __SADD16(*(uint32_t *)(c + i), *(uint32_t *)(c2 + i));
    b = __SADD16(*(uint32_t *)(c1 + i), *(uint32_t *)(c3 + i));
    d = __SADD16(a, b); e = __SSUB16(a, b);

    a = barrett_16x2(d);
    b = barrett_16x2(e);
    (*(uint32_t *)(Cat1 + i)) = a; (*(uint32_t *)(Cat_1 + i)) = b;
  }
  for (i = 0; i < 192; ++i){
    a = c[i] + (c2[i] << 2);
    b = (c1[i] << 1) + (c3[i] << 3);
    d = a + b; e = a - b;

    a = barrett_32(d);
    b = barrett_32(e);
    Cat10[i] = a; Cat_10[i] = b;
  }
  for (i = 0; i < 192; ++i){
    a = (c[i] << 3) + (c1[i] << 2) + (c2[i] << 1) + c3[i];
    
    d = barrett_32(a);
    Cat01[i] = d;
  }

  for (i = 0; i < 192; i += 2){
    a = __SADD16(*(uint32_t *)(f + i), *(uint32_t *)(f2 + i));
    b = __SADD16(*(uint32_t *)(f1 + i), *(uint32_t *)(f3 + i));
    d = __SADD16(a, b); e = __SSUB16(a, b);
    (*(uint32_t *)(Fat1 + i)) = d; (*(uint32_t *)(Fat_1 + i)) = e;
  }
  for (i = 0; i < 192; i += 2){
    d = f1[i] << 1;
    *(((int16_t *)(&d)) + 1) = f1[i + 1] << 1;
    e = f2[i] << 2;
    *(((int16_t *)(&e)) + 1) = f2[i + 1] << 2;
    g = f3[i] << 3;
    *(((int16_t *)(&g)) + 1) = f3[i + 1] << 3;

    a = __SADD16(*(uint32_t *)(f + i), e);
    b = __SADD16(d, g);
    d = __SADD16(a, b); e = __SSUB16(a, b);
    (*(uint32_t *)(Fat10 + i)) = d; (*(uint32_t *)(Fat_10 + i)) = e;
  }
  for (i = 0; i < 192; ++i){
    a = (f[i] << 3) + (f1[i] << 2) + (f2[i] << 1) + f3[i];
    Fat01[i] = a;
  }

  /* Karatsuba_mult(h, c, f, 192, 1);
  Karatsuba_mult(h1, Cat01, Fat01, 192, 1);
  Karatsuba_mult(h2, Cat1, Fat1, 192, 1);
  Karatsuba_mult(h3, Cat_1, Fat_1, 192, 1);
  Karatsuba_mult(h4, Cat10, Fat10, 192, 1);
  Karatsuba_mult(h5, Cat_10, Fat_10, 192, 1);
  Karatsuba_mult(h6, c3, f3, 192, 1); */
  iter_Karatsuba_mult(h, c, f);
  iter_Karatsuba_mult(h1, Cat01, Fat01);
  iter_Karatsuba_mult(h2, Cat1, Fat1);
  iter_Karatsuba_mult(h3, Cat_1, Fat_1);
  iter_Karatsuba_mult(h4, Cat10, Fat10);
  iter_Karatsuba_mult(h5, Cat_10, Fat_10);
  iter_Karatsuba_mult(h6, c3, f3);

  for (i = 0; i < 383; ++i){
    a = h[i]; b = h1[i]; d = h2[i]; e = h3[i]; g = h4[i]; k = h5[i]; l = h6[i];

    // 4104x +/-2295 (+/-9418787) to avoid overflow during freeze
    // use squeeze due to the wide input range 116965x but not speed!!!
    b += g; // h: 4, h1: 8, h2: 4, h3: 4, h4: 4, h5: 4, h6: 4
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
    h5[i] = barrett_32(k);
  }
  h2 -= 192; h4 -= 192; h6 -= 192;
  for (i = 0; i < 382; i += 2){
    (*(uint32_t *)(h2 + i)) = __SADD16(*(uint32_t *)(h1 + i), *(uint32_t *)(h2 + i));
    // To use SIMD in mod P(x)
    // (*(uint32_t *)(h4 + i)) = barrett_16x2(__SADD16(*(uint32_t *)(h3 + i), *(uint32_t *)(h4 + i)));
    (*(uint32_t *)(h4 + i)) = __SADD16(*(uint32_t *)(h3 + i), *(uint32_t *)(h4 + i));
    (*(uint32_t *)(h6 + i)) = __SADD16(*(uint32_t *)(h5 + i), *(uint32_t *)(h6 + i));
  }
  h2[382] += h1[382];
  // h4[382] = barrett_16x2(h4[382] + h3[382]);
  h4[382] = h4[382] + h3[382];
  h6[382] += h5[382];
}
