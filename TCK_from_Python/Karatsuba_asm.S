.p2align 2,,3
.syntax unified
.text

.global Karatsuba_mult_asm
.type Karatsuba_mult_asm, %function
@ 256x256 2-layer Karatsuba
@ void Karatsuba_mult_asm(uint32_t *h, uint32_t *c, uint32_t *f)
Karatsuba_mult_asm:
  push.w {r4-r12, lr}
  vmov.w s0, r0
  sub.w sp, sp, #6912
  mov.w r0, sp
  add.w lr, r0, #480
Karatsuba_mult_asm_copy_input_f_body:
  ldm.w r2!, {r3-r12}
  stm.w r0!, {r3-r12}
  cmp.w r0, lr
  bne.w Karatsuba_mult_asm_copy_input_f_body
  ldm.w r2!, {r3-r10}
  stm.w r0!, {r3-r10}
  vmov.w s1, r0
  sub.w r12, r0, #512
Karatsuba_mult_asm_extend_input_f_0_body:
  add.w lr, r12, #256
Karatsuba_mult_asm_extend_input_f_0_unit:
  ldm.w r12!, {r4-r7}
  ldr.w r8, [r12, #240]
  ldr.w r9, [r12, #244]
  ldr.w r10, [r12, #248]
  ldr.w r11, [r12, #252]
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  stm.w r0!, {r4-r7}
  cmp.w r12, lr
  bne.w Karatsuba_mult_asm_extend_input_f_0_unit
  add.w r12, r12, #256
  vmov.w lr, s1
  cmp.w r12, lr
  bne.w Karatsuba_mult_asm_extend_input_f_0_body
  vmov.w s1, r0
  sub.w r12, r0, #768
Karatsuba_mult_asm_extend_input_f_1_body:
  add.w lr, r12, #128
Karatsuba_mult_asm_extend_input_f_1_unit:
  ldm.w r12!, {r4-r7}
  ldr.w r8, [r12, #112]
  ldr.w r9, [r12, #116]
  ldr.w r10, [r12, #120]
  ldr.w r11, [r12, #124]
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  stm.w r0!, {r4-r7}
  cmp.w r12, lr
  bne.w Karatsuba_mult_asm_extend_input_f_1_unit
  add.w r12, r12, #128
  vmov.w lr, s1
  cmp.w r12, lr
  bne.w Karatsuba_mult_asm_extend_input_f_1_body
  add.w lr, r0, #484
Karatsuba_mult_asm_copy_input_c_body:
  ldm.w r1!, {r2-r12}
  stm.w r0!, {r2-r12}
  cmp.w r0, lr
  bne.w Karatsuba_mult_asm_copy_input_c_body
  ldm.w r1!, {r2-r8}
  stm.w r0!, {r2-r8}
  movw.w r3, #18015
  movt.w r3, #14
  movw.w r2, #32768
  movw.w r1, #4591
  vmov.w s1, r0
  sub.w r12, r0, #512
Karatsuba_mult_asm_extend_input_c_0_body:
  add.w lr, r12, #256
Karatsuba_mult_asm_extend_input_c_0_unit:
  ldm.w r12!, {r4-r7}
  ldr.w r8, [r12, #240]
  ldr.w r9, [r12, #244]
  ldr.w r10, [r12, #248]
  ldr.w r11, [r12, #252]
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r3, r4, r2
  smlawt.w r9, r3, r4, r2
  smulbt.w r8, r1, r8
  smulbt.w r9, r1, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r3, r5, r2
  smlawt.w r9, r3, r5, r2
  smulbt.w r8, r1, r8
  smulbt.w r9, r1, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r3, r6, r2
  smlawt.w r9, r3, r6, r2
  smulbt.w r8, r1, r8
  smulbt.w r9, r1, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r3, r7, r2
  smlawt.w r9, r3, r7, r2
  smulbt.w r8, r1, r8
  smulbt.w r9, r1, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  stm.w r0!, {r4-r7}
  cmp.w r12, lr
  bne.w Karatsuba_mult_asm_extend_input_c_0_unit
  add.w r12, r12, #256
  vmov.w lr, s1
  cmp.w r12, lr
  bne.w Karatsuba_mult_asm_extend_input_c_0_body
  vmov.w s1, r0
  sub.w r12, r0, #768
Karatsuba_mult_asm_extend_input_c_1_body:
  add.w lr, r12, #128
Karatsuba_mult_asm_extend_input_c_1_unit:
  ldm.w r12!, {r4-r7}
  ldr.w r8, [r12, #112]
  ldr.w r9, [r12, #116]
  ldr.w r10, [r12, #120]
  ldr.w r11, [r12, #124]
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  smlawb.w r8, r3, r4, r2
  smlawt.w r9, r3, r4, r2
  smulbt.w r8, r1, r8
  smulbt.w r9, r1, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r4, r4, r8
  smlawb.w r8, r3, r5, r2
  smlawt.w r9, r3, r5, r2
  smulbt.w r8, r1, r8
  smulbt.w r9, r1, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r5, r5, r8
  smlawb.w r8, r3, r6, r2
  smlawt.w r9, r3, r6, r2
  smulbt.w r8, r1, r8
  smulbt.w r9, r1, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r6, r6, r8
  smlawb.w r8, r3, r7, r2
  smlawt.w r9, r3, r7, r2
  smulbt.w r8, r1, r8
  smulbt.w r9, r1, r9
  pkhbt.w r8, r8, r9, lsl #16
  ssub16.w r7, r7, r8
  stm.w r0!, {r4-r7}
  cmp.w r12, lr
  bne.w Karatsuba_mult_asm_extend_input_c_1_unit
  add.w r12, r12, #128
  vmov.w lr, s1
  cmp.w r12, lr
  bne.w Karatsuba_mult_asm_extend_input_c_1_body
  add.w r7, r0, #4608
  sub.w r1, r0, #1152
  sub.w r2, r1, #1152
  vmov.w s1, r7
Karatsuba_mult_asm_snake_body:
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
  bne.w Karatsuba_mult_asm_snake_body
  sub.w r0, r0, #4352
  add.w lr, r0, #3072
  vmov.w s1, lr
Karatsuba_mult_asm_compose_output_0_body:
  add.w lr, r0, #256
Karatsuba_mult_asm_compose_output_A_0:
  ldm.w r0, {r1-r4}
  ldr.w r5, [r0, #256]
  ldr.w r6, [r0, #260]
  ldr.w r7, [r0, #264]
  ldr.w r8, [r0, #268]
  sub.w r1, r5, r1
  sub.w r2, r6, r2
  sub.w r3, r7, r3
  sub.w r4, r8, r4
  stm.w r0!, {r1-r4}
  cmp.w r0, lr
  bne.w Karatsuba_mult_asm_compose_output_A_0
  sub.w lr, lr, #256
Karatsuba_mult_asm_compose_output_B_0:
  ldr.w r5, [r0, #-4]!
  ldr.w r1, [r0, #512]
  ldr.w r6, [r0, #-4]!
  ldr.w r2, [r0, #512]
  ldr.w r7, [r0, #-4]!
  ldr.w r3, [r0, #512]
  ldr.w r8, [r0, #-4]!
  ldr.w r4, [r0, #512]
  sub.w r1, r1, r5
  sub.w r2, r2, r6
  sub.w r3, r3, r7
  sub.w r4, r4, r8
  str.w r1, [r0, #268]
  str.w r2, [r0, #264]
  str.w r3, [r0, #260]
  str.w r4, [r0, #256]
  cmp.w r0, lr
  bne.w Karatsuba_mult_asm_compose_output_B_0
  sub.w lr, lr, #256
Karatsuba_mult_asm_compose_output_C_0:
  ldr.w r5, [r0, #-4]!
  ldr.w r1, [r0, #256]
  ldr.w r6, [r0, #-4]!
  ldr.w r2, [r0, #256]
  ldr.w r7, [r0, #-4]!
  ldr.w r3, [r0, #256]
  ldr.w r8, [r0, #-4]!
  ldr.w r4, [r0, #256]
  add.w r1, r1, r5
  add.w r2, r2, r6
  add.w r3, r3, r7
  add.w r4, r4, r8
  str.w r1, [r0, #268]
  str.w r2, [r0, #264]
  str.w r3, [r0, #260]
  str.w r4, [r0, #256]
  cmp.w r0, lr
  bne.w Karatsuba_mult_asm_compose_output_C_0
  add.w r0, r0, #1280
  vmov.w lr, s1
  cmp.w r0, lr
  bne.w Karatsuba_mult_asm_compose_output_0_body
  sub.w lr, r0, #256
  sub.w r12, r0, #3072
Karatsuba_mult_asm_compose_output_0_jump:
  add.w r11, r12, #512
Karatsuba_mult_asm_compose_output_D_0:
  ldm.w r12, {r1-r4}
  ldm.w lr!, {r5-r8}
  sub.w r1, r5, r1
  sub.w r2, r6, r2
  sub.w r3, r7, r3
  sub.w r4, r8, r4
  stm.w r12!, {r1-r4}
  cmp.w r12, r11
  bne.w Karatsuba_mult_asm_compose_output_D_0
  add.w r12, r12, #512
  cmp.w r12, r0
  bne.w Karatsuba_mult_asm_compose_output_0_jump
  sub.w r0, r12, #512
  sub.w r0, r0, #2304
  add.w lr, r0, #2048
  vmov.w s1, lr
Karatsuba_mult_asm_compose_output_1_body:
  add.w lr, r0, #512
Karatsuba_mult_asm_compose_output_A_1:
  ldm.w r0, {r1-r4}
  ldr.w r5, [r0, #512]
  ldr.w r6, [r0, #516]
  ldr.w r7, [r0, #520]
  ldr.w r8, [r0, #524]
  sub.w r1, r5, r1
  sub.w r2, r6, r2
  sub.w r3, r7, r3
  sub.w r4, r8, r4
  stm.w r0!, {r1-r4}
  cmp.w r0, lr
  bne.w Karatsuba_mult_asm_compose_output_A_1
  sub.w lr, lr, #512
Karatsuba_mult_asm_compose_output_B_1:
  ldr.w r5, [r0, #-4]!
  ldr.w r1, [r0, #1024]
  ldr.w r6, [r0, #-4]!
  ldr.w r2, [r0, #1024]
  ldr.w r7, [r0, #-4]!
  ldr.w r3, [r0, #1024]
  ldr.w r8, [r0, #-4]!
  ldr.w r4, [r0, #1024]
  sub.w r1, r1, r5
  sub.w r2, r2, r6
  sub.w r3, r3, r7
  sub.w r4, r4, r8
  str.w r1, [r0, #524]
  str.w r2, [r0, #520]
  str.w r3, [r0, #516]
  str.w r4, [r0, #512]
  cmp.w r0, lr
  bne.w Karatsuba_mult_asm_compose_output_B_1
  sub.w lr, lr, #512
Karatsuba_mult_asm_compose_output_C_1:
  ldr.w r5, [r0, #-4]!
  ldr.w r1, [r0, #512]
  ldr.w r6, [r0, #-4]!
  ldr.w r2, [r0, #512]
  ldr.w r7, [r0, #-4]!
  ldr.w r3, [r0, #512]
  ldr.w r8, [r0, #-4]!
  ldr.w r4, [r0, #512]
  add.w r1, r1, r5
  add.w r2, r2, r6
  add.w r3, r3, r7
  add.w r4, r4, r8
  str.w r1, [r0, #524]
  str.w r2, [r0, #520]
  str.w r3, [r0, #516]
  str.w r4, [r0, #512]
  cmp.w r0, lr
  bne.w Karatsuba_mult_asm_compose_output_C_1
  add.w r0, r0, #2560
  vmov.w lr, s1
  cmp.w r0, lr
  bne.w Karatsuba_mult_asm_compose_output_1_body
  sub.w lr, r0, #512
  sub.w r12, r0, #2048
Karatsuba_mult_asm_compose_output_1_jump:
  add.w r11, r12, #1024
Karatsuba_mult_asm_compose_output_D_1:
  ldm.w r12, {r1-r4}
  ldm.w lr!, {r5-r8}
  sub.w r1, r5, r1
  sub.w r2, r6, r2
  sub.w r3, r7, r3
  sub.w r4, r8, r4
  stm.w r12!, {r1-r4}
  cmp.w r12, r11
  bne.w Karatsuba_mult_asm_compose_output_D_1
  add.w r12, r12, #1024
  cmp.w r12, r0
  bne.w Karatsuba_mult_asm_compose_output_1_jump
  sub.w r0, r12, #2560
  vmov.w lr, s0
  movw.w r12, #18015
  movt.w r12, #14
  movw.w r11, #4591
  add.w r1, r0, #2048
Karatsuba_mult_asm_copy_output_body:
  ldm.w r0!, {r2-r9}
  smmulr.w r10, r12, r2
  mls.w r2, r11, r10, r2
  smmulr.w r10, r12, r3
  mls.w r3, r11, r10, r3
  pkhbt.w r2, r2, r3, lsl #16
  smmulr.w r10, r12, r4
  mls.w r4, r11, r10, r4
  smmulr.w r10, r12, r5
  mls.w r5, r11, r10, r5
  pkhbt.w r3, r4, r5, lsl #16
  smmulr.w r10, r12, r6
  mls.w r6, r11, r10, r6
  smmulr.w r10, r12, r7
  mls.w r7, r11, r10, r7
  pkhbt.w r4, r6, r7, lsl #16
  smmulr.w r10, r12, r8
  mls.w r8, r11, r10, r8
  smmulr.w r10, r12, r9
  mls.w r9, r11, r10, r9
  pkhbt.w r5, r8, r9, lsl #16
  stm.w lr!, {r2-r5}
  cmp.w r0, r1
  bne.w Karatsuba_mult_asm_copy_output_body
  add.w sp, sp, #6912
  pop.w {r4-r12, pc}
