with open('polymul_256x256_bar_B64.original.S') as f:
	for line in f:
		if line[0] == '\t' and line[1] <= 'z' and line[1] >= 'a':
			out_line = line[1 : ]
			out_cut = out_line.find('\t')
			if out_line[ : out_cut] == 'ittt':
				print('\tnop.n')
				print(line, end='')
			elif out_line[ : out_cut] == 'br_16x2': print(line, end='')
			elif out_line[ : out_cut] == 'br_32': print(line, end='')
			elif out_line[ : out_cut] == 'br_32x2': print(line, end='')
			else: print('\t' + out_line[ : out_cut] + '.w' + out_line[out_cut : ], end='')
		else:
			print(line, end='')