#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "schoolbook.h"

void mock_mult(int16_t *h, const int16_t *c, const int16_t *f, const int16_t len) {
  int i, j;
  int32_t a;

  for (i = 0; i < len; ++i) {
  	a = 0;
    for (j = 0; j <= i; ++j) a += c[j] * f[i - j];
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    h[i] = a;
  }

  for (; i < len * 2 - 1; ++i) {
  	a = 0;
    for (j = i - len + 1; j < len; ++j) a += c[j] * f[i - j];
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    h[i] = a;
  }
}

void mock_Karatsuba_mult(int16_t *h, int16_t *c, int16_t *f, const int16_t len, int8_t inputScale) {
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

  if (sublen > 24) {
    mock_Karatsuba_mult(h, c, f, sublen, inputScale);
    mock_Karatsuba_mult(h + len, c + sublen, f + sublen, sublen, inputScale);
    mock_Karatsuba_mult(cSfS, cS, fS, sublen, inputScale << 1);
  } else {
    mock_mult(h, c, f, 24);
    mock_mult(h + len, c + sublen, f + sublen, 24);
    mock_mult(cSfS, cS, fS, 24);
  }
  for (i = sublen, j = len; i < len - 1; ++i, ++j) h[i] -= h[j];
  for (; j < (len << 1) - 1; ++i, ++j) h[i] = -h[j];
  for (i = len + sublen - 2, j = i - sublen; j >= 0; --i, --j) h[i] -= h[j];
  for (i = sublen, j = 0; j < len - 1; ++i, ++j) h[i] += cSfS[j];

  // h may crash! (worst-case middle terms: its scale follows a recursive relation)
  if ((len == 96) || (len == 384)) for (i = 0; i < (len << 1) - 1; ++i) {
  // if (((len == LEN2) || (len == LEN4)) || (len == LEN6)) for (i = 0; i < (len << 1) - 1; ++i) {
    a = h[i];
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    h[i] = a;
  }
}

int main() {
  int i, j;
  int32_t a, counter;
  clock_t begin, end;
  int16_t h1[1535], h2[1535], h3[1535];
  int16_t c[768] = { 0 };
  int16_t f[768] = { 0 };

  srand(time(NULL));
for (counter = 0; counter < 1000; ++counter) {
  for (i = 0; i < 761; ++i) c[i] = (rand() % 1531) * 3 - 2295;
  for (i = 0; i < 761; ++i) f[i] = (rand() % 3) - 1;
  for (i = 0; i < 1535; ++i) h1[i] = h2[i] = h3[i] = 0;
//  for (i = 0; i < 760; ++i) printf("%d, ", c[i]);
//  printf("%d\n\n", c[760]);
//  for (i = 0; i < 760; ++i) printf("%d, ", f[i]);
//  printf("%d\n\n", f[760]);

  /* for (i = 0; i < 191; ++i) printf("%d, ", c[i]);
  printf("%d\n\n", c[191]);
  for (i = 0; i < 191; ++i) printf("%d, ", f[i]);
  printf("%d\n\n", f[191]);
  
  mock_mult(h1, c, f, 192);
  recur_Karatsuba_mult(h2, c, f, 192, 1);
  iter_Karatsuba_mult(h3, c, f);
  printf("schoolbook rslt\n");
  for (i = 0; i < 383; ++i) printf("%d, ", h1[i]);
  printf("%d\n\n", h1[383]);
  printf("iter Karatsuba rslt\n");
  for (i = 0; i < 383; ++i) printf("%d, ", h2[i]);
  printf("%d\n\n", h2[383]);
  printf("recur Karatsuba rslt\n");
  for (i = 0; i < 383; ++i) printf("%d, ", h3[i]);
  printf("%d\n\n", h3[383]); */

  begin = clock();
  mock_mult(h1, c, f, 768);
  for (i = 1520; i >= 761; --i) {
    h1[i - 761] += h1[i];
    h1[i - 760] += h1[i];
  }
  for (i = 0; i < 761; ++i) {
    a = h1[i];
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    h1[i] = a;
  }
  end = clock();
  printf("schoolbook: %ld, ", end - begin);

  begin = clock();
  Toom4_mult(h2, c, f);
  for (i = 1520; i >= 761; --i) {
    h2[i - 761] += h2[i];
    h2[i - 760] += h2[i];
  }
  for (i = 0; i < 761; ++i) {
    a = h2[i];
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    h2[i] = a;
  }
  end = clock();
  printf("Toom-4: %ld, ", end - begin);

  begin = clock();
  mock_Karatsuba_mult(h3, c, f, 768, 1);
  for (i = 1520; i >= 761; --i) {
    h3[i - 761] += h3[i];
    h3[i - 760] += h3[i];
  }
  for (i = 0; i < 761; ++i) {
    a = h3[i];
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    h3[i] = a;
  }
  end = clock();
  printf("Karatsuba: %ld\n", end - begin);

//  for (i = 0; i < 760; ++i) printf("%d, ", h1[i]);
//  printf("%d\n\n", h1[760]);
//  for (i = 0; i < 760; ++i) printf("%d, ", h2[i]);
//  printf("%d\n\n", h2[760]);
//  for (i = 0; i < 760; ++i) printf("%d, ", h3[i]);
//  printf("%d\n\n", h3[760]);
  for (i = 0; i < 761; ++i) if (h1[i] != h2[i]) printf("h1 vs. h2 -- %d: WRONG!!! => %d != %d\n", i, h1[i], h2[i]);
  for (i = 0; i < 761; ++i) if (h1[i] != h3[i]) printf("h1 vs. h3 -- %d: WRONG!!! => %d != %d\n", i, h1[i], h3[i]);
  for (i = 0; i < 761; ++i) if (h2[i] != h3[i]) printf("h2 vs. h3 -- %d: WRONG!!! => %d != %d\n", i, h2[i], h3[i]);
}

  return 0;
}
