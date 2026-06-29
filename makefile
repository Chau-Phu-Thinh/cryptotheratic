CC = gcc
CFLAGS = -Wall -Wextra -std=c17
LDFLAGS = -lm

SRC = $(wildcard src/*.c)
OBJ = $(SRC:.c=.o)

TARGET = main

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $(TARGET) $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

run: all
	./$(TARGET)

debug: CFLAGS += -g
debug: clean all

clean:
	rm -f $(OBJ) $(TARGET)
