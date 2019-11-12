#include "schoolbook.h"

void ref_schoolbook_mult(int16_t *h, const int16_t *c, const int16_t *f) {
  int32_t result;
  int i, j, j2;

  for (i = 0; i < 761; ++i) {
    result = 0;
    for (j = 0; j <= i; ++j) result += c[j] * f[i - j];
    h[i] = modq_freeze(result);
  }
  for (i = 761; i < 1521; ++i) {
    result = 0;
    for (j = i - 760; j < 761; ++j) result += c[j] * f[i - j];
    h[i] = modq_freeze(result);
  }

  j2 = h[761];
  result = h[0] + j2;
  h[0] = modq_freeze(result);
  result = h[760] + h[1520];
  h[760] = modq_freeze(result);
  for (i = 1; i < 760; ++i) {
    j = j2; j2 = h[i + 761];
    result = h[i] +j + j2;
    h[i] = modq_freeze(result);
  }
}

void schoolbook_mult(int16_t *h, const int16_t *c, const int16_t *f) {
  int i, j;
  int32_t a;

  for (i = 0; i < UNITLEN; ++i) {
    j = 1 - (i & 1);
    a = (j) ? (c[0] * f[i]) : (0);
    for (; j <= i; j += 2)
      a = __SMLADX((*(uint32_t *)(c + j)), (*(uint32_t *)(f + i - j - 1)), a);
    h[i] = barrett_32(a);
  }
  for (; i < (UNITLEN << 1) - 1; ++i) {
    j = 1 - (i & 1);
    a = (j) ? (c[i - UNITLEN + 1] * f[UNITLEN - 1]) : (0);
    for (j += i - UNITLEN + 1; j < UNITLEN; j += 2)
      a = __SMLADX((*(uint32_t *)(c + j)), (*(uint32_t *)(f + i - j - 1)), a);
    h[i] = barrett_32(a);
  }

  h[i] = 0;
}

// $len assumed 4x
void smlal_mult(int16_t *h, const int16_t *c, const int16_t *f, const int16_t len) {
  int i, j, k, j_begin, j_end;
  int16_t sublen = len >> 1;
  uint32_t c_dual[sublen], f_dual[sublen];
  uint32_t op1c, op1f, op2c, op2f;
  uint32_t upper1, lower1, upper2, lower2, upper3, lower3;
  int32_t product1 = 0, product2 = 0, product3 = 0, product4, product5, product6, product7, product_tmp;

  for (i = 0, j = 0; i < sublen; ++i, j += 2) {
    c_dual[i] = c[j] + (c[j + 1] << 19);
    f_dual[i] = f[j] + (f[j + 1] << 19);
  }

  for (i = 0; i < len - 2; i += 2) {
    if (i < sublen) { j_begin = 0; j_end = i + 1; }
    else { j_begin = i - sublen + 2; j_end = sublen; }
    upper1 = 0, lower1 = 0, upper2 = 0, lower2 = 0, upper3 = 0, lower3 = 0;
    product4 = 0, product5 = 0, product6 = 0, product7 = 0;

    for (j = j_begin, k = 0; j < j_end; j += 2, ++k) {
      op1c = c_dual[j]; op2c = c_dual[j + 1]; op1f = f_dual[i - j]; op2f = f_dual[i - j + 1];
      __asm__ volatile (
        "smlal %0, %1, %6, %7 \n\t"
        "smlal %2, %3, %7, %8 \n\t"
        "smlal %2, %3, %6, %9 \n\t"
        "smlal %4, %5, %8, %9"
        : "=r" (lower1), "=r" (upper1), "=r" (lower2), "=r" (upper2), "=r" (lower3), "=r" (upper3)
        : "r" (op1c), "r" (op1f), "r" (op2c), "r" (op2f), "0" (lower1), "1" (upper1), "2" (lower2), "3" (upper2), "4" (lower3), "5" (upper3)
        : "cc" );

      if (k == 56) {
        product_tmp = sxt19(lower1);
        product1 += product_tmp;
        product2 += sxt19((upper1 << 13) + (((uint32_t) lower1) >> 19) - (product_tmp >> 19));
        product3 += ((int32_t)(upper1 - sxt6(upper1))) >> 6;

        product_tmp = sxt19(lower2);
        product3 += product_tmp;
        product4 += sxt19((upper2 << 13) + (((uint32_t) lower2) >> 19) - (product_tmp >> 19));
        product5 += ((int32_t)(upper2 - sxt6(upper2))) >> 6;

        product_tmp = sxt19(lower3);
        product5 += product_tmp;
        product6 += sxt19((upper3 << 13) + (((uint32_t) lower3) >> 19) - (product_tmp >> 19));
        product7 += ((int32_t)(upper3 - sxt6(upper3))) >> 6;

        upper1 = 0, lower1 = 0, upper2 = 0, lower2 = 0, upper3 = 0, lower3 = 0;
      } else if (k == 28) {
        product_tmp = sxt19(lower2);
        product3 += product_tmp;
        product4 += sxt19((upper2 << 13) + (((uint32_t) lower2) >> 19) - (product_tmp >> 19));
        product5 += ((int32_t)(upper2 - sxt6(upper2))) >> 6;

        upper2 = 0, lower2 = 0;
      }
    }

    product_tmp = sxt19(lower1);
    product1 += product_tmp;
    product2 += sxt19((upper1 << 13) + (((uint32_t) lower1) >> 19) - (product_tmp >> 19));
    product3 += ((int32_t)(upper1 - sxt6(upper1))) >> 6;
    product_tmp = sxt19(lower2);
    product3 += product_tmp;
    product4 += sxt19((upper2 << 13) + (((uint32_t) lower2) >> 19) - (product_tmp >> 19));
    h[i << 1] = barrett_32(product1); h[(i << 1) + 1] = barrett_32(product2);
    h[(i << 1) + 2] = barrett_32(product3); h[(i << 1) + 3] = barrett_32(product4);

    product_tmp = sxt19(lower3);
    product1 = product5 + product_tmp;
    product1 += ((int32_t)(upper2 - sxt6(upper2))) >> 6;
    product2 = product6 + sxt19((upper3 << 13) + (((uint32_t) lower3) >> 19) - (product_tmp >> 19));
    product3 = product7 + (((int32_t)(upper3 - sxt6(upper3))) >> 6);
  }

  h[i << 1] = barrett_32(product1); h[(i << 1) + 1] = barrett_32(product2);
  h[(i << 1) + 2] = barrett_32(product3); h[(i << 1) + 3] = 0;
}

