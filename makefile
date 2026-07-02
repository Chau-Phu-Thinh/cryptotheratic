CC      = gcc
CFLAGS  = -std=c17 -Wall -Wextra -g -O2
LDFLAGS = -lm

SRC_DIR = src
BIN_DIR = bin

SRCS    = $(wildcard $(SRC_DIR)/*.c)

TEST_SRC = $(wildcard test/*.c)

TARGET      = $(BIN_DIR)/main
TEST_TARGET = $(BIN_DIR)/test_suite

all: $(BIN_DIR)
	$(CC) $(CFLAGS) $(SRCS) -o $(TARGET) -lm

run: $(TARGET)
	./$(TARGET)
test: | $(BIN_DIR) $(OBJ_DIR)

test: $(TEST_TARGET)
	./$(TEST_TARGET)
$(BIN_DIR) $(OBJ_DIR):
	mkdir -p $@

clean:
	rm -rf  $(BIN_DIR)

.PHONY: all test clean
