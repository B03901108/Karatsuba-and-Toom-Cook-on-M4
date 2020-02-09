#!/usr/bin/python
import sys
import re
import numpy
from math import log2

q = 4591
qinv = 15631
q16 = 14
qR2inv = 935519
_2P15 = (1 << 15)

try: NN = int(sys.argv[1])
except: NN = 192
try: B = int(sys.argv[2])
except: B = 48
try: output_mode = sys.argv[3]
except: output_mode = 'nt'
#assert(768 % NN == 0)
assert(log2(NN / B).is_integer())
assert(B % 4 == 0)
assert((output_mode == 'nt') or (output_mode == 't'))
assert((NN > B) or (output_mode != 't'))
LVL = int(log2(NN // B))


#assert intIn is an integer
def is_constant(intIn):
	bin_str = numpy.binary_repr(intIn, width=32)
	if len(bin_str.strip('0')) <= 8:
		return True
	if (bin_str[0 : 8] == bin_str[16 : 24]) and (bin_str[8 : 16] == bin_str[24 : 32]):
		if (bin_str[0 : 8] == '0' * 8) or (bin_str[8 : 16] == '0' * 8) or (bin_str[0 : 8] == bin_str[8 : 16]):
			return True
	return False


def print_prologue():
	print('.p2align 2,,3')
	print('.syntax unified')
	print('.text')
	print('')


#to_be_optimized: use sp itself w/o the uncanny bug
def print_Karatsuba():
	input_size = NN * pow(1.5, LVL) // 2 * 4
	print('.global Karatsuba_mult_asm')
	print('.type Karatsuba_mult_asm, %function')
	print('@ %dx%d %d-layer Karatsuba' % (NN, NN, LVL))
	output_type = 'uint32_t *' if output_mode == 't'else 'int32_t *'
	print('@ void Karatsuba_mult_asm(%sh, uint32_t *c, uint32_t *f)' % (output_type))
	print('Karatsuba_mult_asm:')
	print('  push.w {r4-r12, lr}')
	if LVL:
		print('  vmov.w s0, r0')
		offset = int(input_size * 6)
		if (offset < 4096) or is_constant(offset):
			print('  sub.w sp, sp, #%d' % (offset))
		else:
			print('  sub.w sp, sp, #%d' % (offset % 4096))
			print('  sub.w sp, sp, #%d' % (offset // 4096 * 4096))
		print('  mov.w r0, sp')
		copy_input_coefs('f')
		extend_input_coefs('f')
		copy_input_coefs('c')
		extend_input_coefs('c')
	hybrid_mult()
	if LVL:
		compose_output_coefs()
		copy_output_coefs()
		if (offset < 4096) or is_constant(offset):
			print('  add.w sp, sp, #%d' % (offset))
		else:
			print('  add.w sp, sp, #%d' % (offset % 4096))
			print('  add.w sp, sp, #%d' % (offset // 4096 * 4096))
	print('  pop.w {r4-r12, pc}')


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


def extend_input_coefs(arr_name):
	tmp_reg = ['r4', 'r5', 'r6', 'r7', 'r8', 'r9', 'r10', 'r11']
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
		offset = int(ext_bndry * 4)
		if (offset < 4096) or is_constant(offset):
			print('  sub.w r12, r0, #%d' % (offset))
		else:
			print('  sub.w r12, r0, #%d' % (offset % 4096))
			print('  sub.w r12, r12, #%d' % (offset // 4096 * 4096))
		for it2 in range(0, ext_bndry // 2, len(tmp_reg) // 2):
			MOVE = min(len(tmp_reg) // 2, (ext_bndry // 2) - it2)
			for rid in range(MOVE):
				count += 1
				if count == count_bndry:
					print('  ldr.w %s, [r12, #%d]' % (tmp_reg[rid + MOVE], count_bndry * 4))
					if 4 + count_bndry * 4 < 256:
						print('  ldr.w %s, [r12], #%d' % (tmp_reg[rid], 4 + count_bndry * 4))
					else:
						print('  ldr.w %s, [r12], #4' % (tmp_reg[rid]))
						print('  add.w r12, r12, #%d' % (count_bndry * 4))
					count = 0
				else:
					print('  ldr.w %s, [r12, #%d]' % (tmp_reg[rid + MOVE], count_bndry * 4))
					print('  ldr.w %s, [r12], #4' % (tmp_reg[rid]))
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
				print('  str.w %s, [r0], #4' % (tmp_reg[rid]))
		ext_bndry += (ext_bndry // 2)
		count_bndry //= 2


def hybrid_mult():
	input_size = int(NN * pow(1.5, LVL) // 2 * 4)
	hybrid_mult_num = pow(3, LVL)
	offset = int(input_size * 4)
	if LVL:
		if (offset < 4096) or is_constant(offset):
			print('  add.w r7, r0, #%d' % (offset))
		else:
			print('  add.w r7, r0, #%d' % (offset % 8192))
			print('  add.w r7, r7, #%d' % (offset // 8192 * 8192))
		if (input_size < 4096) or is_constant(input_size):
			print('  sub.w r1, r0, #%d' % (input_size))
			print('  sub.w r2, r1, #%d' % (input_size))
		else:
			print('  sub.w r1, r0, #%d' % (input_size % 2048))
			print('  sub.w r1, r1, #%d' % (input_size // 2048 * 2048))
			print('  sub.w r2, r1, #%d' % (input_size % 2048))
			print('  sub.w r2, r2, #%d' % (input_size // 2048 * 2048))
		print('  vmov.w s1, r7')
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
			print('  str.w %s, [r0], #4' % (reg))
	for reg in str_reg[4 : ]:
		print('  str.w %s, [r0], #4' % (reg))
	print('  str.w r3, [r0], #4')
	if LVL:
		print('  vmov.w r7, s1')
		print('  cmp.w r0, r7')
		print('  bne.w snake_body')


def compose_output_coefs():
	input_size = NN * pow(1.5, LVL) // 2 * 4
	tmp_reg = ['r1', 'r2', 'r3', 'r4', 'r5', 'r6', 'r7', 'r8', 'r9', 'r10', 'r11', 'r12', 'lr']

	for fold in range(LVL):
		MAX_MOVE = len(tmp_reg) // 2
		unit_num = pow(3, (LVL - 1) - fold)
		unit_size = B * pow(2, fold) * 4
		if fold == 0:
			offset = int(input_size * 4 - unit_size)
			if (offset < 4096) or is_constant(offset):
				print('  sub.w r0, r0, #%d' % (offset))
			else:
				print('  sub.w r0, r0, #%d' % (offset % 4096))
				print('  sub.w r0, r0, #%d' % (offset // 4096 * 4096))
		else:
			offset = int(unit_size * 6 * unit_num - unit_size // 2 - unit_size)
			if (offset < 4096) or is_constant(offset):
				print('  sub.w r0, r0, #%d' % (offset))
			else:
				print('  sub.w r0, r0, #%d' % (offset % 4096))
				print('  sub.w r0, r0, #%d' % (offset // 4096 * 4096))
		for it in range(unit_num):
			#op_tmp = op_accum + unit_size
			for it2 in range(0, unit_size // 4, MAX_MOVE):
				MOVE = min(MAX_MOVE, (unit_size // 4 - it2))
				for rid in range(MOVE):
					print('  ldr.w %s, [r0, #%d]' % (tmp_reg[rid], rid * 4))
					print('  ldr.w %s, [r0, #%d]' % (tmp_reg[rid + MOVE], unit_size + rid * 4))
				for rid in range(MOVE):
					print('  sub.w %s, %s, %s' % (tmp_reg[rid], tmp_reg[rid + MOVE], tmp_reg[rid]))
				for rid in range(MOVE):
					print('  str.w %s, [r0], #4' % (tmp_reg[rid]))
			#op_tmp2 = op_accum - unit_size
			for it2 in range(0, unit_size // 4, MAX_MOVE):
				MOVE = min(MAX_MOVE, (unit_size // 4 - it2))
				for rid in range(MOVE):
					print('  ldr.w %s, [r0, #-4]!' % (tmp_reg[rid + MOVE]))
					print('  ldr.w %s, [r0, #%d]' % (tmp_reg[rid], unit_size * 2))
				for rid in range(MOVE):
					print('  sub.w %s, %s, %s' % (tmp_reg[rid], tmp_reg[rid], tmp_reg[rid + MOVE]))
				for rid in range(MOVE):
					print('  str.w %s, [r0, #%d]' % (tmp_reg[rid], unit_size + 4 * (MOVE - rid - 1)))
			#op_accum = op_tmp2 - unit_size
			#op_tmp = op_accum - unit_size
			for it2 in range(0, unit_size // 4, MAX_MOVE):
				MOVE = min(MAX_MOVE, (unit_size // 4 - it2))
				for rid in range(MOVE):
					print('  ldr.w %s, [r0, #-4]!' % (tmp_reg[rid + MOVE]))
					print('  ldr.w %s, [r0, #%d]' % (tmp_reg[rid], unit_size))
				for rid in range(MOVE):
					print('  add.w %s, %s, %s' % (tmp_reg[rid], tmp_reg[rid], tmp_reg[rid + MOVE]))
				for rid in range(MOVE):
					print('  str.w %s, [r0, #%d]' % (tmp_reg[rid], unit_size + 4 * (MOVE - rid - 1)))
			if it < unit_num - 1:
				print('  add.w r0, r0, #%d' % (unit_size * 5))
		#cSfS = h_ext + unit_num * unit_size * 4
		print('  add.w lr, r0, #%d' % (unit_size * 4))
		offset = int(unit_size * 4 * (unit_num - 1) - unit_size)
		if (offset < 4096) or is_constant(offset):
			print('  sub.w r0, r0, #%d' % (offset))
		else:
			r_offset = 32 - len(numpy.binary_repr(offset, width=32).rstrip('0'))
			mod_cut = int(pow(2, r_offset + 8))
			print('  sub.w r0, r0, #%d' % (offset % mod_cut))
			print('  sub.w r0, r0, #%d' % (offset // mod_cut * mod_cut))
		MAX_MOVE = (len(tmp_reg) - 1) // 2
		for it in range(unit_num):
			for it2 in range(0, unit_size // 2, MAX_MOVE):
				MOVE = min(MAX_MOVE, (unit_size // 2 - it2))
				for rid in range(MOVE):
					print('  ldr.w %s, [r0, #%d]' % (tmp_reg[rid], rid * 4))
					print('  ldr.w %s, [lr], #4' % (tmp_reg[rid + MOVE]))
				for rid in range(MOVE):
					print('  sub.w %s, %s, %s' % (tmp_reg[rid], tmp_reg[rid + MOVE], tmp_reg[rid]))
				for rid in range(MOVE):
					print('  str.w %s, [r0], #4' % (tmp_reg[rid]))
			if it < unit_num - 1:
				print('  add.w r0, r0, #%d' % (unit_size * 2))


def copy_output_coefs():
	input_size = NN * pow(1.5, LVL) // 2 * 4
	tmp_reg = ['r1', 'r2', 'r3', 'r4', 'r5', 'r6', 'r7', 'r8', 'r9']
	print('  sub.w r0, r0, #%d' % (NN * 6))
	print('  vmov.w lr, s0')
	if output_mode == 't':
		print('  movw.w r12, #18015')
		print('  movt.w r12, #14')
		print('  movw.w r11, #4591')
	tmp_reg += [] if output_mode == 't' else ['r10', 'r11', 'r12']
	MAX_MOVE = (len(tmp_reg) // 2 * 2) if output_mode == 't' else len(tmp_reg)
	for it in range(0, NN * 2, MAX_MOVE):
		MOVE = min(MAX_MOVE, (NN * 2 - it))
		for rid in range(MOVE):
			print('  ldr.w %s, [r0], #4' % (tmp_reg[rid]))
		if output_mode == 't':
			for rid in range(0, MOVE, 2):
				print('  smmulr.w r10, r12, %s' % (tmp_reg[rid]))
				print('  mls.w %s, r11, r10, %s' % (tmp_reg[rid], tmp_reg[rid]))
				print('  smmulr.w r10, r12, %s' % (tmp_reg[rid + 1]))
				print('  mls.w %s, r11, r10, %s' % (tmp_reg[rid + 1], tmp_reg[rid + 1]))
				print('  pkhbt.w %s, %s, %s, lsl #16' % (tmp_reg[rid // 2], tmp_reg[rid], tmp_reg[rid + 1]))
			MOVE //= 2
		for rid in range(MOVE):
			print('  str.w %s, [lr], #4' % (tmp_reg[rid]))


print_prologue()
print_Karatsuba()
