#include "red-asm.h"
// N=256 requires 4608=8x576 storage

#include "polymul_256x256_bar_B64_aux.h"
	.p2align	2,,3	
	.syntax		unified
	.text
// void gf_polymul_256x256 (int32_t *h, int32_t *f, int32_t *g);
	.global gf_polymul_256x256
	.type	gf_polymul_256x256, %function
gf_polymul_256x256:
	push.w	{r4-r11,lr}
	vpush.w	{s16-s31}
	movw.w	r12, #1152	// r12=2M
	sub.w	sp, sp, r12, LSL #2	// subtract 4608 = 8M
		// ff=[sp], gg=[sp,#1152], hh=[sp,#2304]
	vmov.w	s0, r0	// save h
	mov.w	r3, sp
	add.w	r0, sp, r12	// gg=ff+1152(=2M)
	vmov.w	s1, r12	// save 2M
	vmov.w	s2, r0	// save gg (ff=sp)
	add.w	r14, r0, r12	// hh=gg+1152(=2M)
	vmov.w	s3, r14	// save h
	movw.w	r14, #:lower16:KA_exp_ov_256
	movt.w	r14, #:upper16:KA_exp_ov_256
	vmov.w	s4, r14	// save ov pointer
	movw.w	r12, #4591
	movw.w	r14, #15631
	vmov.w	s6, r14	// save qinv
	rsb.w	r12, r12, #0		// -q
	vmov.w	s8, r12	// save -q
	movw.w	r14, #18015
	movt.w	r14, #14
	vmov.w	s7, r14	// save q32inv
	mov.w	r14, #512
KA256_mv_loop:	// r0 = gg, r1 = f, r2 = g, r3 = ff
	ldm.w	r1!, {r4-r11}
	stm.w	r3!, {r4-r11}
	ldm.w	r2!, {r4-r11}
	stm.w	r0!, {r4-r11}
	subs.w	r14, #32
	bne.w	KA256_mv_loop
KA256_exp:	// ff @ sp, gg @ sp + 2M, 2M @ r12
	vmov.w	r12, s1  // reload 2M
	mov.w	r0, sp		// ff = r0
	add.w	r1, r0, r12	// gg = r1
	mov.w	r2, #256		// N0 = r2 = N
	vmov.w	r3, s4  // load list to reduce
KA256_exp_loop1:		// loop on N0
	cmp.w	r2, #64		// while (N0>B)
	beq.w	KA256_exp_end1
KA256_exp_reduce:		// reduce ff[], gg[]
	ldrsh.w	r4, [r3], #2	// list entry
	cmp.w	r4, #-1		// end of this list?
	beq.w	KA256_exp_adds	// only if -1 end
	vmov.w	r6, s8  // load -q
	vmov.w	r7, s7  // load q32inv
	mov.w	r10, #32768	// load 2^15
KA256_exp_red1:
	ldrsh.w	r5, [r3], #2	// reduce ff[r4-r5], gg[r4-r5]
