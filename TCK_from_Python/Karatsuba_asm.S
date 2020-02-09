.p2align 2,,3
.syntax unified
.text

.global Karatsuba_mult_asm
.type Karatsuba_mult_asm, %function
@ 768x768 4-layer Karatsuba
@ void Karatsuba_mult_asm(uint32_t *h, uint32_t *c, uint32_t *f)
Karatsuba_mult_asm:
  push.w {r4-r12, lr}
  vmov.w s0, r0
  sub.w sp, sp, #1600
  sub.w sp, sp, #45056
  mov.w r0, sp
  add.w lr, r0, #1520
copy_input_f_body:
  ldm.w r2!, {r3-r12}
  stm.w r0!, {r3-r12}
  cmp.w r0, lr
  bne.w copy_input_f_body
  ldm.w r2!, {r3-r6}
  stm.w r0!, {r3-r6}
  vmov.w s1, r0
  sub.w r12, r0, #1536
extend_input_f_0_body:
  add.w lr, r12, #768
extend_input_f_0_unit:
  ldm.w r12!, {r4-r7}
  ldr.w r8, [r12, #752]
  ldr.w r9, [r12, #756]
  ldr.w r10, [r12, #760]
  ldr.w r11, [r12, #764]
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  stm.w r0!, {r4-r7}
  cmp.w r12, lr
  bne.w extend_input_f_0_unit
  add.w r12, r12, #768
  vmov.w lr, s1
  cmp.w r12, lr
  bne.w extend_input_f_0_body
  vmov.w s1, r0
  sub.w r12, r0, #2304
extend_input_f_1_body:
  add.w lr, r12, #384
extend_input_f_1_unit:
  ldm.w r12!, {r4-r7}
  ldr.w r8, [r12, #368]
  ldr.w r9, [r12, #372]
  ldr.w r10, [r12, #376]
  ldr.w r11, [r12, #380]
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  stm.w r0!, {r4-r7}
  cmp.w r12, lr
  bne.w extend_input_f_1_unit
  add.w r12, r12, #384
  vmov.w lr, s1
  cmp.w r12, lr
  bne.w extend_input_f_1_body
  vmov.w s1, r0
  sub.w r12, r0, #3456
extend_input_f_2_body:
  add.w lr, r12, #192
extend_input_f_2_unit:
  ldm.w r12!, {r4-r7}
  ldr.w r8, [r12, #176]
  ldr.w r9, [r12, #180]
  ldr.w r10, [r12, #184]
  ldr.w r11, [r12, #188]
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  stm.w r0!, {r4-r7}
  cmp.w r12, lr
  bne.w extend_input_f_2_unit
  add.w r12, r12, #192
  vmov.w lr, s1
  cmp.w r12, lr
  bne.w extend_input_f_2_body
  vmov.w s1, r0
  sub.w r12, r0, #5184
extend_input_f_3_body:
  add.w lr, r12, #96
extend_input_f_3_unit:
  ldm.w r12!, {r4-r7}
  ldr.w r8, [r12, #80]
  ldr.w r9, [r12, #84]
  ldr.w r10, [r12, #88]
  ldr.w r11, [r12, #92]
  sadd16.w r4, r4, r8
  sadd16.w r5, r5, r9
  sadd16.w r6, r6, r10
  sadd16.w r7, r7, r11
  stm.w r0!, {r4-r7}
  cmp.w r12, lr
  bne.w extend_input_f_3_unit
  add.w r12, r12, #96
  vmov.w lr, s1
  cmp.w r12, lr
  bne.w extend_input_f_3_body
  add.w lr, r0, #1496
copy_input_c_body:
  ldm.w r1!, {r2-r12}
  stm.w r0!, {r2-r12}
  cmp.w r0, lr
  bne.w copy_input_c_body
  ldm.w r1!, {r2-r11}
  stm.w r0!, {r2-r11}
  movw.w r3, #18015
  movt.w r3, #14
  movw.w r2, #32768
  movw.w r1, #4591
  vmov.w s1, r0
  sub.w r12, r0, #1536
extend_input_c_0_body:
  add.w lr, r12, #768
extend_input_c_0_unit:
  ldm.w r12!, {r4-r7}
  ldr.w r8, [r12, #752]
  ldr.w r9, [r12, #756]
  ldr.w r10, [r12, #760]
  ldr.w r11, [r12, #764]
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
  bne.w extend_input_c_0_unit
  add.w r12, r12, #768
  vmov.w lr, s1
  cmp.w r12, lr
  bne.w extend_input_c_0_body
  vmov.w s1, r0
  sub.w r12, r0, #2304
extend_input_c_1_body:
  add.w lr, r12, #384
extend_input_c_1_unit:
  ldm.w r12!, {r4-r7}
  ldr.w r8, [r12, #368]
  ldr.w r9, [r12, #372]
  ldr.w r10, [r12, #376]
  ldr.w r11, [r12, #380]
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
  bne.w extend_input_c_1_unit
  add.w r12, r12, #384
  vmov.w lr, s1
  cmp.w r12, lr
  bne.w extend_input_c_1_body
  vmov.w s1, r0
  sub.w r12, r0, #3456
extend_input_c_2_body:
  add.w lr, r12, #192
extend_input_c_2_unit:
  ldm.w r12!, {r4-r7}
  ldr.w r8, [r12, #176]
  ldr.w r9, [r12, #180]
  ldr.w r10, [r12, #184]
  ldr.w r11, [r12, #188]
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
  bne.w extend_input_c_2_unit
  add.w r12, r12, #192
  vmov.w lr, s1
  cmp.w r12, lr
  bne.w extend_input_c_2_body
  vmov.w s1, r0
  sub.w r12, r0, #5184
extend_input_c_3_body:
  add.w lr, r12, #96
extend_input_c_3_unit:
  ldm.w r12!, {r4-r7}
  ldr.w r8, [r12, #80]
  ldr.w r9, [r12, #84]
  ldr.w r10, [r12, #88]
  ldr.w r11, [r12, #92]
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
  bne.w extend_input_c_3_unit
  add.w r12, r12, #96
  vmov.w lr, s1
  cmp.w r12, lr
  bne.w extend_input_c_3_body
  add.w r7, r0, #31104
  sub.w r1, r0, #7776
  sub.w r2, r1, #7776
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
  sub.w r0, r0, #2240
  sub.w r0, r0, #28672
  add.w lr, r0, #20736
  vmov.w s1, lr
compose_output_0_body:
  add.w lr, r0, #192
compose_output_A_0:
  ldm.w r0, {r1-r6}
  ldr.w r7, [r0, #192]
  ldr.w r8, [r0, #196]
  ldr.w r9, [r0, #200]
  ldr.w r10, [r0, #204]
  ldr.w r11, [r0, #208]
  ldr.w r12, [r0, #212]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  stm.w r0!, {r1-r6}
  cmp.w r0, lr
  bne.w compose_output_A_0
  sub.w lr, lr, #192
compose_output_B_0:
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
  cmp.w r0, lr
  bne.w compose_output_B_0
  sub.w lr, lr, #192
compose_output_C_0:
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
  cmp.w r0, lr
  bne.w compose_output_C_0
  add.w r0, r0, #960
  vmov.w lr, s1
  cmp.w r0, lr
  bne.w compose_output_0_body
  sub.w lr, r0, #192
  sub.w r12, r0, #20736
compose_output_0_jump:
  add.w r11, r12, #384
compose_output_D_0:
  ldm.w r12, {r1-r4}
  ldm.w lr!, {r5-r8}
  sub.w r1, r5, r1
  sub.w r2, r6, r2
  sub.w r3, r7, r3
  sub.w r4, r8, r4
  stm.w r12!, {r1-r4}
  cmp.w r12, r11
  bne.w compose_output_D_0
  add.w r12, r12, #384
  cmp.w r12, r0
  bne.w compose_output_0_jump
  sub.w r0, r12, #384
  sub.w r0, r0, #3776
  sub.w r0, r0, #16384
  add.w lr, r0, #13824
  vmov.w s1, lr
compose_output_1_body:
  add.w lr, r0, #384
compose_output_A_1:
  ldm.w r0, {r1-r6}
  ldr.w r7, [r0, #384]
  ldr.w r8, [r0, #388]
  ldr.w r9, [r0, #392]
  ldr.w r10, [r0, #396]
  ldr.w r11, [r0, #400]
  ldr.w r12, [r0, #404]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  stm.w r0!, {r1-r6}
  cmp.w r0, lr
  bne.w compose_output_A_1
  sub.w lr, lr, #384
compose_output_B_1:
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
  cmp.w r0, lr
  bne.w compose_output_B_1
  sub.w lr, lr, #384
compose_output_C_1:
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
  cmp.w r0, lr
  bne.w compose_output_C_1
  add.w r0, r0, #1920
  vmov.w lr, s1
  cmp.w r0, lr
  bne.w compose_output_1_body
  sub.w lr, r0, #384
  sub.w r12, r0, #13824
compose_output_1_jump:
  add.w r11, r12, #768
compose_output_D_1:
  ldm.w r12, {r1-r4}
  ldm.w lr!, {r5-r8}
  sub.w r1, r5, r1
  sub.w r2, r6, r2
  sub.w r3, r7, r3
  sub.w r4, r8, r4
  stm.w r12!, {r1-r4}
  cmp.w r12, r11
  bne.w compose_output_D_1
  add.w r12, r12, #768
  cmp.w r12, r0
  bne.w compose_output_1_jump
  sub.w r0, r12, #768
  sub.w r0, r0, #12672
  add.w lr, r0, #9216
  vmov.w s1, lr
compose_output_2_body:
  add.w lr, r0, #768
compose_output_A_2:
  ldm.w r0, {r1-r6}
  ldr.w r7, [r0, #768]
  ldr.w r8, [r0, #772]
  ldr.w r9, [r0, #776]
  ldr.w r10, [r0, #780]
  ldr.w r11, [r0, #784]
  ldr.w r12, [r0, #788]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  stm.w r0!, {r1-r6}
  cmp.w r0, lr
  bne.w compose_output_A_2
  sub.w lr, lr, #768
compose_output_B_2:
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #1536]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #1536]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #1536]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #1536]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #1536]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #1536]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #788]
  str.w r2, [r0, #784]
  str.w r3, [r0, #780]
  str.w r4, [r0, #776]
  str.w r5, [r0, #772]
  str.w r6, [r0, #768]
  cmp.w r0, lr
  bne.w compose_output_B_2
  sub.w lr, lr, #768
compose_output_C_2:
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
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #788]
  str.w r2, [r0, #784]
  str.w r3, [r0, #780]
  str.w r4, [r0, #776]
  str.w r5, [r0, #772]
  str.w r6, [r0, #768]
  cmp.w r0, lr
  bne.w compose_output_C_2
  add.w r0, r0, #3840
  vmov.w lr, s1
  cmp.w r0, lr
  bne.w compose_output_2_body
  sub.w lr, r0, #768
  sub.w r12, r0, #9216
compose_output_2_jump:
  add.w r11, r12, #1536
compose_output_D_2:
  ldm.w r12, {r1-r4}
  ldm.w lr!, {r5-r8}
  sub.w r1, r5, r1
  sub.w r2, r6, r2
  sub.w r3, r7, r3
  sub.w r4, r8, r4
  stm.w r12!, {r1-r4}
  cmp.w r12, r11
  bne.w compose_output_D_2
  add.w r12, r12, #1536
  cmp.w r12, r0
  bne.w compose_output_2_jump
  sub.w r0, r12, #1536
  sub.w r0, r0, #6912
  add.w lr, r0, #6144
  vmov.w s1, lr
compose_output_3_body:
  add.w lr, r0, #1536
compose_output_A_3:
  ldm.w r0, {r1-r6}
  ldr.w r7, [r0, #1536]
  ldr.w r8, [r0, #1540]
  ldr.w r9, [r0, #1544]
  ldr.w r10, [r0, #1548]
  ldr.w r11, [r0, #1552]
  ldr.w r12, [r0, #1556]
  sub.w r1, r7, r1
  sub.w r2, r8, r2
  sub.w r3, r9, r3
  sub.w r4, r10, r4
  sub.w r5, r11, r5
  sub.w r6, r12, r6
  stm.w r0!, {r1-r6}
  cmp.w r0, lr
  bne.w compose_output_A_3
  sub.w lr, lr, #1536
compose_output_B_3:
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #3072]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #3072]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #3072]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #3072]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #3072]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #3072]
  sub.w r1, r1, r7
  sub.w r2, r2, r8
  sub.w r3, r3, r9
  sub.w r4, r4, r10
  sub.w r5, r5, r11
  sub.w r6, r6, r12
  str.w r1, [r0, #1556]
  str.w r2, [r0, #1552]
  str.w r3, [r0, #1548]
  str.w r4, [r0, #1544]
  str.w r5, [r0, #1540]
  str.w r6, [r0, #1536]
  cmp.w r0, lr
  bne.w compose_output_B_3
  sub.w lr, lr, #1536
compose_output_C_3:
  ldr.w r7, [r0, #-4]!
  ldr.w r1, [r0, #1536]
  ldr.w r8, [r0, #-4]!
  ldr.w r2, [r0, #1536]
  ldr.w r9, [r0, #-4]!
  ldr.w r3, [r0, #1536]
  ldr.w r10, [r0, #-4]!
  ldr.w r4, [r0, #1536]
  ldr.w r11, [r0, #-4]!
  ldr.w r5, [r0, #1536]
  ldr.w r12, [r0, #-4]!
  ldr.w r6, [r0, #1536]
  add.w r1, r1, r7
  add.w r2, r2, r8
  add.w r3, r3, r9
  add.w r4, r4, r10
  add.w r5, r5, r11
  add.w r6, r6, r12
  str.w r1, [r0, #1556]
  str.w r2, [r0, #1552]
  str.w r3, [r0, #1548]
  str.w r4, [r0, #1544]
  str.w r5, [r0, #1540]
  str.w r6, [r0, #1536]
  cmp.w r0, lr
  bne.w compose_output_C_3
  add.w r0, r0, #7680
  vmov.w lr, s1
  cmp.w r0, lr
  bne.w compose_output_3_body
  sub.w lr, r0, #1536
  sub.w r12, r0, #6144
compose_output_3_jump:
  add.w r11, r12, #3072
compose_output_D_3:
  ldm.w r12, {r1-r4}
  ldm.w lr!, {r5-r8}
  sub.w r1, r5, r1
  sub.w r2, r6, r2
  sub.w r3, r7, r3
  sub.w r4, r8, r4
  stm.w r12!, {r1-r4}
  cmp.w r12, r11
  bne.w compose_output_D_3
  add.w r12, r12, #3072
  cmp.w r12, r0
  bne.w compose_output_3_jump
  sub.w r0, r12, #7680
  vmov.w lr, s0
  movw.w r12, #18015
  movt.w r12, #14
  movw.w r11, #4591
  add.w r1, r0, #6144
copy_output_body:
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
  bne.w copy_output_body
  ldm.w r0!, {r2-r9}
  stm.w lr!, {r2-r9}
  add.w sp, sp, #1600
  add.w sp, sp, #45056
  pop.w {r4-r12, pc}
