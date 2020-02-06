PROJECT = awesomesauce
BUILD_DIR = bin

SHARED_DIR = ../my-common-code
CFILES = my-project.c
CFILES += Karatsuba.c Toom.c
CFILES += my_stm32fIO.c
CFILES += polymul_NxN_sch2p19_i.c
AFILES = schoolbook.S Karatsuba_asm.S

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
