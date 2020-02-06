#!/usr/bin/python
import sys
import re
from math import log2, ceil, floor, sqrt

q = 4591
qinv = 15631
q16 = 14
qR2inv = 935519
_2P15 = (1 << 15)

try: NN = int(sys.argv[1])
except: NN = 192
try: B = int(sys.argv[2])
except:
	B = 48
assert(768 % NN == 0)
assert(log2(NN / B).is_integer())
assert(B % 4 == 0)
LVL = int(log2(NN // B))


def print_prologue():
	print('.p2align 2,,3')
	print('.syntax unified')
	print('.text')
	print('')
	print('.global Karatsuba_mult_asm')
	print('.type Karatsuba_mult_asm, %function')
	print('')


#unit_size = NN * pow(1.5, LVL) // 2
#int i, j1;
#uint32_t r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10;
#uint32_t *c_to, *f_to, *c_from1, *f_from1, *c_from2, *f_from2;
#uint32_t c_ext[unit_size], f_ext[unit_size];
#int32_t ir0, ir1, ir2, ir3, ir4, ir5, ir6, ir7, ir8, ir9, ir10, ir11;
#int32_t *cf, *cSfS, *bndry, *op_accum, *op_tmp, *op_tmp2;
#int32_t h_ext[unit_size * 4];
def print_Karatsuba():
	input_size = NN * pow(1.5, LVL) // 2 * 4
	print('@ %dx%d %d-layer Karatsuba' % (NN, NN, LVL))
	print('@ void Karatsuba_mult_asm(int32_t *h, uint32_t *c, uint32_t *f);')
	print('Karatsuba_mult_asm:')
	print('  push.w {r4-r12, lr}')
	print('  vmov.w s0, r0')
	#print('  str.w r0, [sp, #-4]!')
	print('  sub.w sp, sp, #%d' % (NN // 2 * 4))
	print('  mov.w r0, sp')
	copy_input_coefs('f')
	#extend_input_coefs('f')
	#copy_input_coefs('c')
	#extend_input_coefs('c')
	#hybrid_mult()
	#compose_output_coefs()
	#copy_output_coefs()
	copy_state()
	print('  add.w sp, sp, #%d' % (NN // 2 * 4))
	print('  pop.w {r4-r12, pc}')


def copy_state():
	input_size = int(NN * pow(1.5, LVL) // 2 * 4)
	tmp_reg = ['r1', 'r2', 'r3', 'r4', 'r5', 'r6', 'r7', 'r8', 'r9', 'r10', 'r11', 'r12']
	#print('  sub.w sp, sp, #%d' % (input_size * 6))
	print('  sub.w r0, r0, #%d' % (NN // 2 * 4))
	print('  vmov.w lr, s0')
	#print('  ldr.w lr, [sp, #%d]' % (input_size * 4))
	MAX_MOVE = len(tmp_reg)
	for it in range(0, NN // 2, MAX_MOVE):
		MOVE = min(MAX_MOVE, (NN // 2 - it))
		for rid in range(MOVE):
			print('  ldr.w %s, [r0], #4' % (tmp_reg[rid]))
		for rid in range(MOVE):
			print('  str.w %s, [lr], #4' % (tmp_reg[rid]))
	#print('  add.w sp, sp, #%d' % (input_size * 5))
	#print('  add.w sp, sp, #%d' % (input_size * 4 + 4))


#to_be_optimized: 'sub.w sp, sp, #(input_size * 6)' merged to one str
def copy_input_coefs(arr_name):
	source_addr = 'r1' if arr_name == 'c' else 'r2'
	tmp_reg = ['r3', 'r4', 'r5', 'r6', 'r7', 'r8', 'r9', 'r10', 'r11', 'r12', 'lr']
	tmp_reg += ['r2'] if arr_name == 'c' else []
	for it in range(0, NN // 2, len(tmp_reg)):
		MOVE = min(len(tmp_reg), (NN // 2 - it))
		for rid in range(MOVE):
			print('  ldr.w %s, [%s], #4' % (tmp_reg[rid], source_addr))
		for rid in range(MOVE):
			print('  str.w %s, [r0], #4' % (tmp_reg[rid]))


#generalization: pre/post-indexing can't handle |offset|>255
def extend_input_coefs(arr_name):
	tmp_reg = ['r4', 'r5', 'r6', 'r7', 'r8', 'r9', 'r10', 'r11', 'r12']
	if arr_name == 'c':
		print('  movw.w r2, #18015')
		print('  movt.w r2, #14')
		print('  movw.w r1, #32768')
		print('  movw.w lr, #4591')
	else:
		tmp_reg += ['lr', 'r2']
	ext_bndry = NN // 2
	count_bndry = ext_bndry // 2
	for it in range(LVL):
		count = 0
		print('  sub.w r0, sp, #%d' % (ext_bndry * 4))
		print('  add.w r3, r0, #%d' % (count_bndry * 4))
		for it2 in range(0, ext_bndry // 2, len(tmp_reg) // 2):
			MOVE = min(len(tmp_reg) // 2, (ext_bndry // 2) - it2)
			for rid in range(MOVE):
				count += 1
				if count == count_bndry:
					print('  ldr.w %s, [r0], #%d' % (tmp_reg[rid], 4 + count_bndry * 4))
					print('  ldr.w %s, [r3], #%d' % (tmp_reg[rid + MOVE], 4 + count_bndry * 4))
					count = 0
				else:
					print('  ldr.w %s, [r0], #4' % (tmp_reg[rid]))
					print('  ldr.w %s, [r3], #4' % (tmp_reg[rid + MOVE]))
			for rid in range(MOVE):
				print('  sadd16.w %s, %s, %s' % (tmp_reg[rid], tmp_reg[rid], tmp_reg[rid + MOVE]))
			if (arr_name == 'c'):
				for rid in range(MOVE):
					print('  smlawb.w %s, r2, %s, r1' % (tmp_reg[MOVE], tmp_reg[rid]))
					print('  smlawt.w %s, r2, %s, r1' % (tmp_reg[MOVE + 1], tmp_reg[rid]))
					print('  smulbt.w %s, lr, %s' % (tmp_reg[MOVE], tmp_reg[MOVE]))
					print('  smulbt.w %s, lr, %s' % (tmp_reg[MOVE + 1], tmp_reg[MOVE + 1]))
					print('  pkhbt.w %s, %s, %s, lsl #16' % (tmp_reg[MOVE], tmp_reg[MOVE], tmp_reg[MOVE + 1]))
					print('  ssub16.w %s, %s, %s' % (tmp_reg[rid], tmp_reg[rid], tmp_reg[MOVE]))
			for rid in range(MOVE):
				print('  str.w %s, [sp], #4' % (tmp_reg[rid]))
		ext_bndry += (ext_bndry // 2)
		count_bndry //= 2


def hybrid_mult():
	input_size = NN * pow(1.5, LVL) // 2 * 4
	hybrid_mult_num = pow(3, LVL)
	print('  add.w r0, sp, #%d' % (input_size * 4))
	print('  sub.w r1, sp, #%d' % (input_size))
	print('  sub.w r2, r1, #%d' % (input_size))
	print('snake_body:')
	print('  ldr.w r3, [r1], #4')
	print('  ldr.w r4, [r1], #4')
	for product_idx in range(B // 2 - 1):
		(inc_arr_name, dec_arr_name) = ('r2', 'r1') if product_idx % 2 else ('r1', 'r2')
		ldr_reg = ['r5', 'r6', 'r4', 'r3'] if product_idx % 2 else ['r3', 'r4', 'r6', 'r5']
		str_reg = ['r11', 'r12', 'lr', 'r10', 'r7', 'r8', 'r9'] if product_idx % 2 else ['r7', 'r8', 'r9', 'r10', 'r11', 'r12', 'lr']
		window_size = min(product_idx + 1, (B // 2 - 1) - product_idx)
		for op_idx in range(window_size):
			if op_idx:
				if (op_idx == (window_size - 1)) and (product_idx >= (B // 4 - 1)) and (product_idx < (B // 2 - 3)):
					print('  ldr.w %s, [%s, #4]' % (ldr_reg[1], inc_arr_name))
					print('  ldr.w %s, [%s], #-4' % (ldr_reg[0], inc_arr_name))
				else:
					print('  ldr.w %s, [%s], #4' % (ldr_reg[0], inc_arr_name))
					print('  ldr.w %s, [%s], #4' % (ldr_reg[1], inc_arr_name))
				if op_idx == (window_size - 1):
					print('  ldr.w %s, [%s, #-4]' % (ldr_reg[3], dec_arr_name))
					print('  ldr.w %s, [%s], #4' % (ldr_reg[2], dec_arr_name))
				else:
					print('  ldr.w %s, [%s], #-4' % (ldr_reg[2], dec_arr_name))
					print('  ldr.w %s, [%s], #-4' % (ldr_reg[3], dec_arr_name))
				print('  smlabb.w %s, r3, r5, %s' % (str_reg[0], str_reg[0]))
				print('  smlabb.w %s, r3, r6, %s' % (str_reg[2], str_reg[2]))
				print('  smladx.w %s, r3, r5, %s' % (str_reg[1], str_reg[1]))
				print('  smladx.w %s, r3, r6, %s' % (str_reg[3], str_reg[3]))
				print('  smladx.w %s, r4, r6, %s' % (str_reg[5], str_reg[5]))
				print('  smlatt.w %s, r4, r5, %s' % (str_reg[4], str_reg[4]))
				print('  smlatt.w %s, r4, r6, %s' % (str_reg[6], str_reg[6]))
			else:
				if product_idx:
					if product_idx < B // 4:
						print('  ldr.w %s, [%s, #4]' % (ldr_reg[2], dec_arr_name))
						print('  ldr.w %s, [%s], #-4' % (ldr_reg[3], dec_arr_name))
					else:
						print('  ldr.w %s, [%s], #4' % (ldr_reg[0], inc_arr_name))
						print('  ldr.w %s, [%s], #4' % (ldr_reg[1], inc_arr_name))
					print('  smlabb.w %s, r3, r5, %s' % (str_reg[0], str_reg[0]))
					print('  smlabb.w %s, r3, r6, %s' % (str_reg[2], str_reg[2]))
					print('  smladx.w %s, r3, r5, %s' % (str_reg[1], str_reg[1]))
				else:
					print('  ldr.w %s, [%s], #4' % (ldr_reg[3], dec_arr_name))
					print('  ldr.w %s, [%s], #4' % (ldr_reg[2], dec_arr_name))
					print('  smulbb.w %s, r3, r5' % (str_reg[0]))
					print('  smulbb.w %s, r3, r6' % (str_reg[2]))
					print('  smuadx.w %s, r3, r5' % (str_reg[1]))
				print('  smuadx.w %s, r3, r6' % (str_reg[3]))
				print('  smuadx.w %s, r4, r6' % (str_reg[5]))
				print('  smultt.w %s, r4, r5' % (str_reg[4]))
				print('  smultt.w %s, r4, r6' % (str_reg[6]))
			print('  smladx.w %s, r4, r5, %s' % (str_reg[3], str_reg[3]))
			print('  pkhbt.w r3, r4, r3')
			print('  smlad.w %s, r3, r5, %s' % (str_reg[2], str_reg[2]))
			print('  smlad.w %s, r3, r6, %s' % (str_reg[4], str_reg[4]))
		if (product_idx == B // 2 - 2):
			print('  movw.w r3, #0')
		elif (product_idx < (B // 4 - 1)) and (product_idx % 2):
			print('  ldr.w r3, [r1, #-8]')
		elif (product_idx >= (B // 4 - 1)) and (1 - product_idx % 2):
			print('  ldr.w r3, [r1, #4]')
		for reg in str_reg[ : 4]:
			print('  str.w %s, [sp], #4' % (reg))
	for reg in str_reg[4 : ]:
		print('  str.w %s, [sp], #4' % (reg))
	print('  str.w r3, [sp], #4')
	print('  cmp.w sp, r0')
	print('  bne.w snake_body')


#generalization: pre/post-indexing can't handle |offset|>255
def compose_output_coefs():
	input_size = NN * pow(1.5, LVL) // 2 * 4
	tmp_reg = ['r0', 'r1', 'r2', 'r3', 'r4', 'r5', 'r6', 'r7', 'r8', 'r9', 'r10', 'r11', 'r12', 'lr']

	for fold in range(LVL):
		MAX_MOVE = len(tmp_reg) // 2
		unit_num = pow(3, (LVL - 1) - fold)
		unit_size = B * pow(2, fold) * 4
		if fold == 0:
			print('  sub.w sp, sp, #%d' % (input_size * 4 - unit_size))
		else:
			print('  sub.w sp, sp, #%d' % (unit_size * 6 * unit_num - unit_size // 2 - unit_size))

		for it in range(unit_num):
			#op_tmp = op_accum + unit_size
			for it2 in range(0, unit_size // 4, MAX_MOVE):
				MOVE = min(MAX_MOVE, (unit_size // 4 - it2))
				for rid in range(MOVE):
					print('  ldr.w %s, [sp, #%d]' % (tmp_reg[rid], rid * 4))
					print('  ldr.w %s, [sp, #%d]' % (tmp_reg[rid + MOVE], unit_size + rid * 4))
				for rid in range(MOVE):
					print('  sub.w %s, %s, %s' % (tmp_reg[rid], tmp_reg[rid + MOVE], tmp_reg[rid]))
				for rid in range(MOVE):
					print('  str.w %s, [sp], #4' % (tmp_reg[rid]))
			#op_tmp2 = op_accum - unit_size
			for it2 in range(0, unit_size // 4, MAX_MOVE):
				MOVE = min(MAX_MOVE, (unit_size // 4 - it2))
				for rid in range(MOVE):
					print('  ldr.w %s, [sp, #-4]!' % (tmp_reg[rid + MOVE]))
					print('  ldr.w %s, [sp, #%d]' % (tmp_reg[rid], unit_size * 2))
				for rid in range(MOVE):
					print('  sub.w %s, %s, %s' % (tmp_reg[rid], tmp_reg[rid], tmp_reg[rid + MOVE]))
				for rid in range(MOVE):
					print('  str.w %s, [sp, #%d]' % (tmp_reg[rid], unit_size + 4 * (MOVE - rid - 1)))
			#op_accum = op_tmp2 - unit_size
			#op_tmp = op_accum - unit_size
			for it2 in range(0, unit_size // 4, MAX_MOVE):
				MOVE = min(MAX_MOVE, (unit_size // 4 - it2))
				for rid in range(MOVE):
					print('  ldr.w %s, [sp, #-4]!' % (tmp_reg[rid + MOVE]))
					print('  ldr.w %s, [sp, #%d]' % (tmp_reg[rid], unit_size))
				for rid in range(MOVE):
					print('  add.w %s, %s, %s' % (tmp_reg[rid], tmp_reg[rid], tmp_reg[rid + MOVE]))
				for rid in range(MOVE):
					print('  str.w %s, [sp, #%d]' % (tmp_reg[rid], unit_size + 4 * (MOVE - rid - 1)))
			if it < unit_num - 1:
				print('  add.w sp, sp, #%d' % (unit_size * 5))
		#cSfS = h_ext + unit_num * unit_size * 4
		print('  add.w lr, sp, #%d' % (unit_size * 4))
		print('  sub.w sp, sp, #%d' % (unit_size * 4 * (unit_num - 1) - unit_size))
		MAX_MOVE = (len(tmp_reg) - 1) // 2
		for it in range(unit_num):
			for it2 in range(0, unit_size // 2, MAX_MOVE):
				MOVE = min(MAX_MOVE, (unit_size // 2 - it2))
				for rid in range(MOVE):
					print('  ldr.w %s, [sp, #%d]' % (tmp_reg[rid], rid * 4))
					print('  ldr.w %s, [lr], #4' % (tmp_reg[rid + MOVE]))
				for rid in range(MOVE):
					print('  sub.w %s, %s, %s' % (tmp_reg[rid], tmp_reg[rid + MOVE], tmp_reg[rid]))
				for rid in range(MOVE):
					print('  str.w %s, [sp], #4' % (tmp_reg[rid]))
			if it < unit_num - 1:
				print('  add.w sp, sp, #%d' % (unit_size * 2))


def copy_output_coefs():
	input_size = NN * pow(1.5, LVL) // 2 * 4
	tmp_reg = ['r0', 'r1', 'r2', 'r3', 'r4', 'r5', 'r6', 'r7', 'r8', 'r9', 'r10', 'r11', 'r12']
	print('  sub.w sp, sp, #%d' % (NN * 6))
	print('  vmov.w lr, s0')
	#print('  ldr.w lr, [sp, #%d]' % (input_size * 4))
	MAX_MOVE = len(tmp_reg)
	for it in range(0, NN * 2, MAX_MOVE):
		MOVE = min(MAX_MOVE, (NN * 2 - it))
		for rid in range(MOVE):
			print('  ldr.w %s, [sp], #4' % (tmp_reg[rid]))
		for rid in range(MOVE):
			print('  str.w %s, [lr], #4' % (tmp_reg[rid]))
	print('add.w sp, sp, #%d' % (input_size * 4 - NN * 8))
	#print('add.w sp, sp, #%d' % (input_size * 4 - NN * 8 + 4))


print_prologue()
print_Karatsuba()
#hybrid_mult()
