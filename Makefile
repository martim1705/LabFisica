CC := gcc
BUILD ?= Debug

RAYLIB_DIR := build/raylib/src
RAYLIB_LIB := $(RAYLIB_DIR)/libraylib.a

SOURCES := $(wildcard src/*.c)
OBJECTS := $(patsubst src/%.c,obj/$(BUILD)/%.o,$(SOURCES))
DEPS := $(OBJECTS:.o=.d)
TARGET := bin/$(BUILD)/chess

CPPFLAGS := -Iinclude -I$(RAYLIB_DIR)
CFLAGS := -std=c17 -Wall -Wextra -MMD -MP
LDLIBS := $(RAYLIB_LIB) -lGL -lm -lpthread -ldl -lrt -lX11

ifeq ($(BUILD),Release)
	CFLAGS += -O2 -DNDEBUG
else
	CFLAGS += -O0 -g
endif

.PHONY: all debug release run clean

all: $(TARGET)

debug:
	$(MAKE) BUILD=Debug

release:
	$(MAKE) BUILD=Release

run: $(TARGET)
	./$(TARGET)

$(TARGET): $(RAYLIB_LIB) $(OBJECTS) | bin/$(BUILD)
	$(CC) $(OBJECTS) -o $@ $(LDLIBS)

$(RAYLIB_LIB):
	$(MAKE) -C $(RAYLIB_DIR) PLATFORM=PLATFORM_DESKTOP

obj/$(BUILD)/%.o: src/%.c | obj/$(BUILD)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

bin/$(BUILD) obj/$(BUILD):
	mkdir -p $@

clean:
	rm -rf bin obj
	$(MAKE) -C $(RAYLIB_DIR) clean

-include $(DEPS)
