#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "schoolbook.h"

void mock_mult(int16_t *h, const int16_t *c, const int16_t *f) {
  int i, j;
  int32_t a;

  for (i = 0; i < 768; ++i) {
  	a = 0;
    for (j = 0; j <= i; ++j) a += c[j] * f[i - j];
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    h[i] = a;
  }

  for (i = 768; i < 1535; ++i) {
  	a = 0;
    for (j = i - 767; j < 768; ++j) a += c[j] * f[i - j];
    a -= 4591 * ((228 * a) >> 20);
    a -= 4591 * ((58470 * a + 134217728) >> 28);
    h[i] = a;
  }
}

int main() {
  int i, j;
  int32_t a, counter;
  clock_t begin, end;
  int16_t h1[1535], h2[1535];
  int16_t c[768] = { 0 };
  int16_t f[768] = { 0 };

  srand(time(NULL));
for (counter = 0; counter < 1000; ++counter) {
  for (i = 0; i < 761; ++i) c[i] = (rand() % 1531) * 3 - 2295;
  for (i = 0; i < 761; ++i) f[i] = (rand() % 3) - 1;
//  for (i = 0; i < 760; ++i) printf("%d, ", c[i]);
//  printf("%d\n\n", c[760]);
//  for (i = 0; i < 760; ++i) printf("%d, ", f[i]);
//  printf("%d\n\n", f[760]);

  begin = clock();
  mock_mult(h1, c, f);
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
  printf("%ld\n", end - begin);
//  for (i = 0; i < 760; ++i) printf("%d, ", h1[i]);
//  printf("%d\n\n", h1[760]);

  begin = clock();
  Karatsuba_mult(h2, c, f, 768, 1);
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
  printf("%ld\n", end - begin);
//  for (i = 0; i < 760; ++i) printf("%d, ", h2[i]);
//  printf("%d\n\n", h2[760]);

  for (i = 0; i < 761; ++i) if (h1[i] != h2[i]) printf("%d: WRONG!!! => %d != %d\n", i, h1[i], h2[i]);
}

  return 0;
}
