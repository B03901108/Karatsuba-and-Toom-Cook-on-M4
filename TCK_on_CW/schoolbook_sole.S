	.cpu cortex-m4
	.eabi_attribute 27, 1
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 4
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"schoolbook.c"
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.section	.text.schoolbook_mult,"ax",%progbits
	.align	1
	.global	schoolbook_mult
	.syntax unified
	.thumb
	.thumb_func
	.fpu fpv4-sp-d16
	.type	schoolbook_mult, %function
schoolbook_mult:
.LFB0:
	.file 1 "schoolbook.c"
	.loc 1 4 0
	.cfi_startproc
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
.LVL0:
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
.LCFI0:
	.cfi_def_cfa_offset 32
	.cfi_offset 4, -32
	.cfi_offset 5, -28
	.cfi_offset 6, -24
	.cfi_offset 7, -20
	.cfi_offset 8, -16
	.cfi_offset 9, -12
	.cfi_offset 10, -8
	.cfi_offset 14, -4
	.loc 1 23 0
	ldr	r6, .L10
	.loc 1 21 0
	movs	r4, #0
	.loc 1 23 0
	movs	r7, #228
	.loc 1 24 0
	movw	ip, #58470
.LVL1:
.L2:
	mov	r3, r1
	add	r8, r1, r4
	add	lr, r2, r4
	add	lr, lr, #2
	.loc 1 21 0
	movs	r5, #0