KA256_exp_red2:			// while loop on r4
	ldr.w	r8, [r0, r4, LSL #2]	// ff[r4]
	ldr.w	r9, [r1, r4, LSL #2]	// gg[r4]
	br_16x2	r8, r6, r7, r10, r11, r12
	str.w	r8, [r0, r4, LSL #2]	// ff[r4] %= q
	add.w	r4, #1
	cmp.w	r4, r5		// r4 > r5?
	bls.w	KA256_exp_red2	// loop (r4)
	ldrsh.w	r4, [r3], #2	// re-load list entry
	cmp.w	r4, #-1		// re-check, end of list?
	bne.w	KA256_exp_red1
KA256_exp_adds:
/*
  for (j=0; j<N1/2/W; j+=N0/2/W) {
    for (k=0; k<N0/2/W; k++) {
     ff[j+k+N1/W]=__SADD16(ff[2*j+k],ff[2*j+k+N0/2/W]);
     gg[j+k+N1/W]=__SADD16(gg[2*j+k],gg[2*j+k+N0/2/W]);
    }
*/
	ldrsh.w	r4, [r3], #2		// load N1/W/2
	add.w	r5, r0, r4, LSL #3	// r5 = ff + N1/W
	add.w	r6, r1, r4, LSL #3	// r6 = gg + N1/W
	add.w	r0, r0, r2		// r0 = ff + N0/2/W
	add.w	r1, r1, r2		// r1 = gg + N0/2/W
	rsb.w	r2, r2, #0			// r2 = -N0
	mov.w	r12, r2
KA256_exp_adds1:
	ldr.w	r8, [r0, r2]
	ldr.w	r10, [r0], #4
	ldr.w	r9, [r0, r2]
	ldr.w	r11, [r0], #4
	sadd16.w	r8, r8, r10
	sadd16.w	r9, r9, r11
	strd.w	r8, r9, [r5], #8
	ldr.w	r8, [r1, r2]
	ldr.w	r10, [r1], #4
	ldr.w	r9, [r1, r2]
	ldr.w	r11, [r1], #4
	sadd16.w	r8, r8, r10
	sadd16.w	r9, r9, r11
	strd.w	r8, r9, [r6], #8
	subs.w	r4, r4, #2
	beq.w	KA256_exp_end
	adds.w	r12, r12, #8
	nop.n
	ittt	eq		// divisible by N0/2/W?
	subeq.w	r0, r0, r2	// then add N0!
	subeq.w	r1, r1, r2	// then add N0!
	moveq.w	r12, r2		// reload with N0
	b.w	KA256_exp_adds1
KA256_exp_end:
	rsb.w	r2, r2, #0
	mov.w	r0, sp		// reload ff
	vmov.w	r1, s2  // reload gg

	lsr.w	r2, #1 		// N0 /= 2
	b.w	KA256_exp_loop1	// loop
KA256_exp_end1:

KA256_mul:
  // check multiplicative overflow (pre-mult size > q_mb=1)
KA256_mul_ov:
	ldrsh.w	r2, [r3], #2
	cmp.w	r2, #-1		// multiplicative overflow?
	beq.w	KA256_muls
	mov.w	r8, #32768
	vmov.w	r6, s8  // load -q
	vmov.w	r7, s7  // load round(2^32/q)
KA256_mul_ov1:
	ldrsh.w	r11, [r3], #2
KA256_mul_ov2:
	ldr.w	r4, [r0, r2, LSL #2]
	ldr.w	r5, [r1, r2, LSL #2]
	br_16x2	r4, r6, r7, r8, r9, r10
	br_16x2	r5, r6, r7, r8, r9, r10
	str.w	r4, [r0, r2, LSL #2]
	str.w	r5, [r1, r2, LSL #2]
	add.w	r2, r2, #1
	cmp.w	r2, r11
	bls.w	KA256_mul_ov2
	ldrsh.w	r2, [r3], #2
	cmp.w	r2, -1
	bne.w	KA256_mul_ov1
KA256_muls:
	ldrsh.w	r14, [r3], #2	// r14 = N1/B
	vmov.w	s4, r3	// save overflow list pointer
	vmov.w	r2, s3  // load r2 = hh
KA256_muls1:
	vmov.w	s9, r14	// save counter to scr0
	ldr.w	r12, [r1]
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r0]
	ldr.w	r4, [r0, #4]
	// block (0,0)
	smuadx.w	r6, r3, r12
	smuadx.w	r8, r4, r12
	smladx.w	r8, r3, r14, r8
	smuadx.w	r10, r4, r14
	smulbb.w	r5, r3, r12
	smulbb.w	r7, r3, r14
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smuad.w	r9, r3, r14
	smlatt.w	r9, r4, r12, r9
	smultt.w	r11, r4, r14
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r5, r6, r3, r12, r4
	br_32x2	r7, r8, r3, r12, r4
	str.w	r5, [r2], #4
	str.w	r7, [r2], #4
	ldr.w	r3, [r0, #8]
	ldr.w	r4, [r0, #12]
	ldr.w	r12, [r1, #0]
	// block (1,0)
	smladx.w	r10, r3, r12, r10
	smuadx.w	r5, r4, r12
	smladx.w	r5, r3, r14, r5
	smuadx.w	r7, r4, r14
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smuad.w	r6, r3, r14
	smlatt.w	r6, r4, r12, r6
	smultt.w	r8, r4, r14
	// block (0,1)
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r0, #0]
	ldr.w	r4, [r0, #4]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r9, r10, r3, r12, r14
	br_32x2	r11, r5, r3, r12, r14
	str.w	r9, [r2], #4
	str.w	r11, [r2], #4
	ldr.w	r3, [r0, #0]
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r1, #20]
	// block (0,2)
	smladx.w	r7, r3, r12, r7
	smuadx.w	r9, r4, r12
	smladx.w	r9, r3, r14, r9
	smuadx.w	r11, r4, r14
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smuad.w	r10, r3, r14
	smlatt.w	r10, r4, r12, r10
	smultt.w	r5, r4, r14
	// block (1,1)
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r0, #8]
	ldr.w	r4, [r0, #12]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (2,0)
	ldr.w	r12, [r1, #0]
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r0, #16]
	ldr.w	r4, [r0, #20]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r6, r7, r3, r12, r4
	br_32x2	r8, r9, r3, r12, r4
	str.w	r6, [r2], #4
	str.w	r8, [r2], #4
	ldr.w	r3, [r0, #24]
	ldr.w	r4, [r0, #28]
	ldr.w	r12, [r1, #0]
	// block (3,0)
	smladx.w	r11, r3, r12, r11
	smuadx.w	r6, r4, r12
	smladx.w	r6, r3, r14, r6
	smuadx.w	r8, r4, r14
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smuad.w	r7, r3, r14
	smlatt.w	r7, r4, r12, r7
	smultt.w	r9, r4, r14
	// block (2,1)
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r0, #16]
	ldr.w	r4, [r0, #20]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (1,2)
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r0, #8]
	ldr.w	r4, [r0, #12]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (0,3)
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r0, #0]
	ldr.w	r4, [r0, #4]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r10, r11, r3, r12, r14
	br_32x2	r5, r6, r3, r12, r14
	str.w	r10, [r2], #4
	str.w	r5, [r2], #4
	ldr.w	r3, [r0, #0]
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r1, #36]
	// block (0,4)
	smladx.w	r8, r3, r12, r8
	smuadx.w	r10, r4, r12
	smladx.w	r10, r3, r14, r10
	smuadx.w	r5, r4, r14
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smuad.w	r11, r3, r14
	smlatt.w	r11, r4, r12, r11
	smultt.w	r6, r4, r14
	// block (1,3)
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r0, #8]
	ldr.w	r4, [r0, #12]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (2,2)
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r0, #16]
	ldr.w	r4, [r0, #20]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (3,1)
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r0, #24]
	ldr.w	r4, [r0, #28]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (4,0)
	ldr.w	r12, [r1, #0]
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r0, #32]
	ldr.w	r4, [r0, #36]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r7, r8, r3, r12, r4
	br_32x2	r9, r10, r3, r12, r4
	str.w	r7, [r2], #4
	str.w	r9, [r2], #4
	ldr.w	r3, [r0, #40]
	ldr.w	r4, [r0, #44]
	ldr.w	r12, [r1, #0]
	// block (5,0)
	smladx.w	r5, r3, r12, r5
	smuadx.w	r7, r4, r12
	smladx.w	r7, r3, r14, r7
	smuadx.w	r9, r4, r14
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smuad.w	r8, r3, r14
	smlatt.w	r8, r4, r12, r8
	smultt.w	r10, r4, r14
	// block (4,1)
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r0, #32]
	ldr.w	r4, [r0, #36]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (3,2)
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r0, #24]
	ldr.w	r4, [r0, #28]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (2,3)
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r0, #16]
	ldr.w	r4, [r0, #20]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (1,4)
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r0, #8]
	ldr.w	r4, [r0, #12]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (0,5)
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r0, #0]
	ldr.w	r4, [r0, #4]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r11, r5, r3, r12, r14
	br_32x2	r6, r7, r3, r12, r14
	str.w	r11, [r2], #4
	str.w	r6, [r2], #4
	ldr.w	r3, [r0, #0]
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r1, #52]
	// block (0,6)
	smladx.w	r9, r3, r12, r9
	smuadx.w	r11, r4, r12
	smladx.w	r11, r3, r14, r11
	smuadx.w	r6, r4, r14
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smuad.w	r5, r3, r14
	smlatt.w	r5, r4, r12, r5
	smultt.w	r7, r4, r14
	// block (1,5)
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r0, #8]
	ldr.w	r4, [r0, #12]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (2,4)
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r0, #16]
	ldr.w	r4, [r0, #20]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (3,3)
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r0, #24]
	ldr.w	r4, [r0, #28]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (4,2)
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r0, #32]
	ldr.w	r4, [r0, #36]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (5,1)
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r0, #40]
	ldr.w	r4, [r0, #44]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (6,0)
	ldr.w	r12, [r1, #0]
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r0, #48]
	ldr.w	r4, [r0, #52]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r8, r9, r3, r12, r4
	br_32x2	r10, r11, r3, r12, r4
	str.w	r8, [r2], #4
	str.w	r10, [r2], #4
	ldr.w	r3, [r0, #56]
	ldr.w	r4, [r0, #60]
	ldr.w	r12, [r1, #0]
	// block (7,0)
	smladx.w	r6, r3, r12, r6
	smuadx.w	r8, r4, r12
	smladx.w	r8, r3, r14, r8
	smuadx.w	r10, r4, r14
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smuad.w	r9, r3, r14
	smlatt.w	r9, r4, r12, r9
	smultt.w	r11, r4, r14
	// block (6,1)
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r0, #48]
	ldr.w	r4, [r0, #52]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (5,2)
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r0, #40]
	ldr.w	r4, [r0, #44]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (4,3)
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r0, #32]
	ldr.w	r4, [r0, #36]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (3,4)
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r0, #24]
	ldr.w	r4, [r0, #28]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (2,5)
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r0, #16]
	ldr.w	r4, [r0, #20]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (1,6)
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r0, #8]
	ldr.w	r4, [r0, #12]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (0,7)
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r0, #0]
	ldr.w	r4, [r0, #4]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r5, r6, r3, r12, r14
	br_32x2	r7, r8, r3, r12, r14
	str.w	r5, [r2], #4
	str.w	r7, [r2], #4
	ldr.w	r3, [r0, #0]
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r1, #68]
	// block (0,8)
	smladx.w	r10, r3, r12, r10
	smuadx.w	r5, r4, r12
	smladx.w	r5, r3, r14, r5
	smuadx.w	r7, r4, r14
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smuad.w	r6, r3, r14
	smlatt.w	r6, r4, r12, r6
	smultt.w	r8, r4, r14
	// block (1,7)
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r0, #8]
	ldr.w	r4, [r0, #12]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (2,6)
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r0, #16]
	ldr.w	r4, [r0, #20]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (3,5)
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r0, #24]
	ldr.w	r4, [r0, #28]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (4,4)
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r0, #32]
	ldr.w	r4, [r0, #36]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (5,3)
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r0, #40]
	ldr.w	r4, [r0, #44]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (6,2)
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r0, #48]
	ldr.w	r4, [r0, #52]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (7,1)
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r0, #56]
	ldr.w	r4, [r0, #60]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (8,0)
	ldr.w	r12, [r1, #0]
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r0, #64]
	ldr.w	r4, [r0, #68]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r9, r10, r3, r12, r4
	br_32x2	r11, r5, r3, r12, r4
	str.w	r9, [r2], #4
	str.w	r11, [r2], #4
	ldr.w	r3, [r0, #72]
	ldr.w	r4, [r0, #76]
	ldr.w	r12, [r1, #0]
	// block (9,0)
	smladx.w	r7, r3, r12, r7
	smuadx.w	r9, r4, r12
	smladx.w	r9, r3, r14, r9
	smuadx.w	r11, r4, r14
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smuad.w	r10, r3, r14
	smlatt.w	r10, r4, r12, r10
	smultt.w	r5, r4, r14
	// block (8,1)
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r0, #64]
	ldr.w	r4, [r0, #68]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (7,2)
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r0, #56]
	ldr.w	r4, [r0, #60]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (6,3)
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r0, #48]
	ldr.w	r4, [r0, #52]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (5,4)
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r0, #40]
	ldr.w	r4, [r0, #44]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (4,5)
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r0, #32]
	ldr.w	r4, [r0, #36]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (3,6)
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r0, #24]
	ldr.w	r4, [r0, #28]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (2,7)
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r0, #16]
	ldr.w	r4, [r0, #20]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (1,8)
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r0, #8]
	ldr.w	r4, [r0, #12]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (0,9)
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r0, #0]
	ldr.w	r4, [r0, #4]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r6, r7, r3, r12, r14
	br_32x2	r8, r9, r3, r12, r14
	str.w	r6, [r2], #4
	str.w	r8, [r2], #4
	ldr.w	r3, [r0, #0]
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r1, #84]
	// block (0,10)
	smladx.w	r11, r3, r12, r11
	smuadx.w	r6, r4, r12
	smladx.w	r6, r3, r14, r6
	smuadx.w	r8, r4, r14
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smuad.w	r7, r3, r14
	smlatt.w	r7, r4, r12, r7
	smultt.w	r9, r4, r14
	// block (1,9)
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r0, #8]
	ldr.w	r4, [r0, #12]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (2,8)
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r0, #16]
	ldr.w	r4, [r0, #20]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (3,7)
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r0, #24]
	ldr.w	r4, [r0, #28]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (4,6)
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r0, #32]
	ldr.w	r4, [r0, #36]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (5,5)
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r0, #40]
	ldr.w	r4, [r0, #44]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (6,4)
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r0, #48]
	ldr.w	r4, [r0, #52]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (7,3)
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r0, #56]
	ldr.w	r4, [r0, #60]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (8,2)
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r0, #64]
	ldr.w	r4, [r0, #68]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (9,1)
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r0, #72]
	ldr.w	r4, [r0, #76]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (10,0)
	ldr.w	r12, [r1, #0]
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r0, #80]
	ldr.w	r4, [r0, #84]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r10, r11, r3, r12, r4
	br_32x2	r5, r6, r3, r12, r4
	str.w	r10, [r2], #4
	str.w	r5, [r2], #4
	ldr.w	r3, [r0, #88]
	ldr.w	r4, [r0, #92]
	ldr.w	r12, [r1, #0]
	// block (11,0)
	smladx.w	r8, r3, r12, r8
	smuadx.w	r10, r4, r12
	smladx.w	r10, r3, r14, r10
	smuadx.w	r5, r4, r14
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smuad.w	r11, r3, r14
	smlatt.w	r11, r4, r12, r11
	smultt.w	r6, r4, r14
	// block (10,1)
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r0, #80]
	ldr.w	r4, [r0, #84]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (9,2)
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r0, #72]
	ldr.w	r4, [r0, #76]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (8,3)
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r0, #64]
	ldr.w	r4, [r0, #68]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (7,4)
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r0, #56]
	ldr.w	r4, [r0, #60]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (6,5)
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r0, #48]
	ldr.w	r4, [r0, #52]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (5,6)
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r0, #40]
	ldr.w	r4, [r0, #44]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (4,7)
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r0, #32]
	ldr.w	r4, [r0, #36]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (3,8)
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r0, #24]
	ldr.w	r4, [r0, #28]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (2,9)
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r0, #16]
	ldr.w	r4, [r0, #20]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (1,10)
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r0, #8]
	ldr.w	r4, [r0, #12]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (0,11)
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r0, #0]
	ldr.w	r4, [r0, #4]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r7, r8, r3, r12, r14
	br_32x2	r9, r10, r3, r12, r14
	str.w	r7, [r2], #4
	str.w	r9, [r2], #4
	ldr.w	r3, [r0, #0]
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r1, #100]
	// block (0,12)
	smladx.w	r5, r3, r12, r5
	smuadx.w	r7, r4, r12
	smladx.w	r7, r3, r14, r7
	smuadx.w	r9, r4, r14
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smuad.w	r8, r3, r14
	smlatt.w	r8, r4, r12, r8
	smultt.w	r10, r4, r14
	// block (1,11)
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r0, #8]
	ldr.w	r4, [r0, #12]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (2,10)
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r0, #16]
	ldr.w	r4, [r0, #20]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (3,9)
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r0, #24]
	ldr.w	r4, [r0, #28]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (4,8)
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r0, #32]
	ldr.w	r4, [r0, #36]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (5,7)
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r0, #40]
	ldr.w	r4, [r0, #44]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (6,6)
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r0, #48]
	ldr.w	r4, [r0, #52]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (7,5)
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r0, #56]
	ldr.w	r4, [r0, #60]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (8,4)
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r0, #64]
	ldr.w	r4, [r0, #68]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (9,3)
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r0, #72]
	ldr.w	r4, [r0, #76]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (10,2)
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r0, #80]
	ldr.w	r4, [r0, #84]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (11,1)
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r0, #88]
	ldr.w	r4, [r0, #92]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (12,0)
	ldr.w	r12, [r1, #0]
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r0, #96]
	ldr.w	r4, [r0, #100]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r11, r5, r3, r12, r4
	br_32x2	r6, r7, r3, r12, r4
	str.w	r11, [r2], #4
	str.w	r6, [r2], #4
	ldr.w	r3, [r0, #104]
	ldr.w	r4, [r0, #108]
	ldr.w	r12, [r1, #0]
	// block (13,0)
	smladx.w	r9, r3, r12, r9
	smuadx.w	r11, r4, r12
	smladx.w	r11, r3, r14, r11
	smuadx.w	r6, r4, r14
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smuad.w	r5, r3, r14
	smlatt.w	r5, r4, r12, r5
	smultt.w	r7, r4, r14
	// block (12,1)
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r0, #96]
	ldr.w	r4, [r0, #100]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (11,2)
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r0, #88]
	ldr.w	r4, [r0, #92]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (10,3)
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r0, #80]
	ldr.w	r4, [r0, #84]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (9,4)
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r0, #72]
	ldr.w	r4, [r0, #76]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (8,5)
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r0, #64]
	ldr.w	r4, [r0, #68]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (7,6)
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r0, #56]
	ldr.w	r4, [r0, #60]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (6,7)
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r0, #48]
	ldr.w	r4, [r0, #52]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (5,8)
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r0, #40]
	ldr.w	r4, [r0, #44]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (4,9)
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r0, #32]
	ldr.w	r4, [r0, #36]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (3,10)
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r0, #24]
	ldr.w	r4, [r0, #28]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (2,11)
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r0, #16]
	ldr.w	r4, [r0, #20]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (1,12)
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r0, #8]
	ldr.w	r4, [r0, #12]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (0,13)
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r0, #0]
	ldr.w	r4, [r0, #4]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r8, r9, r3, r12, r14
	br_32x2	r10, r11, r3, r12, r14
	str.w	r8, [r2], #4
	str.w	r10, [r2], #4
	ldr.w	r3, [r0, #0]
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r1, #116]
	// block (0,14)
	smladx.w	r6, r3, r12, r6
	smuadx.w	r8, r4, r12
	smladx.w	r8, r3, r14, r8
	smuadx.w	r10, r4, r14
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smuad.w	r9, r3, r14
	smlatt.w	r9, r4, r12, r9
	smultt.w	r11, r4, r14
	// block (1,13)
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r0, #8]
	ldr.w	r4, [r0, #12]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (2,12)
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r0, #16]
	ldr.w	r4, [r0, #20]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (3,11)
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r0, #24]
	ldr.w	r4, [r0, #28]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (4,10)
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r0, #32]
	ldr.w	r4, [r0, #36]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (5,9)
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r0, #40]
	ldr.w	r4, [r0, #44]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (6,8)
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r0, #48]
	ldr.w	r4, [r0, #52]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (7,7)
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r0, #56]
	ldr.w	r4, [r0, #60]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (8,6)
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r0, #64]
	ldr.w	r4, [r0, #68]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (9,5)
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r0, #72]
	ldr.w	r4, [r0, #76]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (10,4)
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r0, #80]
	ldr.w	r4, [r0, #84]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (11,3)
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r0, #88]
	ldr.w	r4, [r0, #92]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (12,2)
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r0, #96]
	ldr.w	r4, [r0, #100]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (13,1)
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r0, #104]
	ldr.w	r4, [r0, #108]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (14,0)
	ldr.w	r12, [r1, #0]
	ldr.w	r14, [r1, #4]
	ldr.w	r3, [r0, #112]
	ldr.w	r4, [r0, #116]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r5, r6, r3, r12, r4
	br_32x2	r7, r8, r3, r12, r4
	str.w	r5, [r2], #4
	str.w	r7, [r2], #4
	ldr.w	r3, [r0, #120]
	ldr.w	r4, [r0, #124]
	ldr.w	r12, [r1, #0]
	// block (15,0)
	smladx.w	r10, r3, r12, r10
	smuadx.w	r5, r4, r12
	smladx.w	r5, r3, r14, r5
	smuadx.w	r7, r4, r14
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smuad.w	r6, r3, r14
	smlatt.w	r6, r4, r12, r6
	smultt.w	r8, r4, r14
	// block (14,1)
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r0, #112]
	ldr.w	r4, [r0, #116]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (13,2)
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r0, #104]
	ldr.w	r4, [r0, #108]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (12,3)
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r0, #96]
	ldr.w	r4, [r0, #100]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (11,4)
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r0, #88]
	ldr.w	r4, [r0, #92]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (10,5)
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r0, #80]
	ldr.w	r4, [r0, #84]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (9,6)
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r0, #72]
	ldr.w	r4, [r0, #76]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (8,7)
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r0, #64]
	ldr.w	r4, [r0, #68]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (7,8)
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r0, #56]
	ldr.w	r4, [r0, #60]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (6,9)
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r0, #48]
	ldr.w	r4, [r0, #52]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (5,10)
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r0, #40]
	ldr.w	r4, [r0, #44]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (4,11)
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r0, #32]
	ldr.w	r4, [r0, #36]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (3,12)
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r0, #24]
	ldr.w	r4, [r0, #28]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (2,13)
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r0, #16]
	ldr.w	r4, [r0, #20]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (1,14)
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r0, #8]
	ldr.w	r4, [r0, #12]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (0,15)
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r0, #0]
	ldr.w	r4, [r0, #4]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r9, r10, r3, r12, r4
	br_32x2	r11, r5, r3, r12, r4
	str.w	r9, [r2], #4
	str.w	r11, [r2], #4
	ldr.w	r3, [r0, #8]
	ldr.w	r4, [r0, #12]
	ldr.w	r12, [r1, #120]
	// block (1,15)
	smladx.w	r7, r3, r12, r7
	smuadx.w	r9, r4, r12
	smladx.w	r9, r3, r14, r9
	smuadx.w	r11, r4, r14
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smuad.w	r10, r3, r14
	smlatt.w	r10, r4, r12, r10
	smultt.w	r5, r4, r14
	// block (2,14)
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r0, #16]
	ldr.w	r4, [r0, #20]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (3,13)
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r0, #24]
	ldr.w	r4, [r0, #28]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (4,12)
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r0, #32]
	ldr.w	r4, [r0, #36]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (5,11)
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r0, #40]
	ldr.w	r4, [r0, #44]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (6,10)
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r0, #48]
	ldr.w	r4, [r0, #52]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (7,9)
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r0, #56]
	ldr.w	r4, [r0, #60]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (8,8)
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r0, #64]
	ldr.w	r4, [r0, #68]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (9,7)
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r0, #72]
	ldr.w	r4, [r0, #76]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (10,6)
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r0, #80]
	ldr.w	r4, [r0, #84]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (11,5)
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r0, #88]
	ldr.w	r4, [r0, #92]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (12,4)
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r0, #96]
	ldr.w	r4, [r0, #100]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (13,3)
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r0, #104]
	ldr.w	r4, [r0, #108]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (14,2)
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r1, #20]
	ldr.w	r3, [r0, #112]
	ldr.w	r4, [r0, #116]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (15,1)
	ldr.w	r12, [r1, #8]
	ldr.w	r14, [r1, #12]
	ldr.w	r3, [r0, #120]
	ldr.w	r4, [r0, #124]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r6, r7, r3, r12, r14
	br_32x2	r8, r9, r3, r12, r14
	str.w	r6, [r2], #4
	str.w	r8, [r2], #4
	ldr.w	r3, [r0, #120]
	ldr.w	r12, [r1, #16]
	ldr.w	r14, [r1, #20]
	// block (15,2)
	smladx.w	r11, r3, r12, r11
	smuadx.w	r6, r4, r12
	smladx.w	r6, r3, r14, r6
	smuadx.w	r8, r4, r14
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smuad.w	r7, r3, r14
	smlatt.w	r7, r4, r12, r7
	smultt.w	r9, r4, r14
	// block (14,3)
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r0, #112]
	ldr.w	r4, [r0, #116]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (13,4)
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r0, #104]
	ldr.w	r4, [r0, #108]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (12,5)
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r0, #96]
	ldr.w	r4, [r0, #100]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (11,6)
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r0, #88]
	ldr.w	r4, [r0, #92]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (10,7)
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r0, #80]
	ldr.w	r4, [r0, #84]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (9,8)
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r0, #72]
	ldr.w	r4, [r0, #76]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (8,9)
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r0, #64]
	ldr.w	r4, [r0, #68]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (7,10)
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r0, #56]
	ldr.w	r4, [r0, #60]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (6,11)
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r0, #48]
	ldr.w	r4, [r0, #52]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (5,12)
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r0, #40]
	ldr.w	r4, [r0, #44]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (4,13)
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r0, #32]
	ldr.w	r4, [r0, #36]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (3,14)
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r0, #24]
	ldr.w	r4, [r0, #28]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (2,15)
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r0, #16]
	ldr.w	r4, [r0, #20]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r10, r11, r3, r12, r4
	br_32x2	r5, r6, r3, r12, r4
	str.w	r10, [r2], #4
	str.w	r5, [r2], #4
	ldr.w	r3, [r0, #24]
	ldr.w	r4, [r0, #28]
	ldr.w	r12, [r1, #120]
	// block (3,15)
	smladx.w	r8, r3, r12, r8
	smuadx.w	r10, r4, r12
	smladx.w	r10, r3, r14, r10
	smuadx.w	r5, r4, r14
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smuad.w	r11, r3, r14
	smlatt.w	r11, r4, r12, r11
	smultt.w	r6, r4, r14
	// block (4,14)
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r0, #32]
	ldr.w	r4, [r0, #36]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (5,13)
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r0, #40]
	ldr.w	r4, [r0, #44]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (6,12)
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r0, #48]
	ldr.w	r4, [r0, #52]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (7,11)
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r0, #56]
	ldr.w	r4, [r0, #60]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (8,10)
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r0, #64]
	ldr.w	r4, [r0, #68]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (9,9)
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r0, #72]
	ldr.w	r4, [r0, #76]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (10,8)
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r0, #80]
	ldr.w	r4, [r0, #84]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (11,7)
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r0, #88]
	ldr.w	r4, [r0, #92]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (12,6)
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r0, #96]
	ldr.w	r4, [r0, #100]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (13,5)
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r0, #104]
	ldr.w	r4, [r0, #108]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (14,4)
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r1, #36]
	ldr.w	r3, [r0, #112]
	ldr.w	r4, [r0, #116]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (15,3)
	ldr.w	r12, [r1, #24]
	ldr.w	r14, [r1, #28]
	ldr.w	r3, [r0, #120]
	ldr.w	r4, [r0, #124]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r7, r8, r3, r12, r14
	br_32x2	r9, r10, r3, r12, r14
	str.w	r7, [r2], #4
	str.w	r9, [r2], #4
	ldr.w	r3, [r0, #120]
	ldr.w	r12, [r1, #32]
	ldr.w	r14, [r1, #36]
	// block (15,4)
	smladx.w	r5, r3, r12, r5
	smuadx.w	r7, r4, r12
	smladx.w	r7, r3, r14, r7
	smuadx.w	r9, r4, r14
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smuad.w	r8, r3, r14
	smlatt.w	r8, r4, r12, r8
	smultt.w	r10, r4, r14
	// block (14,5)
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r0, #112]
	ldr.w	r4, [r0, #116]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (13,6)
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r0, #104]
	ldr.w	r4, [r0, #108]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (12,7)
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r0, #96]
	ldr.w	r4, [r0, #100]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (11,8)
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r0, #88]
	ldr.w	r4, [r0, #92]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (10,9)
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r0, #80]
	ldr.w	r4, [r0, #84]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (9,10)
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r0, #72]
	ldr.w	r4, [r0, #76]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (8,11)
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r0, #64]
	ldr.w	r4, [r0, #68]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (7,12)
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r0, #56]
	ldr.w	r4, [r0, #60]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (6,13)
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r0, #48]
	ldr.w	r4, [r0, #52]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (5,14)
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r0, #40]
	ldr.w	r4, [r0, #44]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (4,15)
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r0, #32]
	ldr.w	r4, [r0, #36]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r11, r5, r3, r12, r4
	br_32x2	r6, r7, r3, r12, r4
	str.w	r11, [r2], #4
	str.w	r6, [r2], #4
	ldr.w	r3, [r0, #40]
	ldr.w	r4, [r0, #44]
	ldr.w	r12, [r1, #120]
	// block (5,15)
	smladx.w	r9, r3, r12, r9
	smuadx.w	r11, r4, r12
	smladx.w	r11, r3, r14, r11
	smuadx.w	r6, r4, r14
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smuad.w	r5, r3, r14
	smlatt.w	r5, r4, r12, r5
	smultt.w	r7, r4, r14
	// block (6,14)
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r0, #48]
	ldr.w	r4, [r0, #52]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (7,13)
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r0, #56]
	ldr.w	r4, [r0, #60]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (8,12)
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r0, #64]
	ldr.w	r4, [r0, #68]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (9,11)
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r0, #72]
	ldr.w	r4, [r0, #76]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (10,10)
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r0, #80]
	ldr.w	r4, [r0, #84]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (11,9)
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r0, #88]
	ldr.w	r4, [r0, #92]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (12,8)
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r0, #96]
	ldr.w	r4, [r0, #100]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (13,7)
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r0, #104]
	ldr.w	r4, [r0, #108]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (14,6)
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r1, #52]
	ldr.w	r3, [r0, #112]
	ldr.w	r4, [r0, #116]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (15,5)
	ldr.w	r12, [r1, #40]
	ldr.w	r14, [r1, #44]
	ldr.w	r3, [r0, #120]
	ldr.w	r4, [r0, #124]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r8, r9, r3, r12, r14
	br_32x2	r10, r11, r3, r12, r14
	str.w	r8, [r2], #4
	str.w	r10, [r2], #4
	ldr.w	r3, [r0, #120]
	ldr.w	r12, [r1, #48]
	ldr.w	r14, [r1, #52]
	// block (15,6)
	smladx.w	r6, r3, r12, r6
	smuadx.w	r8, r4, r12
	smladx.w	r8, r3, r14, r8
	smuadx.w	r10, r4, r14
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smuad.w	r9, r3, r14
	smlatt.w	r9, r4, r12, r9
	smultt.w	r11, r4, r14
	// block (14,7)
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r0, #112]
	ldr.w	r4, [r0, #116]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (13,8)
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r0, #104]
	ldr.w	r4, [r0, #108]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (12,9)
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r0, #96]
	ldr.w	r4, [r0, #100]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (11,10)
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r0, #88]
	ldr.w	r4, [r0, #92]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (10,11)
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r0, #80]
	ldr.w	r4, [r0, #84]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (9,12)
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r0, #72]
	ldr.w	r4, [r0, #76]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (8,13)
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r0, #64]
	ldr.w	r4, [r0, #68]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (7,14)
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r0, #56]
	ldr.w	r4, [r0, #60]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (6,15)
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r0, #48]
	ldr.w	r4, [r0, #52]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r5, r6, r3, r12, r4
	br_32x2	r7, r8, r3, r12, r4
	str.w	r5, [r2], #4
	str.w	r7, [r2], #4
	ldr.w	r3, [r0, #56]
	ldr.w	r4, [r0, #60]
	ldr.w	r12, [r1, #120]
	// block (7,15)
	smladx.w	r10, r3, r12, r10
	smuadx.w	r5, r4, r12
	smladx.w	r5, r3, r14, r5
	smuadx.w	r7, r4, r14
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smuad.w	r6, r3, r14
	smlatt.w	r6, r4, r12, r6
	smultt.w	r8, r4, r14
	// block (8,14)
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r0, #64]
	ldr.w	r4, [r0, #68]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (9,13)
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r0, #72]
	ldr.w	r4, [r0, #76]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (10,12)
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r0, #80]
	ldr.w	r4, [r0, #84]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (11,11)
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r0, #88]
	ldr.w	r4, [r0, #92]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (12,10)
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r0, #96]
	ldr.w	r4, [r0, #100]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (13,9)
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r0, #104]
	ldr.w	r4, [r0, #108]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (14,8)
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r1, #68]
	ldr.w	r3, [r0, #112]
	ldr.w	r4, [r0, #116]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	// block (15,7)
	ldr.w	r12, [r1, #56]
	ldr.w	r14, [r1, #60]
	ldr.w	r3, [r0, #120]
	ldr.w	r4, [r0, #124]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r9, r10, r3, r12, r14
	br_32x2	r11, r5, r3, r12, r14
	str.w	r9, [r2], #4
	str.w	r11, [r2], #4
	ldr.w	r3, [r0, #120]
	ldr.w	r12, [r1, #64]
	ldr.w	r14, [r1, #68]
	// block (15,8)
	smladx.w	r7, r3, r12, r7
	smuadx.w	r9, r4, r12
	smladx.w	r9, r3, r14, r9
	smuadx.w	r11, r4, r14
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smuad.w	r10, r3, r14
	smlatt.w	r10, r4, r12, r10
	smultt.w	r5, r4, r14
	// block (14,9)
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r0, #112]
	ldr.w	r4, [r0, #116]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (13,10)
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r0, #104]
	ldr.w	r4, [r0, #108]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (12,11)
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r0, #96]
	ldr.w	r4, [r0, #100]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (11,12)
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r0, #88]
	ldr.w	r4, [r0, #92]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (10,13)
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r0, #80]
	ldr.w	r4, [r0, #84]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (9,14)
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r0, #72]
	ldr.w	r4, [r0, #76]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	// block (8,15)
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r0, #64]
	ldr.w	r4, [r0, #68]
	smladx.w	r7, r3, r12, r7
	smladx.w	r9, r4, r12, r9
	smladx.w	r9, r3, r14, r9
	smladx.w	r11, r4, r14, r11
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smlad.w	r10, r3, r14, r10
	smlatt.w	r10, r4, r12, r10
	smlatt.w	r5, r4, r14, r5
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r6, r7, r3, r12, r4
	br_32x2	r8, r9, r3, r12, r4
	str.w	r6, [r2], #4
	str.w	r8, [r2], #4
	ldr.w	r3, [r0, #72]
	ldr.w	r4, [r0, #76]
	ldr.w	r12, [r1, #120]
	// block (9,15)
	smladx.w	r11, r3, r12, r11
	smuadx.w	r6, r4, r12
	smladx.w	r6, r3, r14, r6
	smuadx.w	r8, r4, r14
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smuad.w	r7, r3, r14
	smlatt.w	r7, r4, r12, r7
	smultt.w	r9, r4, r14
	// block (10,14)
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r0, #80]
	ldr.w	r4, [r0, #84]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (11,13)
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r0, #88]
	ldr.w	r4, [r0, #92]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (12,12)
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r0, #96]
	ldr.w	r4, [r0, #100]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (13,11)
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r0, #104]
	ldr.w	r4, [r0, #108]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (14,10)
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r1, #84]
	ldr.w	r3, [r0, #112]
	ldr.w	r4, [r0, #116]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	// block (15,9)
	ldr.w	r12, [r1, #72]
	ldr.w	r14, [r1, #76]
	ldr.w	r3, [r0, #120]
	ldr.w	r4, [r0, #124]
	smladx.w	r11, r3, r12, r11
	smladx.w	r6, r4, r12, r6
	smladx.w	r6, r3, r14, r6
	smladx.w	r8, r4, r14, r8
	smlabb.w	r10, r3, r12, r10
	smlabb.w	r5, r3, r14, r5
	pkhtb.w	r3, r3, r4
	smlad.w	r5, r3, r12, r5
	smlad.w	r7, r3, r14, r7
	smlatt.w	r7, r4, r12, r7
	smlatt.w	r9, r4, r14, r9
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r10, r11, r3, r12, r14
	br_32x2	r5, r6, r3, r12, r14
	str.w	r10, [r2], #4
	str.w	r5, [r2], #4
	ldr.w	r3, [r0, #120]
	ldr.w	r12, [r1, #80]
	ldr.w	r14, [r1, #84]
	// block (15,10)
	smladx.w	r8, r3, r12, r8
	smuadx.w	r10, r4, r12
	smladx.w	r10, r3, r14, r10
	smuadx.w	r5, r4, r14
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smuad.w	r11, r3, r14
	smlatt.w	r11, r4, r12, r11
	smultt.w	r6, r4, r14
	// block (14,11)
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r0, #112]
	ldr.w	r4, [r0, #116]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (13,12)
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r0, #104]
	ldr.w	r4, [r0, #108]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (12,13)
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r0, #96]
	ldr.w	r4, [r0, #100]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (11,14)
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r0, #88]
	ldr.w	r4, [r0, #92]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	// block (10,15)
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r0, #80]
	ldr.w	r4, [r0, #84]
	smladx.w	r8, r3, r12, r8
	smladx.w	r10, r4, r12, r10
	smladx.w	r10, r3, r14, r10
	smladx.w	r5, r4, r14, r5
	smlabb.w	r7, r3, r12, r7
	smlabb.w	r9, r3, r14, r9
	pkhtb.w	r3, r3, r4
	smlad.w	r9, r3, r12, r9
	smlad.w	r11, r3, r14, r11
	smlatt.w	r11, r4, r12, r11
	smlatt.w	r6, r4, r14, r6
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r7, r8, r3, r12, r4
	br_32x2	r9, r10, r3, r12, r4
	str.w	r7, [r2], #4
	str.w	r9, [r2], #4
	ldr.w	r3, [r0, #88]
	ldr.w	r4, [r0, #92]
	ldr.w	r12, [r1, #120]
	// block (11,15)
	smladx.w	r5, r3, r12, r5
	smuadx.w	r7, r4, r12
	smladx.w	r7, r3, r14, r7
	smuadx.w	r9, r4, r14
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smuad.w	r8, r3, r14
	smlatt.w	r8, r4, r12, r8
	smultt.w	r10, r4, r14
	// block (12,14)
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r0, #96]
	ldr.w	r4, [r0, #100]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (13,13)
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r0, #104]
	ldr.w	r4, [r0, #108]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (14,12)
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r1, #100]
	ldr.w	r3, [r0, #112]
	ldr.w	r4, [r0, #116]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	// block (15,11)
	ldr.w	r12, [r1, #88]
	ldr.w	r14, [r1, #92]
	ldr.w	r3, [r0, #120]
	ldr.w	r4, [r0, #124]
	smladx.w	r5, r3, r12, r5
	smladx.w	r7, r4, r12, r7
	smladx.w	r7, r3, r14, r7
	smladx.w	r9, r4, r14, r9
	smlabb.w	r11, r3, r12, r11
	smlabb.w	r6, r3, r14, r6
	pkhtb.w	r3, r3, r4
	smlad.w	r6, r3, r12, r6
	smlad.w	r8, r3, r14, r8
	smlatt.w	r8, r4, r12, r8
	smlatt.w	r10, r4, r14, r10
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r11, r5, r3, r12, r14
	br_32x2	r6, r7, r3, r12, r14
	str.w	r11, [r2], #4
	str.w	r6, [r2], #4
	ldr.w	r3, [r0, #120]
	ldr.w	r12, [r1, #96]
	ldr.w	r14, [r1, #100]
	// block (15,12)
	smladx.w	r9, r3, r12, r9
	smuadx.w	r11, r4, r12
	smladx.w	r11, r3, r14, r11
	smuadx.w	r6, r4, r14
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smuad.w	r5, r3, r14
	smlatt.w	r5, r4, r12, r5
	smultt.w	r7, r4, r14
	// block (14,13)
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r0, #112]
	ldr.w	r4, [r0, #116]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (13,14)
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r0, #104]
	ldr.w	r4, [r0, #108]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	// block (12,15)
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r0, #96]
	ldr.w	r4, [r0, #100]
	smladx.w	r9, r3, r12, r9
	smladx.w	r11, r4, r12, r11
	smladx.w	r11, r3, r14, r11
	smladx.w	r6, r4, r14, r6
	smlabb.w	r8, r3, r12, r8
	smlabb.w	r10, r3, r14, r10
	pkhtb.w	r3, r3, r4
	smlad.w	r10, r3, r12, r10
	smlad.w	r5, r3, r14, r5
	smlatt.w	r5, r4, r12, r5
	smlatt.w	r7, r4, r14, r7
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r8, r9, r3, r12, r4
	br_32x2	r10, r11, r3, r12, r4
	str.w	r8, [r2], #4
	str.w	r10, [r2], #4
	ldr.w	r3, [r0, #104]
	ldr.w	r4, [r0, #108]
	ldr.w	r12, [r1, #120]
	// block (13,15)
	smladx.w	r6, r3, r12, r6
	smuadx.w	r8, r4, r12
	smladx.w	r8, r3, r14, r8
	smuadx.w	r10, r4, r14
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smuad.w	r9, r3, r14
	smlatt.w	r9, r4, r12, r9
	smultt.w	r11, r4, r14
	// block (14,14)
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r1, #116]
	ldr.w	r3, [r0, #112]
	ldr.w	r4, [r0, #116]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	// block (15,13)
	ldr.w	r12, [r1, #104]
	ldr.w	r14, [r1, #108]
	ldr.w	r3, [r0, #120]
	ldr.w	r4, [r0, #124]
	smladx.w	r6, r3, r12, r6
	smladx.w	r8, r4, r12, r8
	smladx.w	r8, r3, r14, r8
	smladx.w	r10, r4, r14, r10
	smlabb.w	r5, r3, r12, r5
	smlabb.w	r7, r3, r14, r7
	pkhtb.w	r3, r3, r4
	smlad.w	r7, r3, r12, r7
	smlad.w	r9, r3, r14, r9
	smlatt.w	r9, r4, r12, r9
	smlatt.w	r11, r4, r14, r11
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r5, r6, r3, r12, r14
	br_32x2	r7, r8, r3, r12, r14
	str.w	r5, [r2], #4
	str.w	r7, [r2], #4
	ldr.w	r3, [r0, #120]
	ldr.w	r12, [r1, #112]
	ldr.w	r14, [r1, #116]
	// block (15,14)
	smladx.w	r10, r3, r12, r10
	smuadx.w	r5, r4, r12
	smladx.w	r5, r3, r14, r5
	smuadx.w	r7, r4, r14
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smuad.w	r6, r3, r14
	smlatt.w	r6, r4, r12, r6
	smultt.w	r8, r4, r14
	// block (14,15)
	ldr.w	r12, [r1, #120]
	ldr.w	r14, [r1, #124]
	ldr.w	r3, [r0, #112]
	ldr.w	r4, [r0, #116]
	smladx.w	r10, r3, r12, r10
	smladx.w	r5, r4, r12, r5
	smladx.w	r5, r3, r14, r5
	smladx.w	r7, r4, r14, r7
	smlabb.w	r9, r3, r12, r9
	smlabb.w	r11, r3, r14, r11
	pkhtb.w	r3, r3, r4
	smlad.w	r11, r3, r12, r11
	smlad.w	r6, r3, r14, r6
	smlatt.w	r6, r4, r12, r6
	smlatt.w	r8, r4, r14, r8
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r9, r10, r3, r12, r4
	br_32x2	r11, r5, r3, r12, r4
	str.w	r9, [r2], #4
	str.w	r11, [r2], #4
	ldr.w	r3, [r0, #120]
	ldr.w	r4, [r0, #124]
	ldr.w	r12, [r1, #120]
	// block (15,15)
	smladx.w	r7, r3, r12, r7
	smuadx.w	r9, r4, r12
	smladx.w	r9, r3, r14, r9
	smuadx.w	r11, r4, r14
	smlabb.w	r6, r3, r12, r6
	smlabb.w	r8, r3, r14, r8
	pkhtb.w	r3, r3, r4
	smlad.w	r8, r3, r12, r8
	smuad.w	r10, r3, r14
	smlatt.w	r10, r4, r12, r10
	smultt.w	r5, r4, r14
	vmov.w	r3, s8  // load -q
	vmov.w	r12, s7  // load q32inv
	br_32x2	r6, r7, r3, r12, r4
	br_32x2	r8, r9, r3, r12, r4
	str.w	r6, [r2], #4
	str.w	r8, [r2], #4
	br_32x2	r10, r11, r3, r12, r4
	br_32	r5, r3, r12, r4
 bfc	r5, #16, #16
	str.w	r10, [r2], #4
	str.w	r5, [r2], #4
	add.w	r0, #128
	add.w	r1, #128
	vmov.w	r14, s9  // counter=scr0
	subs.w	r14, #1
	bne.w	KA256_muls1
KA256_collect:
	vmov.w	r2, s3  // reload hh
	vmov.w	r3, s4  // reload overflow list
KA256_col_64_ov:			// no overflow
KA256_col_64_add:			// KA collection
	ldrsh.w	r14, [r3], #2	// #shift/8, #iterations*4
	add.w	r12, r2, r14, LSL #3	// other pointer
	mov.w	r1, r2		// copy of hh
	mov.w	r10, #64		// N0
	mov.w	r0, #128			// 2*N0
	add.w	r11, r0, r0, LSL #1	// 6*N0
KA256_col_64_add1:	// begin KA collect loop
	ldr.w	r4, [r1, r0]		//+2*N0
	ldr.w	r6, [r1, r0, LSL #1]	//+4*N0
	ldr.w	r7, [r1, r11]		//+6*N0
	ssub16.w	r4, r4, r6
	sadd16.w	r8, r4, r7
	ldr.w	r6, [r1]
	ldr.w	r7, [r12, r0]		//+2*N0
	ssub16.w	r4, r4, r6
	ssub16.w	r8, r7, r8
	ldr.w	r6, [r12], #4		// shift r12 up 4
	str.w	r8, [r1, r0, LSL #1] 	//+4*N0
	sadd16.w	r4, r4, r6
	str.w	r4, [r1, r0]		//+2*N0
	add.w	r1, r1, #4		// shift r1 up 4
	subs.w	r14, r14, #2
	beq.w	KA256_col_64_end
	subs.w	r10, #2
	nop.n
	ittt	eq			//next 32 bloc
	addeq.w	r1, r1, r11		//+6*N0
	addeq.w	r12, r12, r0		//+2*N0
	moveq.w	r10, #64		// N0
	b.w	KA256_col_64_add1
KA256_col_64_end:
KA256_col_128_ov:
	ldrsh.w	r4, [r3], #2
	cmp.w	r4, #-1
	beq.w	KA256_col_128_add
	vmov.w	r0, s8  // load -q
	vmov.w	r1, s7  // load qinv32
	mov.w	r6,#32768
KA256_col_128_ov1:
	ldrsh.w	r5, [r3], #2
KA256_col_128_ov2:
	ldr.w	r8, [r2, r4, LSL #2]
	br_16x2	r8, r0, r1, r6, r7, r9
	str.w	r8, [r2, r4, LSL #2]
	add.w	r4, #1
	cmp.w	r4, r5
	bls.w	KA256_col_128_ov2
	ldrsh.w	r4, [r3], #2
	cmp.w	r4, -1
	bne.w	KA256_col_128_ov1
KA256_col_128_add:			// KA collection
	ldrsh.w	r14, [r3], #2	// #shift/8, #iterations*4
	add.w	r12, r2, r14, LSL #3	// other pointer
	mov.w	r1, r2		// copy of hh
	mov.w	r10, #128		// N0
	mov.w	r0, #256			// 2*N0
	add.w	r11, r0, r0, LSL #1	// 6*N0
KA256_col_128_add1:	// begin KA collect loop
	ldr.w	r4, [r1, r0]		//+2*N0
	ldr.w	r6, [r1, r0, LSL #1]	//+4*N0
	ldr.w	r7, [r1, r11]		//+6*N0
	ssub16.w	r4, r4, r6
	sadd16.w	r8, r4, r7
	ldr.w	r6, [r1]
	ldr.w	r7, [r12, r0]		//+2*N0
	ssub16.w	r4, r4, r6
	ssub16.w	r8, r7, r8
	ldr.w	r6, [r12], #4		// shift r12 up 4
	str.w	r8, [r1, r0, LSL #1] 	//+4*N0
	sadd16.w	r4, r4, r6
	str.w	r4, [r1, r0]		//+2*N0
	add.w	r1, r1, #4		// shift r1 up 4
	subs.w	r14, r14, #2
	beq.w	KA256_col_128_end
	subs.w	r10, #2
	nop.n
	ittt	eq			//next 64 bloc
	addeq.w	r1, r1, r11		//+6*N0
	addeq.w	r12, r12, r0		//+2*N0
	moveq.w	r10, #128		// N0
	b.w	KA256_col_128_add1
KA256_col_128_end:
KA256_mv_back:			// hh=[sp,4M] still =r2
	vmov.w	r0, s0  // reload h
	mov.w	r14, #1024
KA256_mv_back_loop:
	ldm.w	r2!, {r4-r11}
	stm.w	r0!, {r4-r11}
	subs.w	r14, #32
	bne.w	KA256_mv_back_loop
KA256_end:
	vmov.w	r12, s1  // load 2M
	add.w	sp, sp, r12, LSL #2	// add back 4608 = 8M
	vpop.w	{s16-s31}
	pop.w	{r4-r11,pc}

