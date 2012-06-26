#==========================================================
#	File:	Makefile for Cortex-M3
#	Date:	2011-08-15
#==========================================================

OPTIMIZATION = s

#----------------------------------------------------------

SRC_C  = main.c
SRC_C += core_cm3.c
SRC_C += stm32l1xx_it.c
SRC_C += mcu_rcc.c
SRC_C += system_stm32l1xx.c

SRC_ASM += startup_stm32l1xx_md.s

#----------------------------------------------------------

PROGRAMMATOR = "C:/Tools/STMicroelectronics/STM32 ST-Link Utility/ST-Link Utility/ST-LINK_CLI.exe"

CROSS_PATH = C:/Tools/CodeSourcery/2010-09-51/

CROSS = $(CROSS_PATH)/bin/arm-none-eabi-

INCLUDES += -I$(CROSS_PATH)/arm-none-eabi/include
INCLUDES += -I$(CROSS_PATH)/arm-none-eabi/include/lib
INCLUDES += -Imcu
INCLUDES += -Imcu/peripherals
INCLUDES += -Iutility
INCLUDES += -Ilibrary/inc
INCLUDES += -Ilibrary/src

VPATH += mcu
VPATH += mcu/peripherals
VPATH += utility
VPATH += library/inc
VPATH += library/src

#----------------------------------------------------------

FLAGS_C  = $(INCLUDES) -I.
FLAGS_C += -O$(OPTIMIZATION)
FLAGS_C += -gdwarf-2
FLAGS_C += -Wall
FLAGS_C += -c
FLAGS_C += -fmessage-length=0
FLAGS_C += -fno-builtin
FLAGS_C += -ffunction-sections
FLAGS_C += -fdata-sections
FLAGS_C += -msoft-float
FLAGS_C += -mapcs-frame
FLAGS_C += -D__thumb2__=1
FLAGS_C += -mno-sched-prolog
FLAGS_C += -fno-hosted
FLAGS_C += -mtune=cortex-m3
FLAGS_C += -mcpu=cortex-m3
FLAGS_C += -mthumb
FLAGS_C += -mfix-cortex-m3-ldrd
FLAGS_C += -fno-strict-aliasing
FLAGS_C += -ffast-math

FLAGS_LD = -Xlinker -Map=target/target.map
FLAGS_LD += -Wl,--gc-sections
FLAGS_LD += -mcpu=cortex-m3
FLAGS_LD += -mthumb
FLAGS_LD += -static   
FLAGS_LD += -nostdlib

#LIB_LD = -lm

FLAGS_ASM  = -D__ASSEMBLY__
FLAGS_ASM += -g $(FLAGS_C)
FLAGS_ASM += -I. -x assembler-with-cpp

#----------------------------------------------------------

all: clean target.elf

mcu_all: clean target.elf mcu_prog
 
mcu_prog:
	@$(PROGRAMMATOR) -c SWD -ME -P "target/target.bin" 0x08000000 -Rst -Run
 
mcu_reset:
	@$(PROGRAMMATOR) -c SWD -Rst -Run

%.elf: $(SRC_ASM:%.S=target/%.o) $(SRC_C:%.c=target/%.o)
	@echo Linking: $@
	@$(CROSS)gcc $(FLAGS_LD) -T'mcu/stm32l152rb.lsf' -o 'target/$@' $^ $(LIB_LD)
	@echo '-----------------------------------------------------------'
	@$(CROSS)size 'target/target.elf'
	@$(CROSS)objcopy -O binary 'target/target.elf' 'target/target.bin'
	@$(CROSS)objcopy -O ihex 'target/target.elf' 'target/target.hex'
	@$(CROSS)objdump -h -S -z 'target/target.elf' > 'target/target.lss'
	@$(CROSS)nm -n 'target/target.elf' > 'target/target.sym'
	@rm -f target/*.o

$(SRC_C:%.c=target/%.o): target/%.o: %.c
	@echo Compiling: $<
	@$(CROSS)gcc $(FLAGS_C) -c $< -o $@

$(SRC_ASM:%.s=target/%.o): target/%.o: %.s
	@echo Compiling asm: $<
	@$(CROSS)gcc $(FLAGS_ASM) -c $< -o $@

git:
	@C:/Tools/git/bin/git gui

clean:
	@echo '-----------------------------------------------------------'
#	@rm -f target/*.*	

.PHONY : all clean mcu_prog mcu_reset
