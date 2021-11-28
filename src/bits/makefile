# template
BUILD_DIR := ./build
MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MAKEFILE_DIR := $(dir $(MAKEFILE_PATH))

C_SRCS := $(wildcard *.c)
C_OBJS := $(patsubst %.c,%.o,$(C_SRCS))
ASM_SRCS := $(wildcard *.asm)
ASM_OBJS := $(addprefix $(BUILD_DIR)/,$(patsubst %.asm,%.o,$(ASM_SRCS)))

BITS := $(BUILD_DIR)/bits
BITS3 := $(BUILD_DIR)/bits3
ALL := $(BITS) $(BITS3)

LINK := gcc -g -no-pie -o

.PHONY: clean all run

# Keep the intermediate .o files
.SECONDARY: $(C_OBJS) $(ASM_OBJS)

# == ALL ==
all: $(ALL)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# == Link ==
$(BITS): bits.o printb.o | $(BUILD_DIR)
	$(LINK) $@ $^

$(BITS3): bits3.o printb.o | $(BUILD_DIR)
	$(LINK) $@ $^

# == Assemble ==
%.o: %.asm | $(BUILD_DIR)
	nasm -f elf64 -g -F dwarf $^ -o $@ -l $@.lst --keep-all -p "$(MAKEFILE_DIR)../constants.inc"

%.o: %.c | $(BUILD_DIR)
	gcc -c $^ -o $@

run: all
	$(BITS)
	$(BITS3)

clean:
	rm -rf $(BUILD_DIR)

