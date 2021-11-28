# template
BUILD_DIR=build
SRC=$(wildcard *.c)
OBJS=$(addprefix $(BUILD_DIR)/, $(SRC:.c=.o))
EXE=$(BUILD_DIR)/inline1

.PHONY: clean all

# Keep the intermediate .o files
.SECONDARY: $(OBJS)

all: $(EXE)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(EXE): $(SRC) | $(BUILD_DIR) 
	gcc -o $@ $^ -masm=intel -no-pie

run: all
	$(EXE)

clean:
	rm -rf $(BUILD_DIR)

