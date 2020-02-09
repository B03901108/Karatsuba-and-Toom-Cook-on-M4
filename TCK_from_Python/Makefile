PROJECT = awesomesauce
BUILD_DIR = bin

SHARED_DIR = ../my-common-code
CFILES = my-project.c
CFILES += Karatsuba.c Toom.c
CFILES += my_stm32fIO.c
AFILES = schoolbook.S Karatsuba_asm.S
AFILES += polymul_8x8_sch.S polymul_16x16_sch.S polymul_32x32_sch.S polymul_64x64_sch.S
AFILES += polymul_128x128_bar_B64.S polymul_256x256_bar_B64.S polymul_768x768_bar_B48.S

# TODO - you will need to edit these two lines!
DEVICE=stm32f407vgt6
OOCD_FILE = board/stm32f4discovery.cfg

# You shouldn't have to edit anything below here.
VPATH += $(SHARED_DIR)
INCLUDES += $(patsubst %,-I%, . $(SHARED_DIR))
OPENCM3_DIR=../libopencm3

include $(OPENCM3_DIR)/mk/genlink-config.mk
include ../rules.mk
include $(OPENCM3_DIR)/mk/genlink-rules.mk
