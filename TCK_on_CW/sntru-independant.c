/*
    This file is part of the AESExplorer Example Targets
    Copyright (C) 2012 Colin O'Flynn <coflynn@newae.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "sntru-independant.h"

#include <stdlib.h>
#include "myRand.h"
#include "api.h"
#include "params.h"
#include "small.h"
#include "rq.h"

#include "Toom.h"

unsigned char *pk;
unsigned char *sk;

void sntru_indep_init(void)
{
  pk = malloc(CRYPTO_PUBLICKEYBYTES);
  sk = malloc(CRYPTO_SECRETKEYBYTES);
}

void sntru_indep_key(uint8_t * key)
{
  myRandInit(key, 16);
  crypto_kem_keypair(pk, sk);
}

void sntru_indep_enc(int16_t * product, int16_t * sk, int16_t * ct)
{
  /* unsigned int i, j;
  int32_t A;
  for (i = 0; i < p; ++i) {
    A = 0;
    for (j = 0; j <= i ; ++j) A += ct[j] * sk[i - j];
    A -= 4591 * ((228 * A) >> 20);
    A -= 4591 * ((58470 * A + 134217728) >> 28);
    product[i] = A;
  }
  for (i = p; i < p + p - 1; ++i) {
    A = 0;
    for (j = i - p + 1; j < p ; ++j) A += ct[j] * sk[i - j];
    A -= 4591 * ((228 * A) >> 20);
    A -= 4591 * ((58470 * A + 134217728) >> 28);
    product[i] = A;
  } */
  int i;
  int32_t A;
  // Toom3_mult(product, ct, sk);
  Toom4_mult(product, ct, sk);
  // Karatsuba_mult(product, ct, sk, 768, 1);
  A = product[0] + product[p];
  A -= 4591 * ((228 * A) >> 20);
  A -= 4591 * ((58470 * A + 134217728) >> 28);
  product[0] = A;
  A = product[p - 1] + product[p + p - 2];
  A -= 4591 * ((228 * A) >> 20);
  A -= 4591 * ((58470 * A + 134217728) >> 28);
  product[p - 1] = A;
  for (i = 1; i < p - 1; ++i) {
    A = product[i] + product[i + p - 1] + product[i + p];
    A -= 4591 * ((228 * A) >> 20);
    A -= 4591 * ((58470 * A + 134217728) >> 28);
    product[i] = A;
  }
  /* int16_t a;
  int32_t b;
  for (a = -32767; a < 32767; ++a) {
    b = a;
    b -= ((b * 7 + 0x4000) >> 15) * 4591;
    product[p - 1 - (a & 7)] = b;
  }
  for (a = -32767; a < 32767; ++a) {
    b = a;
    b -= 4591 * ((228 * b) >> 20);
    b -= 4591 * ((58470 * b + 134217728) >> 28);
    product[p - 1 - (a & 7)] = b;
  } */
}
