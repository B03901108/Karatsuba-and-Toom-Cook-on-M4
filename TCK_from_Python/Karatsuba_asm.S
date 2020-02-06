.p2align 2,,3
.syntax unified
.text

.global Karatsuba_mult_asm
.type Karatsuba_mult_asm, %function
@ 192x192 2-layer Karatsuba
@ void Karatsuba_mult_asm(int32_t *h, uint32_t *c, uint32_t *f)
Karatsuba_mult_asm:
  push.w {r4-r12, lr}
  vmov.w s0, r0
  sub.w sp, sp, #5184
  mov.w r0, sp
  ldr.w r3, [r2], #4
  ldr.w r4, [r2], #4
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r7, [r2], #4
  ldr.w r8, [r2], #4
  ldr.w r9, [r2], #4
  ldr.w r10, [r2], #4
  ldr.w r11, [r2], #4
  ldr.w r12, [r2], #4
  ldr.w lr, [r2], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  ldr.w r3, [r2], #4
  ldr.w r4, [r2], #4
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r7, [r2], #4
  ldr.w r8, [r2], #4
  ldr.w r9, [r2], #4
  ldr.w r10, [r2], #4
  ldr.w r11, [r2], #4
  ldr.w r12, [r2], #4
  ldr.w lr, [r2], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  ldr.w r3, [r2], #4
  ldr.w r4, [r2], #4
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r7, [r2], #4
  ldr.w r8, [r2], #4
  ldr.w r9, [r2], #4
  ldr.w r10, [r2], #4
  ldr.w r11, [r2], #4
  ldr.w r12, [r2], #4
  ldr.w lr, [r2], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  ldr.w r3, [r2], #4
  ldr.w r4, [r2], #4
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r7, [r2], #4
  ldr.w r8, [r2], #4
  ldr.w r9, [r2], #4
  ldr.w r10, [r2], #4
  ldr.w r11, [r2], #4
  ldr.w r12, [r2], #4
  ldr.w lr, [r2], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  ldr.w r3, [r2], #4
  ldr.w r4, [r2], #4
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r7, [r2], #4
  ldr.w r8, [r2], #4
  ldr.w r9, [r2], #4
  ldr.w r10, [r2], #4
  ldr.w r11, [r2], #4
  ldr.w r12, [r2], #4
  ldr.w lr, [r2], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  ldr.w r3, [r2], #4
  ldr.w r4, [r2], #4
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r7, [r2], #4
  ldr.w r8, [r2], #4
  ldr.w r9, [r2], #4
  ldr.w r10, [r2], #4
  ldr.w r11, [r2], #4
  ldr.w r12, [r2], #4
  ldr.w lr, [r2], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  ldr.w r3, [r2], #4
  ldr.w r4, [r2], #4
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r7, [r2], #4
  ldr.w r8, [r2], #4
  ldr.w r9, [r2], #4
  ldr.w r10, [r2], #4
  ldr.w r11, [r2], #4
  ldr.w r12, [r2], #4
  ldr.w lr, [r2], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  ldr.w r3, [r2], #4
  ldr.w r4, [r2], #4
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r7, [r2], #4
  ldr.w r8, [r2], #4
  ldr.w r9, [r2], #4
  ldr.w r10, [r2], #4
  ldr.w r11, [r2], #4
  ldr.w r12, [r2], #4
  ldr.w lr, [r2], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  ldr.w r3, [r2], #4
  ldr.w r4, [r2], #4
  ldr.w r5, [r2], #4
  ldr.w r6, [r2], #4
  ldr.w r7, [r2], #4
  ldr.w r8, [r2], #4
  ldr.w r9, [r2], #4
  ldr.w r10, [r2], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  sub.w r12, r0, #384
  ldr.w r9, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #192]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #192]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #192]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #192]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #192]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #192]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #192]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #192]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #192]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #192]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #192]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #192]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #192]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #192]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #192]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #192]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #192]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #192]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r7, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r8, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r9, [r12, #192]
  ldr.w r6, [r12], #196
  sadd16.w r4, r4, r7
  sadd16.w r5, r5, r8
  sadd16.w r6, r6, r9
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  sub.w r12, r0, #576
  ldr.w r9, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #96]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #96]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #96]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #96]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #96]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #96]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #96]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #96]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #96]
  ldr.w r7, [r12], #100
  ldr.w r2, [r12, #96]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #96]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #96]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #96]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #96]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #96]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #96]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #96]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #96]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r6, [r12], #100
  ldr.w lr, [r12, #96]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #96]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #96]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #96]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #96]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #96]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #96]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #96]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r9, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w lr, [r12, #96]
  ldr.w r7, [r12], #4
  ldr.w r2, [r12, #96]
  ldr.w r8, [r12], #4
  sadd16.w r4, r4, r9
  sadd16.w r5, r5, r10
  sadd16.w r6, r6, r11
  sadd16.w r7, r7, lr
  sadd16.w r8, r8, r2
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  ldr.w r6, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r7, [r12, #96]
  ldr.w r5, [r12], #100
  sadd16.w r4, r4, r6
  sadd16.w r5, r5, r7
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r5, [r1], #4
  ldr.w r6, [r1], #4
  ldr.w r7, [r1], #4
  ldr.w r8, [r1], #4
  ldr.w r9, [r1], #4
  ldr.w r10, [r1], #4
  ldr.w r11, [r1], #4
  ldr.w r12, [r1], #4
  ldr.w lr, [r1], #4
  ldr.w r2, [r1], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r2, [r0], #4
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r5, [r1], #4
  ldr.w r6, [r1], #4
  ldr.w r7, [r1], #4
  ldr.w r8, [r1], #4
  ldr.w r9, [r1], #4
  ldr.w r10, [r1], #4
  ldr.w r11, [r1], #4
  ldr.w r12, [r1], #4
  ldr.w lr, [r1], #4
  ldr.w r2, [r1], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r2, [r0], #4
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r5, [r1], #4
  ldr.w r6, [r1], #4
  ldr.w r7, [r1], #4
  ldr.w r8, [r1], #4
  ldr.w r9, [r1], #4
  ldr.w r10, [r1], #4
  ldr.w r11, [r1], #4
  ldr.w r12, [r1], #4
  ldr.w lr, [r1], #4
  ldr.w r2, [r1], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r2, [r0], #4
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r5, [r1], #4
  ldr.w r6, [r1], #4
  ldr.w r7, [r1], #4
  ldr.w r8, [r1], #4
  ldr.w r9, [r1], #4
  ldr.w r10, [r1], #4
  ldr.w r11, [r1], #4
  ldr.w r12, [r1], #4
  ldr.w lr, [r1], #4
  ldr.w r2, [r1], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r2, [r0], #4
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r5, [r1], #4
  ldr.w r6, [r1], #4
  ldr.w r7, [r1], #4
  ldr.w r8, [r1], #4
  ldr.w r9, [r1], #4
  ldr.w r10, [r1], #4
  ldr.w r11, [r1], #4
  ldr.w r12, [r1], #4
  ldr.w lr, [r1], #4
  ldr.w r2, [r1], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r2, [r0], #4
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r5, [r1], #4
  ldr.w r6, [r1], #4
  ldr.w r7, [r1], #4
  ldr.w r8, [r1], #4
  ldr.w r9, [r1], #4
  ldr.w r10, [r1], #4
  ldr.w r11, [r1], #4
  ldr.w r12, [r1], #4
  ldr.w lr, [r1], #4
  ldr.w r2, [r1], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r2, [r0], #4
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r5, [r1], #4
  ldr.w r6, [r1], #4
  ldr.w r7, [r1], #4
  ldr.w r8, [r1], #4
  ldr.w r9, [r1], #4
  ldr.w r10, [r1], #4
  ldr.w r11, [r1], #4
  ldr.w r12, [r1], #4
  ldr.w lr, [r1], #4
  ldr.w r2, [r1], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r2, [r0], #4
  ldr.w r3, [r1], #4
  ldr.w r4, [r1], #4
  ldr.w r5, [r1], #4
  ldr.w r6, [r1], #4
  ldr.w r7, [r1], #4
  ldr.w r8, [r1], #4
  ldr.w r9, [r1], #4
  ldr.w r10, [r1], #4
  ldr.w r11, [r1], #4
  ldr.w r12, [r1], #4
  ldr.w lr, [r1], #4
  ldr.w r2, [r1], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r2, [r0], #4
  movw.w r2, #18015
  movt.w r2, #14
  movw.w r1, #32768
  movw.w lr, #4591
  sub.w r12, r0, #384
  ldr.w r8, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #192]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #192]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #192]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #192]
  ldr.w r7, [r12], #196
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  sub.w r12, r0, #576
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #100
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #100
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #4
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  ldr.w r8, [r12, #96]
  ldr.w r4, [r12], #4
  ldr.w r9, [r12, #96]
  ldr.w r5, [r12], #4
  ldr.w r10, [r12, #96]
  ldr.w r6, [r12], #4
  ldr.w r11, [r12, #96]
  ldr.w r7, [r12], #100
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r2, r4, r1
  smlawt.w r9, r2, r4, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r2, r5, r1
  smlawt.w r9, r2, r5, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r2, r6, r1
  smlawt.w r9, r2, r6, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r2, r7, r1
  smlawt.w r9, r2, r7, r1
  smulbt.w r8, lr, r8
  smulbt.w r9, lr, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  str.w r7, [r0], #4
  add.w r7, r0, #3456
  sub.w r1, r0, #864
  sub.w r2, r1, #864
  vmov.w s1, r7
snake_body:
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
  movw.w r3, #0
  str.w r7, [r0], #4
  str.w r8, [r0], #4
  str.w r9, [r0], #4
  str.w r10, [r0], #4
  str.w r11, [r0], #4
  str.w r12, [r0], #4
  str.w lr, [r0], #4
  str.w r3, [r0], #4
  vmov.w r7, s1
  cmp.w r0, r7
  bne.w snake_body
  sub.w r0, r0, #3264
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  add.w r0, r0, #960
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  add.w r0, r0, #960
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #192]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #196]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #200]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #204]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #208]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #192]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #192]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #192]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #192]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #192]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #192]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #212]
  str.w r2, [r0, #208]
  str.w r3, [r0, #204]
  str.w r4, [r0, #200]
  str.w r5, [r0, #196]
  str.w r6, [r0, #192]
  add.w lr, r0, #768
  sub.w r0, r0, #1344
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  add.w r0, r0, #384
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  add.w r0, r0, #384
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  sub.w r0, r0, #1728
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #384]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #388]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #392]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #396]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #400]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #384]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #388]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #392]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #396]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #400]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #384]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #388]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #392]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #396]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #400]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #384]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #388]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #392]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #396]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #400]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #384]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #388]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #392]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #396]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #400]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #384]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #388]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #392]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #396]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #400]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #384]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #388]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #392]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #396]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #400]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #384]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #388]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #392]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #396]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #400]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #384]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #388]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #392]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #396]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #400]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #384]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #388]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #392]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #396]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #400]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #384]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #388]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #392]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #396]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #400]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #384]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #388]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #392]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #396]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #400]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #384]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #388]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #392]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #396]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #400]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #384]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #388]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #392]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #396]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #400]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #384]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #388]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #392]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #396]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #400]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [r0, #384]
  ldr.w r2, [r0, #4]
  ldr.w r8, [r0, #388]
  ldr.w r3, [r0, #8]
  ldr.w r9, [r0, #392]
  ldr.w r4, [r0, #12]
  ldr.w r10, [r0, #396]
  ldr.w r5, [r0, #16]
  ldr.w r11, [r0, #400]
  ldr.w r6, [r0, #20]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #768]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #768]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #768]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #768]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #768]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #768]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #768]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #768]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #768]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #768]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #768]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #768]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #768]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #768]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #768]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #768]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #768]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #768]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #768]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #768]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #768]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #768]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #768]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #768]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #768]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #768]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #768]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #768]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #768]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #768]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #768]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #768]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #768]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #768]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #768]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #768]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #768]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #768]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #768]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #768]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #768]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #768]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #768]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #768]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #768]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #768]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #768]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #768]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #768]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #768]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #768]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #768]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #768]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #768]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #768]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #768]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #768]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #768]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #768]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #768]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #768]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #768]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #768]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #768]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #768]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #768]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #768]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #768]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #768]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #768]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #768]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #768]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #768]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #768]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #768]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #768]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #768]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #768]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #768]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #768]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #768]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #768]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #768]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #768]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #768]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #768]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #768]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #768]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #768]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #768]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #768]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #768]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #768]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #768]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #768]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #768]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #384]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #384]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #384]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #384]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #384]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #384]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #404]
  str.w r2, [r0, #400]
  str.w r3, [r0, #396]
  str.w r4, [r0, #392]
  str.w r5, [r0, #388]
  str.w r6, [r0, #384]
  add.w lr, r0, #1536
  sub.w r0, r0, #-384
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  ldr.w r1, [r0, #0]
  ldr.w r7, [lr], #4
  ldr.w r2, [r0, #4]
  ldr.w r8, [lr], #4
  ldr.w r3, [r0, #8]
  ldr.w r9, [lr], #4
  ldr.w r4, [r0, #12]
  ldr.w r10, [lr], #4
  ldr.w r5, [r0, #16]
  ldr.w r11, [lr], #4
  ldr.w r6, [r0, #20]
  ldr.w r12, [lr], #4
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  str.w r1, [r0], #4
  str.w r2, [r0], #4
  str.w r3, [r0], #4
  str.w r4, [r0], #4
  str.w r5, [r0], #4
  str.w r6, [r0], #4
  sub.w r0, r0, #1152
  vmov.w lr, s0
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  ldr.w r1, [r0], #4
  ldr.w r2, [r0], #4
  ldr.w r3, [r0], #4
  ldr.w r4, [r0], #4
  ldr.w r5, [r0], #4
  ldr.w r6, [r0], #4
  ldr.w r7, [r0], #4
  ldr.w r8, [r0], #4
  ldr.w r9, [r0], #4
  ldr.w r10, [r0], #4
  ldr.w r11, [r0], #4
  ldr.w r12, [r0], #4
  str.w r1, [lr], #4
  str.w r2, [lr], #4
  str.w r3, [lr], #4
  str.w r4, [lr], #4
  str.w r5, [lr], #4
  str.w r6, [lr], #4
  str.w r7, [lr], #4
  str.w r8, [lr], #4
  str.w r9, [lr], #4
  str.w r10, [lr], #4
  str.w r11, [lr], #4
  str.w r12, [lr], #4
  add.w sp, sp, #5184
  pop.w {r4-r12, pc}
