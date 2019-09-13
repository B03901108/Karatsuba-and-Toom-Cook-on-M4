#include <stdio.h>
#include <stdint.h>

int32_t modq_freeze(int32_t numIn) {
  int32_t a = numIn;
  a -= 4591 * ((228 * a) >> 20);
  a -= 4591 * ((58470 * a + 134217728) >> 28);
  return a;
}

int32_t modq_squeeze(int32_t numIn) {
  int32_t a = (numIn * 7) + 0x4000;
  a = (a >> 15) * 4591;
  return numIn - a;
}

int main() {
  int32_t x, y, xM, xm, yM, ym;
  int32_t numIn, lwb, upb;;
  int32_t maxX = 0, minX = 0;
  int32_t maxY = 0, minY = 0;

  lwb = -18372 * 2295;
  upb = 18372 * 2295;
  printf("a helpful tool to label the scales in Toom4/Toom-k interpolation\n\n");
  printf("test from %d to %d\n", lwb, upb);
  for (numIn = lwb; numIn <= upb; ++numIn) {
    x = modq_freeze(numIn);
    if ((numIn - x) % 4591) printf("%d <- frz failure!\n", numIn);
    if (x > maxX) { maxX = x; xM = numIn; }
    if (x < minX) { minX = x; xm = numIn; }

    y = modq_squeeze(numIn);
    if ((numIn - y) % 4591) printf("%d <- squz failure!\n", numIn);
    if (y > maxY) { maxY = y; yM = numIn; }
    if (y < minY) { minY = y; ym = numIn; }
  }

  printf("maxX=%d from %d, minX=%d from %d\n", maxX, xM, minX, xm);
  printf("maxY=%d from %d, minY=%d from %d\n", maxY, yM, minY, ym);
  return 0;
}
