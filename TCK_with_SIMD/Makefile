PROJECT = awesomesauce
BUILD_DIR = bin
#ARCH_FLAGS = "-mthumb -mcpu=cortex-m4 -mfloat-abi=hard -mfpu=fpv4-sp-d16"

SHARED_DIR = ../my-common-code
CFILES = my-project.c
CFILES += Karatsuba.c Toom.c schoolbook.c
CFILES += my_stm32fIO.c
CFILES += polymul_NxN_sch2p19_i.c
#AFILES += schoolbook_original.S

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
