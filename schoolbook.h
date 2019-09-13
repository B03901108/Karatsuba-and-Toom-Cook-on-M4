#ifndef schoolbook_h
#define schoolbook_h

#include <stdint.h>
#define UNITLEN 32
#define LEN2 128
/* #define UNITLEN 24
#define LEN2 96 */
/* #define UNITLEN 12
#define LEN2 48
#define LEN4 192
#define LEN6 768 */
/* #define UNITLEN 6
#define LEN2 24
#define LEN4 96
#define LEN6 384 */
#define ARRLEN 768

static inline int16_t modq_freeze(int32_t a) {
  a -= 4591 * ((228 * a) >> 20);
  a -= 4591 * ((58470 * a + 134217728) >> 28);
  return a;
}

void schoolbook_mult(int16_t *, const int16_t *, const int16_t *);
void Karatsuba_mult(int16_t *, int16_t *, int16_t *, const int16_t, int8_t);
void Toom3_mult(int16_t *, int16_t *, int16_t *);
void Toom4_mult(int16_t *, int16_t *, int16_t *);

#endif
