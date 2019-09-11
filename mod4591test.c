#include <stdio.h>
#include <stdint.h>
#include <time.h>

int16_t modq_freeze(int16_t numIn) {
  int32_t a = numIn;
  a -= 4591 * ((228 * a) >> 20);
  a -= 4591 * ((58470 * a + 134217728) >> 28);
  return a;
}

int16_t modq_squeeze(int16_t numIn) {
  int32_t a = (numIn * 7) + 0x4000;
  a = (a >> 15) * 4591;
  return numIn - a;
}

int main() {
  int16_t x, y;
  int16_t numIn;
  clock_t start, end;

  // scanf("%d", &numIn);
  for (numIn = -32767; numIn < 32767; ++numIn) {
    x = modq_freeze(numIn);
    y = modq_squeeze(numIn);
    /* if (((x != y) && (x != y + 4591)) && (x != y - 4591))
      printf("numIn=%d: %d vs. %d\n", numIn, x, y); */
    if (x != y) printf("numIn=%d: %d vs. %d\n", numIn, x, y);
    //  printf("numIn=%d: %d vs. %d\n", numIn, x, y);
  }

  start = clock();
  for (numIn = -32767; numIn < 32767; ++numIn) x = modq_freeze(numIn);
  end = clock();
  printf("time to FREEZE= %lu\n", start - end);

  start = clock();
  for (numIn = -32767; numIn < 32767; ++numIn) y = modq_squeeze(numIn);
  end = clock();
  printf("time to SQUEEZE=%lu\n", start - end);

  printf("\nTo my surprise, FREEZE faster than SQUEEZE (Barrett reduction).\n");
  printf("Up to now, the superiority of FREEZE over SQUEEZE is unpredictable/unclear on Cortex-M4, even at assembly level.\n\n");
  return 0;
}
