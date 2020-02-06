.p2align 2,,3
.syntax unified
.text

.global hybrid_mult_asm
.type hybrid_mult_asm, %function

// 9x 48x48 hybrid multiplication
// void hybrid_mult_asm(int32_t *cf, uint32_t *c_from1, uint32_t *f_from1);
hybrid_mult_asm:
  push.w {r4-r12, lr}
  add.w r7, r0, #3456
snake_body:
  vmov.w s0, r7
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  smulbb.w r7, r3, r5
  smulbb.w r9, r3, r6
  smuadx.w r8, r3, r5
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r3, [r1, #-8]
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r10, [r0], #4
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r3, [r1, #-8]
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r10, [r0], #4
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r3, [r1, #-8]
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r10, [r0], #4
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r3, [r1, #-8]
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r10, [r0], #4
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r3, [r1, #-8]
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r10, [r0], #4
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #-4
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r10, [r0], #4
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1, #4]
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #-4
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r10, [r0], #4
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1, #4]
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #-4
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r10, [r0], #4
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1, #4]
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #-4
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r10, [r0], #4
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1, #4]
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r4, [r1], #-4
  ldr.w r3, [r1], #-4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r6, [r2, #4]
  ldr.w r5, [r2], #-4
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r10, [r0], #4
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r6, [r2], #-4
  ldr.w r5, [r2], #-4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r4, [r1, #4]
  ldr.w r3, [r1], #-4
  ldr.w r5, [r2, #-4]
  ldr.w r6, [r2], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smladx.w r10, r3, r6, r10
  smladx.w r12, r4, r6, r12
  smlatt.w r11, r4, r5, r11
  smlatt.w lr, r4, r6, lr
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  ldr.w r3, [r1, #4]
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smuadx.w r10, r3, r6
  smuadx.w r8, r4, r6
  smultt.w r7, r4, r5
  smultt.w r9, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r3, [r1, #-4]
  ldr.w r4, [r1], #4
  smlabb.w r11, r3, r5, r11
  smlabb.w lr, r3, r6, lr
  smladx.w r12, r3, r5, r12
  smladx.w r10, r3, r6, r10
  smladx.w r8, r4, r6, r8
  smlatt.w r7, r4, r5, r7
  smlatt.w r9, r4, r6, r9
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w lr, r3, r5, lr
  smlad.w r7, r3, r6, r7
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r10, [r0], #4
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  smlabb.w r7, r3, r5, r7
  smlabb.w r9, r3, r6, r9
  smladx.w r8, r3, r5, r8
  smuadx.w r10, r3, r6
  smuadx.w r12, r4, r6
  smultt.w r11, r4, r5
  smultt.w lr, r4, r6
  smladx.w r10, r4, r5, r10
  pkhbt.w r3, r4, r3
  smlad.w r9, r3, r5, r9
  smlad.w r11, r3, r6, r11
  mov.w r3, #0
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r3, [r0], #4
  vmov.w r7, s0
  cmp.w r0, r7
  bne.w snake_body
  pop.w {r4-r12, pc}