void smlal_mult_64(int32_t *h, const int16_t *c, const int16_t *f) {
  int i, j, k, j_begin, j_end;
  uint32_t c_dual[32], f_dual[32];
  uint32_t op1c, op1f, op2c, op2f;
  uint32_t upper1, lower1, upper2, lower2, upper3, lower3;
  int32_t product1 = 0, product2 = 0, product3 = 0, product4, product5, product6, product7, product_tmp;

  for (i = 0, j = 0; i < 32; ++i, j += 2) {
    c_dual[i] = c[j] + (c[j + 1] << 19);
    f_dual[i] = f[j] + (f[j + 1] << 19);
  }

  for (i = 0; i < 62; i += 2) {
    if (i < 32) { j_begin = 0; j_end = i + 1; }
    else { j_begin = i - 30; j_end = 32; }
    upper1 = 0, lower1 = 0, upper2 = 0, lower2 = 0, upper3 = 0, lower3 = 0;
    product4 = 0, product5 = 0, product6 = 0, product7 = 0;

    for (j = j_begin, k = 0; j < j_end; j += 2, ++k) {
      op1c = c_dual[j]; op2c = c_dual[j + 1]; op1f = f_dual[i - j]; op2f = f_dual[i - j + 1];
      __asm__ volatile (
        "smlal %0, %1, %6, %7 \n\t"
        "smlal %2, %3, %7, %8 \n\t"
        "smlal %2, %3, %6, %9 \n\t"
        "smlal %4, %5, %8, %9"
        : "=r" (lower1), "=r" (upper1), "=r" (lower2), "=r" (upper2), "=r" (lower3), "=r" (upper3)
        : "r" (op1c), "r" (op1f), "r" (op2c), "r" (op2f), "0" (lower1), "1" (upper1), "2" (lower2), "3" (upper2), "4" (lower3), "5" (upper3)
        : "cc" );

      if (k == 6) {
        product_tmp = sxt19(lower1);
        product1 += product_tmp;
        product2 += sxt19((upper1 << 13) + (((uint32_t) lower1) >> 19) - (product_tmp >> 19));
        product3 += ((int32_t)(upper1 - sxt6(upper1))) >> 6;

        product_tmp = sxt19(lower2);
        product3 += product_tmp;
        product4 += sxt19((upper2 << 13) + (((uint32_t) lower2) >> 19) - (product_tmp >> 19));
        product5 += ((int32_t)(upper2 - sxt6(upper2))) >> 6;

        product_tmp = sxt19(lower3);
        product5 += product_tmp;
        product6 += sxt19((upper3 << 13) + (((uint32_t) lower3) >> 19) - (product_tmp >> 19));
        product7 += ((int32_t)(upper3 - sxt6(upper3))) >> 6;

        upper1 = 0, lower1 = 0, upper2 = 0, lower2 = 0, upper3 = 0, lower3 = 0;
      } else if (k == 3) {
        product_tmp = sxt19(lower2);
        product3 += product_tmp;
        product4 += sxt19((upper2 << 13) + (((uint32_t) lower2) >> 19) - (product_tmp >> 19));
        product5 += ((int32_t)(upper2 - sxt6(upper2))) >> 6;

        upper2 = 0, lower2 = 0;
      }
    }
    
    product_tmp = sxt19(lower1);
    product1 += product_tmp;
    product2 += sxt19((upper1 << 13) + (((uint32_t) lower1) >> 19) - (product_tmp >> 19));
    product3 += ((int32_t)(upper1 - sxt6(upper1))) >> 6;
    product_tmp = sxt19(lower2);
    product3 += product_tmp;
    product4 += sxt19((upper2 << 13) + (((uint32_t) lower2) >> 19) - (product_tmp >> 19));
    h[i << 1] = barrett_32(product1); h[(i << 1) + 1] = barrett_32(product2);
    h[(i << 1) + 2] = barrett_32(product3); h[(i << 1) + 3] = barrett_32(product4);

    product_tmp = sxt19(lower3);
    product1 = product5 + product_tmp;
    product1 += ((int32_t)(upper2 - sxt6(upper2))) >> 6;
    product2 = product6 + sxt19((upper3 << 13) + (((uint32_t) lower3) >> 19) - (product_tmp >> 19));
    product3 = product7 + (((int32_t)(upper3 - sxt6(upper3))) >> 6);
  }

  h[i << 1] = barrett_32(product1); h[(i << 1) + 1] = barrett_32(product2);
  h[(i << 1) + 2] = barrett_32(product3); h[(i << 1) + 3] = 0;
}
