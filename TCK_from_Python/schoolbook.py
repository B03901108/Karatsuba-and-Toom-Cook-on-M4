#!/usr/bin/python
import sys
import re
from math import log2, ceil, floor, sqrt

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
	print('.global hybrid_mult_asm')
	print('.type hybrid_mult_asm, %function')
	print('')


def print_hybrid_mult():
	input_size = NN * pow(1.5, LVL) // 2
	hybrid_mult_num = pow(3, LVL) #fully unrolled -> too heavy to compile
	print('// %dx %dx%d hybrid multiplication' % (hybrid_mult_num, B, B))
	print('// void hybrid_mult_asm(int32_t *cf, uint32_t *c_from1, uint32_t *f_from1);')
	print('hybrid_mult_asm:')
	print('  push.w {r4-r12, lr}')
	print('  add.w r7, r0, #%d' % (input_size * 4 * 4))
#	for iter_round in range(hybrid_mult_num):
	print('snake_body:')
	print('  vmov.w s0, r7')
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
			print('  mov.w r3, #0')
		elif (product_idx < (B // 4 - 1)) and (product_idx % 2):
			print('  ldr.w r3, [r1, #-8]')
		elif (product_idx >= (B // 4 - 1)) and (1 - product_idx % 2):
			print('  ldr.w r3, [r1, #4]')
		for reg in str_reg[ : 4]:
			print('  str.w %s, [r0], #4' % (reg))
	for reg in str_reg[4 : ]:
		print('  str.w %s, [r0], #4' % (reg))
	print('  str.w r3, [r0], #4')
	print('  vmov.w r7, s0')
	print('  cmp.w r0, r7')
	print('  bne.w snake_body')
	print('  pop.w {r4-r12, pc}')


print_prologue()
print_hybrid_mult()