.LVL2:
	and	r10, r4, #3
	cmp	r10, 0
	bne	.L3
	ldrh	r10, [r3], #2
	ldrsh	r9, [lr, #-2]!
	smlabb	r5, r10, r9, r5
	b	.LVL3
.L3:
	.loc 1 22 0 discriminator 3
	ldr	r10, [r3], #4
	ldr	r9, [lr, #-4]! 
	smladx	r5, r10, r9, r5
.LVL3:
	cmp	r3, r8
	ble	.L3
	.loc 1 23 0 discriminator 2
	mul	r3, r7, r5
	asrs	r3, r3, #20
	mla	r5, r6, r3, r5
.LVL4:
	.loc 1 24 0 discriminator 2
	mul	r3, ip, r5
	add	r3, r3, #134217728
	asrs	r3, r3, #28
.LVL5:
	mla	r3, r6, r3, r5
.LVL6:
	.loc 1 26 0 discriminator 2
	strh	r3, [r0, r4]	@ movhi
	adds	r4, r4, #2
	.loc 1 20 0 discriminator 2
	cmp	r4, #48
	bne	.L2
	.loc 1 32 0
	ldr	r6, .L10
	adds	r0, r0, #46
.LVL7:
	.loc 1 20 0
	movs	r5, #1
.LVL8:
	.loc 1 32 0
	mov	ip, #228
	.loc 1 33 0
	movw	r7, #58470
.LVL9:
.L6:
	.loc 1 31 0
	mov	r3, r5
.LVL10:
	add	lr, r2, #48
	.loc 1 30 0
	movs	r4, #0
.LVL11:
	and	r9, r5, #1
	cmp	r9, #1
	bne	.L5
	ldrh	r9, [r1, r3, lsl #1]
	ldrh	r8, [lr, #-2]!
	adds	r3, r3, #1
	smlabb	r4, r9, r8, r4
	b	.LVL13
.L5:
	.loc 1 31 0 discriminator 3
	ldr	r9, [r1, r3, lsl #1]
	ldr	r8, [lr, #-4]!
	adds	r3, r3, #2
.LVL12:
	smladx	r4, r9, r8, r4
.LVL13:
	cmp	r3, #24
	bne	.L5
	.loc 1 32 0 discriminator 2
	mul	r3, ip, r4
.LVL14:
	asrs	r3, r3, #20
	mla	r4, r6, r3, r4
.LVL15:
	.loc 1 33 0 discriminator 2
	mul	r3, r7, r4
	add	r3, r3, #134217728
	asrs	r3, r3, #28
.LVL16:
	adds	r5, r5, #1
.LVL17:
	mla	r3, r6, r3, r4
.LVL18:
	.loc 1 29 0 discriminator 2
	cmp	r5, #24
	.loc 1 35 0 discriminator 2
	strh	r3, [r0, #2]!	@ movhi
.LVL19:
	.loc 1 29 0 discriminator 2
	bne	.L6
	.loc 1 37 0
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
.LVL20:
.L11:
	.align	2
.L10:
	.word	-4591
	.cfi_endproc
.LFE0:
	.size	schoolbook_mult, .-schoolbook_mult
	.text
.Letext0:
	.file 2 "/usr/arm-none-eabi/include/machine/_default_types.h"
	.file 3 "/usr/arm-none-eabi/include/sys/_stdint.h"
	.section	.debug_info,"",%progbits
.Ldebug_info0:
	.4byte	0x10e
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	.LASF13
	.byte	0xc
	.4byte	.LASF14
	.4byte	.LASF15
	.4byte	.Ldebug_ranges0+0
	.4byte	0
	.4byte	0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF0
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF1
	.uleb128 0x3
	.4byte	.LASF4
	.byte	0x2
	.byte	0x37
	.4byte	0x42
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF2
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF3
	.uleb128 0x3
	.4byte	.LASF5
	.byte	0x2
	.byte	0x4d
	.4byte	0x5b
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF6
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF7
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF8
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF9
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF10
	.uleb128 0x3
	.4byte	.LASF11
	.byte	0x3
	.byte	0x20
	.4byte	0x37
	.uleb128 0x5
	.4byte	0x85
	.uleb128 0x3
	.4byte	.LASF12
	.byte	0x3
	.byte	0x2c
	.4byte	0x50
	.uleb128 0x6
	.byte	0x1
	.4byte	.LASF16
	.byte	0x1
	.byte	0x4
	.byte	0x1
	.4byte	.LFB0
	.4byte	.LFE0
	.4byte	.LLST0
	.byte	0x1
	.4byte	0x105
	.uleb128 0x7
	.ascii	"h\000"
	.byte	0x1
	.byte	0x4
	.4byte	0x105
	.4byte	.LLST1
	.uleb128 0x8
	.ascii	"c\000"
	.byte	0x1
	.byte	0x4
	.4byte	0x10b
	.byte	0x1
	.byte	0x51
	.uleb128 0x8
	.ascii	"f\000"
	.byte	0x1
	.byte	0x4
	.4byte	0x10b
	.byte	0x1
	.byte	0x52
	.uleb128 0x9
	.ascii	"i\000"
	.byte	0x1
	.byte	0x5
	.4byte	0x77
	.4byte	.LLST2
	.uleb128 0x9
	.ascii	"j\000"
	.byte	0x1
	.byte	0x5
	.4byte	0x77
	.4byte	.LLST3
	.uleb128 0x9
	.ascii	"a\000"
	.byte	0x1
	.byte	0x6
	.4byte	0x95
	.4byte	.LLST4
	.byte	0
	.uleb128 0xa
	.byte	0x4
	.4byte	0x85
	.uleb128 0xa
	.byte	0x4
	.4byte	0x90
	.byte	0
	.section	.debug_abbrev,"",%progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x55
	.uleb128 0x6
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.uleb128 0x2117
	.uleb128 0xc
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",%progbits
.Ldebug_loc0:
.LLST0:
	.4byte	.LFB0
	.4byte	.LCFI0
	.2byte	0x2
	.byte	0x7d
	.sleb128 0
	.4byte	.LCFI0
	.4byte	.LFE0
	.2byte	0x2
	.byte	0x7d
	.sleb128 32
	.4byte	0
	.4byte	0
.LLST1:
	.4byte	.LVL0
	.4byte	.LVL7
	.2byte	0x1
	.byte	0x50
	.4byte	.LVL7
	.4byte	.LVL9
	.2byte	0x3
	.byte	0x70
	.sleb128 -46
	.byte	0x9f
	.4byte	.LVL9
	.4byte	.LFE0
	.2byte	0x4
	.byte	0xf3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST2:
	.4byte	.LVL0
	.4byte	.LVL1
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL9
	.4byte	.LVL17
	.2byte	0x3
	.byte	0x75
	.sleb128 23
	.byte	0x9f
	.4byte	.LVL17
	.4byte	.LVL19
	.2byte	0x3
	.byte	0x75
	.sleb128 22
	.byte	0x9f
	.4byte	0
	.4byte	0
.LLST3:
	.4byte	.LVL1
	.4byte	.LVL2
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL10
	.4byte	.LVL11
	.2byte	0x1
	.byte	0x55
	.4byte	.LVL11
	.4byte	.LVL12
	.2byte	0x1
	.byte	0x53
	.4byte	.LVL12
	.4byte	.LVL13
	.2byte	0x3
	.byte	0x73
	.sleb128 -1
	.byte	0x9f
	.4byte	.LVL13
	.4byte	.LVL14
	.2byte	0x1
	.byte	0x53
	.4byte	0
	.4byte	0
.LLST4:
	.4byte	.LVL1
	.4byte	.LVL2
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL2
	.4byte	.LVL5
	.2byte	0x1
	.byte	0x55
	.4byte	.LVL5
	.4byte	.LVL6
	.2byte	0x9
	.byte	0x76
	.sleb128 0
	.byte	0x73
	.sleb128 0
	.byte	0x1e
	.byte	0x75
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL6
	.4byte	.LVL8
	.2byte	0x12
	.byte	0x7c
	.sleb128 0
	.byte	0x75
	.sleb128 0
	.byte	0x1e
	.byte	0x40
	.byte	0x47
	.byte	0x24
	.byte	0x22
	.byte	0x4c
	.byte	0x26
	.byte	0x76
	.sleb128 0
	.byte	0x1e
	.byte	0x75
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL9
	.4byte	.LVL11
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL11
	.4byte	.LVL16
	.2byte	0x1
	.byte	0x54
	.4byte	.LVL16
	.4byte	.LVL18
	.2byte	0x9
	.byte	0x76
	.sleb128 0
	.byte	0x73
	.sleb128 0
	.byte	0x1e
	.byte	0x74
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	.LVL18
	.4byte	.LVL20
	.2byte	0x13
	.byte	0x74
	.sleb128 0
	.byte	0xa
	.2byte	0xe466
	.byte	0x1e
	.byte	0x40
	.byte	0x47
	.byte	0x24
	.byte	0x22
	.byte	0x4c
	.byte	0x26
	.byte	0x76
	.sleb128 0
	.byte	0x1e
	.byte	0x74
	.sleb128 0
	.byte	0x22
	.byte	0x9f
	.4byte	0
	.4byte	0
	.section	.debug_aranges,"",%progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	0
	.4byte	0
	.section	.debug_ranges,"",%progbits
.Ldebug_ranges0:
	.4byte	.LFB0
	.4byte	.LFE0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",%progbits
.Ldebug_line0:
	.section	.debug_str,"MS",%progbits,1
.LASF4:
	.ascii	"__int16_t\000"
.LASF5:
	.ascii	"__int32_t\000"
.LASF13:
	.ascii	"GNU C99 7.3.1 20180622 (release) [ARM/embedded-7-br"
	.ascii	"anch revision 261907] -mcpu=cortex-m4 -mthumb -mflo"
	.ascii	"at-abi=hard -mfpu=fpv4-sp-d16 -gdwarf-2 -Os -std=gn"
	.ascii	"u99 -fmessage-length=0 -ffunction-sections -funsign"
	.ascii	"ed-char -funsigned-bitfields -fshort-enums\000"
.LASF1:
	.ascii	"unsigned char\000"
.LASF7:
	.ascii	"long unsigned int\000"
.LASF3:
	.ascii	"short unsigned int\000"
.LASF14:
	.ascii	"schoolbook.c\000"
.LASF10:
	.ascii	"unsigned int\000"
.LASF9:
	.ascii	"long long unsigned int\000"
.LASF11:
	.ascii	"int16_t\000"
.LASF12:
	.ascii	"int32_t\000"
.LASF8:
	.ascii	"long long int\000"
.LASF15:
	.ascii	"/home/wei-lun/Desktop/chipwhisperer-4.0.2/hardware/"
	.ascii	"victims/firmware/simpleserial-sntru (TCK)\000"
.LASF2:
	.ascii	"short int\000"
.LASF6:
	.ascii	"long int\000"
.LASF16:
	.ascii	"schoolbook_mult\000"
.LASF0:
	.ascii	"signed char\000"
	.ident	"GCC: (GNU Tools for Arm Embedded Processors 7-2018-q3-update) 7.3.1 20180622 (release) [ARM/embedded-7-branch revision 261907]"
