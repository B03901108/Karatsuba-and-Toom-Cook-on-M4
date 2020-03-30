#!/bin/bash
lenT4=$1
lenKA=$2
lenSM=$3
make clean
while [ $lenT4 -gt $lenKA ]
do
	nextT4=$(( $lenT4 / 4 ))
	python3 Toom-asm_structured_general.py $lenT4 t gf_polymul_${lenT4}x${lenT4} gf_polymul_${nextT4}x${nextT4} $4 >gf_polymul_${lenT4}x${lenT4}.S
	lenT4=$nextT4
done
python3 Karatsuba-asm_structured_general.py $lenKA $lenSM t gf_polymul_${lenKA}x${lenKA} $4 >gf_polymul_${lenKA}x${lenKA}.S
make
st-flash write awesomesauce.bin 0x08000000
minicom
