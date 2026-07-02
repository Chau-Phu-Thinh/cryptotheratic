CC      = gcc
CFLAGS  = -std=c17 -Wall -Wextra -g -O2
LDFLAGS = -lm

SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin

SRCS    = $(wildcard $(SRC_DIR)/*.c)
OBJS    = $(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

TEST_SRC = $(wildcard test/*.c)
TEST_OBJ = $(TEST_SRC:test/%.c=$(OBJ_DIR)/%.o)

TARGET      = $(BIN_DIR)/main
TEST_TARGET = $(BIN_DIR)/test_suite

all: | $(BIN_DIR) $(OBJ_DIR)
all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

test: | $(BIN_DIR) $(OBJ_DIR)
test: $(TEST_TARGET)
	./$(TEST_TARGET)

$(TEST_TARGET): $(TEST_OBJ) $(filter-out $(OBJ_DIR)/main.o, $(OBJS))
	$(CC) $^ -o $@ $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: test/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BIN_DIR) $(OBJ_DIR):
	mkdir -p $@

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

.PHONY: all test clean
