#ifndef _RED_ASM_H_
#define _RED_ASM_H_ 1

// macros for reduction mod qq	

	.macro	mr_hi, res32, qq, neg_qqinv, scr
	smulbb.w	\scr, \res32, \neg_qqinv
	smlabb.w	\res32, \qq, \scr, \res32
	.endm
	
	.macro	mr_16x2, r0, r1, qq, neg_qqinv, scr, res
	mr_hi	\r0, \qq, \neg_qqinv, \scr
	mr_hi	\r1, \qq, \neg_qqinv, \scr
    	.ifb	\res
	pkhtb.w	\r0, \r1, \r0, ASR #16
	.else	
	pkhtb.w	\res, \r1, \r0, ASR #16
	.endif
	.endm

	.macro	br_lo, res, mq, q32inv, _2p15, scr
	smlawb.w	\scr, \q32inv, \res, \_2p15
	smlatb.w	\res, \scr, \mq, \res
	.endm
	// note that high half of res is undefined
	// must save with strh

	.macro	br_16x2, res, mq, q32inv, _2p15, scr1, scr2, newres
	smlawb.w	\scr1, \q32inv, \res, \_2p15
	smlatb.w	\scr2, \scr1, \mq, \res
	smlawt.w	\scr1, \q32inv, \res, \_2p15
	smultb.w	\scr1, \scr1, \mq
	add.w	\scr1, \res, \scr1, LSL #16 
	.ifb	\newres
	pkhbt.w	\res, \scr2, \scr1
	.else	
	pkhbt.w	\newres, \scr2, \scr1
	.endif
	.endm	

	.macro	br_32, res, mq, q32inv, scr
	smmulr.w	\scr, \res, \q32inv
	mla.w	\res, \mq, \scr, \res
	.endm

	.macro	br_32x2, res0, res1, mq, q32inv, scr
	smmulr.w	\scr, \res0, \q32inv
	mla.w	\res0, \mq, \scr, \res0
	smmulr.w	\scr, \res1, \q32inv
	mla.w	\res1, \mq, \scr, \res1
	pkhbt.w   \res0, \res0, \res1, LSL #16  
	.endm  
	  // no good don't use
	.macro	center_adj, res, qqx2, scr // qqx2 = 2 copies of qq
	sadd16.w	scr, res, qqx2
	sel.w	res, scr
	ssub16.w	scr, res, qqx2
	sel.w	res, scr
	.endm	  

#endif
