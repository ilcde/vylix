# ==========================================
# Vylix OS - Multi-Architecture Build System
# ==========================================

ARCH ?= aarch64
BUILD_DIR = build/$(ARCH)

# Configure tools for each architecture
ifeq ($(ARCH), aarch64)

AS = aarch64-linux-gnu-as

CC = aarch64-linux-gnu-g++

LD = aarch64-linux-gnu-ld

QEMU = qemu-system-aarch64
QEMU_FLAGS = -M virt -cpu cortex-a57 -nographic
# Find .s or .S files in the arch/aarch64/ directory

BOOT_SRC = $(wildcard arch/aarch64/boot*.s) $(wildcard arch/aarch64/boot*.S)

LINK_SRC = arch/aarch64/linker.ld 
# Use softfloat to be safer in the early stages 
RUST_TARGET = aarch64-unknown-none-softfloat
else ifeq ($(ARCH), x86_64) 
AS = x86_64-linux-gnu-as 
CC = x86_64-linux-gnu-g++ 
LD = x86_64-linux-gnu-ld 
QEMU = qemu-system-x86_64 
QEMU_FLAGS = -serial stdio -display none 
BOOT_SRC = $(wildcard arch/x86_64/boot*.s) $(wildcard arch/x86_64/boot*.S) 
LINK_SRC = arch/x86_64/linker.ld 
RUST_TARGET = x86_64-unknown-none
endif

CFLAGS = -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti -std=c++23
RUST_LIB = rust_core/target/$(RUST_TARGET)/release/libvylix_rust.a

all: $(BUILD_DIR)/vylix.elf

# 1. Compile Rust Core (If changes occur)
$(RUST_LIB): rust_core/src/lib.rs rust_core/Cargo.toml

@echo "--- Compiling Rust Core ---"

cd rust_core && cargo build --release --target $(RUST_TARGET)

# 2. Compile Assembly
$(BUILD_DIR)/boot.o: $(BOOT_SRC)

@mkdir -p $(BUILD_DIR)

$(AS) $(BOOT_SRC) -o $(BUILD_DIR)/boot.o

# 3. Compile C++
$(BUILD_DIR)/kmain.o: kernel/kmain.cpp 
@mkdir -p $(BUILD_DIR) 
$(CC) $(CFLAGS) -c kernel/kmain.cpp -o $(BUILD_DIR)/kmain.o

#4. Link it all (Assembly + C++ + Rust)
$(BUILD_DIR)/vylix.elf: $(BUILD_DIR)/boot.o $(BUILD_DIR)/kmain.o $(RUST_LIB) 
@echo "--- Complete OS linking ---" 
$(LD) -T $(LINK_SRC) -o $(BUILD_DIR)/vylix.elf $(BUILD_DIR)/boot.o $(BUILD_DIR)/kmain.o $(RUST_LIB)

run: all 
$(QEMU) $(QEMU_FLAGS) -kernel $(BUILD_DIR)/vylix.elf

clean: 
rm -rf build rust_core/target