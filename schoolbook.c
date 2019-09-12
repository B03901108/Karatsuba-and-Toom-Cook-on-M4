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
    for (i = 0; i < len; ++i) {
      a = f[i];
      a -= 4591 * ((228 * a) >> 20);
      a -= 4591 * ((58470 * a + 134217728) >> 28);
      f[i] = a;
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
  if (len == LEN2) for (i = 0; i < (len << 1) - 1; ++i) {
  // if (((len == LEN2) || (len == LEN4)) || (len == LEN6)) for (i = 0; i < (len << 1) - 1; ++i) {
    a = h[i];
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    h[i] = a;
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

  for (i = 0; i < 192; ++i){
    a = c[i] + c2[i];
    b = c1[i] + c3[i];
    a = a + b; b = a - (b << 1);

    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    b -= 4591 * ((228 * b) >> 20);
    b -= 4591 * ((58470 * b + 134217728) >> 28);
    Cat1[i] = a; Cat_1[i] = b;
  }
  for (i = 0; i < 192; ++i){
    a = c[i] + (c2[i] << 2);
    b = (c1[i] << 1) + (c3[i] << 3);
    a = a + b; b = a - (b << 1);

    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    b -= 4591 * ((228 * b) >> 20);
    b -= 4591 * ((58470 * b + 134217728) >> 28);
    Cat10[i] = a; Cat_10[i] = b;
  }
  for (i = 0; i < 192; ++i){
    a = (c[i] << 3) + (c1[i] << 2) + (c2[i] << 1) + c3[i];
    
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    Cat01[i] = a;
  }

  for (i = 0; i < 192; ++i){
    a = f[i] + f2[i];
    b = f1[i] + f3[i];
    a = a + b; b = a - (b << 1);

    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    b -= 4591 * ((228 * b) >> 20);
    b -= 4591 * ((58470 * b + 134217728) >> 28);
    Fat1[i] = a; Fat_1[i] = b;
  }
  for (i = 0; i < 192; ++i){
    a = f[i] + (f2[i] << 2);
    b = (f1[i] << 1) + (f3[i] << 3);
    a = a + b; b = a - (b << 1);

    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    b -= 4591 * ((228 * b) >> 20);
    b -= 4591 * ((58470 * b + 134217728) >> 28);
    Fat10[i] = a; Fat_10[i] = b;
  }
  for (i = 0; i < 192; ++i){
    a = (f[i] << 3) + (f1[i] << 2) + (f2[i] << 1) + f3[i];
    
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    Fat01[i] = a;
  }

  Karatsuba_mult(h, c, f, 192, 1);
  Karatsuba_mult(h1, Cat01, Fat01, 192, 1);
  Karatsuba_mult(h2, Cat1, Fat1, 192, 1);
  Karatsuba_mult(h3, Cat_1, Fat_1, 192, 1);
  Karatsuba_mult(h4, Cat10, Fat10, 192, 1);
  Karatsuba_mult(h5, Cat_10, Fat_10, 192, 1);
  Karatsuba_mult(h6, c3, f3, 192, 1);

  for (i = 0; i < 383; ++i){
    a = h[i]; b = h1[i]; d = h2[i]; e = h3[i]; g = h4[i]; k = h5[i]; l = h6[i]; 

    // 4104x +/-2295 (+/-9418787) to avoid overflow during freeze
    // use squeeze due to the wide input range 116965x but not speed!!!
    b += g; // h: 4, h1: 8, h2: 4, h3: 4, h4: 4, h5: 4, h6: 4
    k = g - k; // h: 4, h1: 8, h2: 4, h3: 4, h4: 4, h5: 8, h6: 4
    e = (e - d) * 2295; // h: 4, h1: 8, h2: 4, h3: 18360, h4: 4, h5: 8, h6: 4
    g = ((g - a - (l << 6)) << 1) - k; // h: 4, h1: 8, h2: 4, h3: 18360, h4: 536, h5: 8, h6: 4
    d -= e; // h: 4, h1: 8, h2: 18364, h3: 18360, h4: 536, h5: 8, h6: 4
    d -= ((d * 7 + 0x4000) >> 15) * 4591; // h: 4, h1: 8, h2: 355, h3: 18360, h4: 536, h5: 8, h6: 4

    b -= ((d << 6) + d); // h: 4, h1: 23083, h2: 355, h3: 18360, h4: 536, h5: 8, h6: 4
    d -= (a + l); // h: 4, h1: 23083, h2: 363, h3: 18360, h4: 536, h5: 8, h6: 4
    b += d * 45; // h: 4, h1: 39418, h2: 363, h3: 18360, h4: 536, h5: 8, h6: 4
    g -= (d << 3); // h: 4, h1: 39418, h2: 363, h3: 18360, h4: 3440, h5: 8, h6: 4
    g -= 4591 * ((228 * g) >> 20);
    g -= 4591 * ((58470 * g + 134217728) >> 28); // h: 4, h1: 39418, h2: 363, h3: 18360, h4: 1, h5: 8, h6: 4
    g *= (-1339); // h: 4, h1: 39418, h2: 363, h3: 18360, h4: 1339, h5: 8, h6: 4

    k -= b; // h: 4, h1: 39418, h2: 363, h3: 18360, h4: 1339, h5: 39426, h6: 4
    e -= ((e * 7 + 0x4000) >> 15) * 4591; // h: 4, h1: 39418, h2: 363, h3: 355, h4: 1339, h5: 39426, h6: 4
    b -= (e << 4); // h: 4, h1: 45098, h2: 363, h3: 355, h4: 1339, h5: 39426, h6: 4

    b -= ((b * 7 + 0x4000) >> 15) * 4591; // h: 4, h1: 870, h2: 363, h3: 355, h4: 1339, h5: 39426, h6: 4
    b -= 4591 * ((228 * b) >> 20);
    b -= 4591 * ((58470 * b + 134217728) >> 28); // h: 4, h1: 1, h2: 363, h3: 355, h4: 1339, h5: 39426, h6: 4
    b -= (b << 8); // h: 4, h1: 255, h2: 363, h3: 355, h4: 1339, h5: 39426, h6: 4

    e -= b; // h: 4, h1: 255, h2: 363, h3: 610, h4: 1339, h5: 39426, h6: 4
    k += b * 30; // h: 4, h1: 255, h2: 363, h3: 610, h4: 1339, h5: 47076, h6: 4
    k -= ((k * 7 + 0x4000) >> 15) * 4591; // h: 4, h1: 255, h2: 363, h3: 610, h4: 1339, h5: 908, h6: 4
    k -= 4591 * ((228 * k) >> 20);
    k -= 4591 * ((58470 * k + 134217728) >> 28); // h: 4, h1: 255, h2: 363, h3: 610, h4: 1339, h5: 1, h6: 4
    k *= 2219; // h: 4, h1: 255, h2: 363, h3: 610, h4: 1339, h5: 2219, h6: 4
    b -= k; // h: 4, h1: 2474, h2: 363, h3: 610, h4: 1339, h5: 2219, h6: 4
    d -= g; // h: 4, h1: 2474, h2: 1702, h3: 610, h4: 1339, h5: 2219, h6: 4

    b -= 4591 * ((228 * b) >> 20);
    b -= 4591 * ((58470 * b + 134217728) >> 28);
    d -= 4591 * ((228 * d) >> 20);
    d -= 4591 * ((58470 * d + 134217728) >> 28);
    e -= 4591 * ((228 * e) >> 20);
    e -= 4591 * ((58470 * e + 134217728) >> 28);
    g -= 4591 * ((228 * g) >> 20);
    g -= 4591 * ((58470 * g + 134217728) >> 28);
    k -= 4591 * ((228 * k) >> 20);
    k -= 4591 * ((58470 * k + 134217728) >> 28);
    h1[i] = b; h2[i] = d; h3[i] = e; h4[i] = g; h5[i] = k;
  }
  h2 -= 192; h4 -= 192; h6 -= 192;
  for (i = 0; i < 383; ++i){
    h2[i] += h1[i];
    h4[i] += h3[i];
    h6[i] += h5[i];
  }
}

/* r2 += r5
r6 = r5 - r6
r4 = (r4 - r3) / (-2)
r5 = (r5 - r1 - r7 * 64) * 2 - r6
r3 -= r4
r2 -= r3 * 65
r3 -= (r1 + r7)
r2 += r3 * 45
r5 = (r5 - r3 * 8) / 24
r6 -= r2
r2 -= r4 * 16

r2 /= 18 (x -255)
r4 -= r2
r6 += r2 * 30
---
r6 /= 60 (x 2219)
r2 -= r6
r3 -= r5

r2 += r5
r6 -= r5
r4 -= r3
r5 -= r1
r5 -= r7 * 64
r4 /= 2
r3 += r4
r5 = r5 * 2 + r6
r2 -= r3 * 65
r4 *= -1
r6 *= -1
r3 -= r7
r3 -= r1
r2 += r3 * 45
r5 -= r3 * 8
r5 /= 24
r6 -= r2
r2 -= r4 * 16
turning point
r2 /= 18
r3 -= r5
r4 -= r2
r6 += r2 * 30
r6 /= 60
r2 -= r6 */

/* for (i = 0; i < 192; ++i){
    h1[i] += h4[i]; // h: 1, h1: 2, h2: 1, h3: 1, h4: 1, h5: 1, h6: 1
    h5[i] = h4[i] - h5[i]; // h: 1, h1: 2, h2: 1, h3: 1, h4: 1, h5: 2, h6: 1

    a = (h3[i] - h2[i]) * 2295;
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    h3[i] = a; // h: 1, h1: 2, h2: 1, h3: 1, h4: 1, h5: 2, h6: 1

    b = h4[i] - h[i] - (h6[i] << 6);
    b = (b << 1) - h5[i];
    b -= 4591 * ((228 * b) >> 20);
    b -= 4591 * ((58470 * b + 134217728) >> 28);
    h4[i] = b; // h: 1, h1: 2, h2: 1, h3: 1, h4: 1, h5: 2, h6: 1
    
    h2[i] -= a; // h: 1, h1: 2, h2: 2, h3: 1, h4: 1, h5: 2, h6: 1
    b = h2[i];
    a = b;
    a += (a << 6);
    a = h1[i] - a;
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    h1[i] = a; // h: 1, h1: 1, h2: 2, h3: 1, h4: 1, h5: 2, h6: 1

    b -= (h[i] + h6[i]);
    b -= 4591 * ((228 * b) >> 20);
    b -= 4591 * ((58470 * b + 134217728) >> 28);
    h2[i] = b; // h: 1, h1: 1, h2: 1, h3: 1, h4: 1, h5: 2, h6: 1

    a += b * 45;
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    h1[i] = a; // h: 1, h1: 1, h2: 1, h3: 1, h4: 1, h5: 2, h6: 1

    b = (h4[i] - (b << 3)) * 3252
    b -= 4591 * ((228 * b) >> 20);
    b -= 4591 * ((58470 * b + 134217728) >> 28);
    h4[i] = b; // h: 1, h1: 1, h2: 1, h3: 1, h4: 1, h5: 2, h6: 1

    h5[i] -= a; // h: 1, h1: 1, h2: 1, h3: 1, h4: 1, h5: 3, h6: 1
    a -= (h3[i] << 4)
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    h1[i] = a; // h: 1, h1: 1, h2: 1, h3: 1, h4: 1, h5: 3, h6: 1
    // TODO: turning point
} */
