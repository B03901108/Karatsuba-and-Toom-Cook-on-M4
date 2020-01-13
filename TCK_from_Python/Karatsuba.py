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


def declare_tmp_vars():
	unit_size = NN * pow(1.5, LVL) // 2
	print('  int i, j1;')
	print('  uint32_t r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10;')
	print('  uint32_t *c_to, *f_to, *c_from1, *f_from1, *c_from2, *f_from2;')
	print('  uint32_t c_ext[%d], f_ext[%d];' % (unit_size, unit_size))
	print('  int32_t ir0, ir1, ir2, ir3, ir4, ir5, ir6, ir7, ir8, ir9, ir10, ir11;')
	print('  int32_t *cf, *cSfS, *bndry, *op_accum, *op_tmp, *op_tmp2;')
	print('  int32_t h_ext[%d];\n' % (unit_size * 4))


def copy_input_coefs(arr_name):
	MAX_MOVE = 22
	print('  %s_from1 = %s; %s_to = %s_ext;' % (arr_name, arr_name, arr_name, arr_name))
	for it in range(0, NN, MAX_MOVE):
		MOVE = min(MAX_MOVE, (NN - it))
		for rid in range(MOVE // 2):
			print('  r%d = *(%s_from1++);' % (rid, arr_name))
		for rid in range(MOVE // 2):
			print('  *(%s_to++) = r%d;' % (arr_name, rid))
	print('')


def print_extend_input_coefs(arr_name):
	MAX_MOVE = 5 if arr_name == 'f' else 3
	ext_bndry = NN // 2
	count_bndry = ext_bndry // 2
	print('uint32_t* extend_input_coefs_%s(uint32_t *%s_to) {' % (arr_name, arr_name))
	print('  uint32_t r0, r1, r2, r3, r4, r5;')
	print('  uint32_t *%s_from1, *%s_from2;' % (arr_name, arr_name))
	if arr_name == 'f':
		print('uint32_t r6, r7, r8, r9;')
	else:
		print('int32_t qR2inv, _2P15, q;')
		print('qR2inv = 935519;')
		print('_2P15 = 32768;')
		print('q = 4591;')
	for it in range(LVL):
		count = 0
		print('  %s_from1 = %s_to - %d; %s_from2 = %s_from1 + %d;' % (arr_name, arr_name, ext_bndry, arr_name, arr_name, count_bndry))
		for it2 in range(0, (ext_bndry // 2), MAX_MOVE):
			MOVE = min(MAX_MOVE, ((ext_bndry // 2) - it2))
			for rid in range(MOVE):
				count += 1
				print('  r%d = *(%s_from1++);' % (rid, arr_name))
				if count == count_bndry:
					print('  %s_from1 += %d;' % (arr_name, count_bndry))
				print('  r%d = *(%s_from2++);' % ((rid + MAX_MOVE), arr_name))
				if count == count_bndry:
					print('  %s_from2 += %d;' % (arr_name, count_bndry))
					count = 0
			for rid in range(MOVE):
				print('  r%d = __SADD16(r%d, r%d);' % (rid, rid, (rid + MAX_MOVE)))
			if (arr_name == 'c'):
				for rid in range(MOVE):
					print('  r%d = __SMLAWB(qR2inv, r%d, _2P15);' % (MAX_MOVE, rid))
					print('  r%d = __SMLAWT(qR2inv, r%d, _2P15);' % ((MAX_MOVE + 1), rid))
					print('  r%d = __SMULBT(q, r%d);' % (MAX_MOVE, MAX_MOVE))
					print('  r%d = __SMULBT(q, r%d);' % ((MAX_MOVE + 1), (MAX_MOVE + 1)))
					print('  r%d = __PKHBT(r%d, r%d, 16);' % (MAX_MOVE, MAX_MOVE, (MAX_MOVE + 1)))
					print('  r%d = __SSUB16(r%d, r%d);' % (rid, rid, MAX_MOVE))
			for rid in range(MOVE):
				print('  *(%s_to++) = r%d;' % (arr_name, rid))
		ext_bndry += (ext_bndry // 2)
		count_bndry //= 2
	print('  return %s_to;\n}\n' % (arr_name))


def print_hybrid_mult():
	input_size = NN * pow(1.5, LVL) // 2
	hybrid_mult_num = pow(3, LVL) #fully unrolled -> too heavy to compile
	print('// %dx %dx%d hybrid_mult' % (hybrid_mult_num, B, B))
	print('void hybrid_mult(int32_t *cf, uint32_t *c_from1, uint32_t *f_from1) {')
	print('  uint32_t r0, r1, r2, r3;')
	print('  int32_t ir0, ir1, ir2, ir3, ir4, ir5, ir6;')
	print('  int32_t *cSfS;')
	#print('  c_from1 = c_to - %d;' % (input_size))
	#print('  f_from1 = f_to - %d;' % (input_size))
	#print('  cf = h_ext;')
	print('  cSfS = cf + %d;' % (input_size * 4))
	print('  while (cf != cSfS) {')
	print('    r0 = *(c_from1++);')
	print('    r1 = *(c_from1++);')
	for product_idx in range(B // 2 - 1):
		(inc_arr_name, dec_arr_name) = ('f', 'c') if product_idx % 2 else ('c', 'f')
		ldr_reg = [2, 3, 1, 0] if product_idx % 2 else [0, 1, 3, 2]
		str_reg = [4, 5, 6, 3, 0, 1, 2] if product_idx % 2 else [0, 1, 2, 3, 4, 5, 6]
		window_size = min(product_idx + 1, (B // 2 - 1) - product_idx)
		for op_idx in range(window_size):
			if op_idx:
				if (op_idx == (window_size - 1)) and (product_idx >= (B // 4 - 1)) and (product_idx < (B // 2 - 3)):
					print('    r%d = *(%s_from1 + 1);' % (ldr_reg[1], inc_arr_name))
					print('    r%d = *(%s_from1--);' % (ldr_reg[0], inc_arr_name))
				else:
					print('    r%d = *(%s_from1++);' % (ldr_reg[0], inc_arr_name))
					print('    r%d = *(%s_from1++);' % (ldr_reg[1], inc_arr_name))
				if op_idx == (window_size - 1):
					print('    r%d = *(%s_from1 - 1);' % (ldr_reg[3], dec_arr_name))
					print('    r%d = *(%s_from1++);' % (ldr_reg[2], dec_arr_name))
				else:
					print('    r%d = *(%s_from1--);' % (ldr_reg[2], dec_arr_name))
					print('    r%d = *(%s_from1--);' % (ldr_reg[3], dec_arr_name))
				print('    ir%d = __SMLABB(r0, r2, ir%d);' % (str_reg[0], str_reg[0]))
				print('    ir%d = __SMLABB(r0, r3, ir%d);' % (str_reg[2], str_reg[2]))
				print('    ir%d = __SMLADX(r0, r2, ir%d);' % (str_reg[1], str_reg[1]))
				print('    ir%d = __SMLADX(r0, r3, ir%d);' % (str_reg[3], str_reg[3]))
				print('    ir%d = __SMLADX(r1, r3, ir%d);' % (str_reg[5], str_reg[5]))
				print('    ir%d = __SMLATT(r1, r2, ir%d);' % (str_reg[4], str_reg[4]))
				print('    ir%d = __SMLATT(r1, r3, ir%d);' % (str_reg[6], str_reg[6]))
			else:
				if product_idx:
					if product_idx < B // 4:
						print('    r%d = *(%s_from1 + 1);' % (ldr_reg[2], dec_arr_name))
						print('    r%d = *(%s_from1--);' % (ldr_reg[3], dec_arr_name))
					else:
						print('    r%d = *(%s_from1++);' % (ldr_reg[0], inc_arr_name))
						print('    r%d = *(%s_from1++);' % (ldr_reg[1], inc_arr_name))
					print('    ir%d = __SMLABB(r0, r2, ir%d);' % (str_reg[0], str_reg[0]))
					print('    ir%d = __SMLABB(r0, r3, ir%d);' % (str_reg[2], str_reg[2]))
					print('    ir%d = __SMLADX(r0, r2, ir%d);' % (str_reg[1], str_reg[1]))
				else:
					print('    r%d = *(%s_from1++);' % (ldr_reg[3], dec_arr_name))
					print('    r%d = *(%s_from1++);' % (ldr_reg[2], dec_arr_name))
					print('    ir%d = __SMULBB(r0, r2);' % (str_reg[0]))
					print('    ir%d = __SMULBB(r0, r3);' % (str_reg[2]))
					print('    ir%d = __SMUADX(r0, r2);' % (str_reg[1]))
				print('    ir%d = __SMUADX(r0, r3);' % (str_reg[3]))
				print('    ir%d = __SMUADX(r1, r3);' % (str_reg[5]))
				print('    ir%d = __SMULTT(r1, r2);' % (str_reg[4]))
				print('    ir%d = __SMULTT(r1, r3);' % (str_reg[6]))
			print('    ir%d = __SMLADX(r1, r2, ir%d);' % (str_reg[3], str_reg[3]))
			print('    r0 = __PKHBT(r1, r0, 0);')
			print('    ir%d = __SMLAD(r0, r2, ir%d);' % (str_reg[2], str_reg[2]))
			print('    ir%d = __SMLAD(r0, r3, ir%d);' % (str_reg[4], str_reg[4]))
		if (product_idx < (B // 4 - 1)) and (product_idx % 2):
			print('    r0 = *(c_from1 - 2);')
		if (product_idx >= (B // 4 - 1)) and (1 - product_idx % 2) and (product_idx < (B // 2 - 2)):
			print('    r0 = *(c_from1 + 1);')
		for reg in str_reg[ : 4]:
			print('    *(cf++) = ir%d;' % (reg))
	for reg in str_reg[4 : ]:
		print('    *(cf++) = ir%d;' % (reg))
	print('    *(cf++) = 0;')
	print('  }\n}\n')


def print_compose_output_coefs():
	MAX_MOVE = 5
	print('void compose_output_coefs(int32_t *h_ext) {')
	print('  int32_t ir0, ir1, ir2, ir3, ir4, ir5, ir6, ir7, ir8, ir9;')
	print('  int32_t *cSfS, *op_accum, *op_tmp, *op_tmp2;')
	for fold in range(LVL):
		unit_num = pow(3, (LVL - 1) - fold)
		unit_size = B * pow(2, fold)
		print('  op_accum = h_ext + %d;' % (unit_size)) #cf = h_ext + (unit_size * 4)x
		print('  cSfS = h_ext + %d;' % (unit_num * unit_size * 4))
		for it in range(unit_num):
			print('  op_tmp = op_accum + %d;' % (unit_size))
			for it2 in range(0, unit_size, MAX_MOVE):
				MOVE = min(MAX_MOVE, (unit_size - it2))
				for rid in range(MOVE):
					if rid:
						print('  ir%d = *(op_accum + %d);' % (rid, rid))
					else:
						print('  ir0 = *op_accum;')
					print('  ir%d = *(op_tmp++);' % (rid + MAX_MOVE))
				for rid in range(MOVE):
					print('  ir%d = ir%d - ir%d;' % (rid, rid + MAX_MOVE, rid))
				for rid in range(MOVE):
					print('  *(op_accum++) = ir%d;' % (rid))
			print('  op_tmp2 = op_accum - %d;' % (unit_size))
			for it2 in range(0, unit_size, MAX_MOVE):
				MOVE = min(MAX_MOVE, (unit_size - it2))
				for rid in range(MOVE):
					print('  ir%d = *(op_tmp++);' % (rid))
					print('  ir%d = *(op_tmp2++);' % (rid + MAX_MOVE))
				for rid in range(MOVE):
					print('  ir%d = ir%d - ir%d;' % (rid, rid, rid + MAX_MOVE))
				for rid in range(MOVE):
					print('  *(op_accum++) = ir%d;' % (rid))
			print('  op_accum = op_tmp2 - %d;' % (unit_size))
			print('  op_tmp = op_accum - %d;' % (unit_size))
			for it2 in range(0, unit_size, MAX_MOVE):
				MOVE = min(MAX_MOVE, (unit_size - it2))
				for rid in range(MOVE):
					if rid:
						print('  ir%d = *(op_accum + %d);' % (rid, rid))
					else:
						print('  ir0 = *op_accum;')
					print('  ir%d = *(op_tmp++);' % (rid + MAX_MOVE))
				for rid in range(MOVE):
					print('  ir%d = ir%d + ir%d;' % (rid, rid, rid + MAX_MOVE))
				for rid in range(MOVE):
					print('  *(op_accum++) = ir%d;' % (rid))
			print('  op_accum = op_tmp;')
			for it2 in range(0, unit_size * 2, MAX_MOVE):
				MOVE = min(MAX_MOVE, (unit_size * 2 - it2))
				for rid in range(MOVE):
					if rid:
						print('  ir%d = *(op_accum + %d);' % (rid, rid))
					else:
						print('  ir0 = *op_accum;')
					print('  ir%d = *(cSfS++);' % (rid + MAX_MOVE))
				for rid in range(MOVE):
					print('  ir%d = ir%d - ir%d;' % (rid, rid + MAX_MOVE, rid))
				for rid in range(MOVE):
					print('  *(op_accum++) = ir%d;' % (rid))
			if it < unit_num - 1:
				print('  op_accum = op_accum + %d;' % (unit_size * 2))
	print('}\n')


def copy_output_coefs():
	MAX_MOVE = 11;
	print('  op_accum = h;')
	print('  op_tmp = h_ext;')
	for it in range(0, NN * 2, MAX_MOVE):
		MOVE = min(MAX_MOVE, (NN * 2 - it))
		for rid in range(MOVE):
			print('  ir%d = *(op_tmp++);' % (rid))
		for rid in range(MOVE):
			print('  *(op_accum++) = ir%d;' % (rid))
	print('')


def print_prologue():
	print('#include \"Karatsuba.h\"\n')


def print_Karatsuba():
	input_size = NN * pow(1.5, LVL) // 2
	print('// %dx%d %d-layer Karatsuba' % (NN, NN, LVL))
	print('void Karatsuba_mult(int32_t *h, uint32_t *c, uint32_t *f) {')
	declare_tmp_vars()
	copy_input_coefs('c')
	copy_input_coefs('f')
	#extend_input_coefs('c')
	#extend_input_coefs('f')
	print('  c_to = extend_input_coefs_c(c_to);')
	print('  f_to = extend_input_coefs_f(f_to);')
	#hybrid_mult()
	print('  hybrid_mult(h_ext, c_to - %d, f_to - %d);' % (input_size, input_size))
	#compose_output_coefs()
	print('  compose_output_coefs(h_ext);')
	copy_output_coefs();
	print('}')


print_prologue()
print_extend_input_coefs('c')
print_extend_input_coefs('f')
print_hybrid_mult()
print_compose_output_coefs()
print_Karatsuba()
