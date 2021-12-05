# template
BUILD_DIR=build
SRC=$(wildcard *.c)
OBJS=$(addprefix $(BUILD_DIR)/, $(SRC:.c=.o))
EXE1=$(BUILD_DIR)/inline1
EXE2=$(BUILD_DIR)/inline2

.PHONY: clean all

# Keep the intermediate .o files
.SECONDARY: $(OBJS)

all: $(EXE1) $(EXE2)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/%: %.c | $(BUILD_DIR) 
	gcc -o $@ $^ -masm=intel -no-pie

run: all
	$(EXE1)
	$(EXE2)

clean:
	rm -rf $(BUILD_DIR)

