# ==========================================
# Vylix OS - Hệ thống Build Đa kiến trúc
# ==========================================

ARCH ?= aarch64
BUILD_DIR = build/$(ARCH)

# Cấu hình công cụ cho từng kiến trúc
ifeq ($(ARCH), aarch64)
    AS = aarch64-linux-gnu-as
    CC = aarch64-linux-gnu-g++
    LD = aarch64-linux-gnu-ld
    QEMU = qemu-system-aarch64
    QEMU_FLAGS = -M virt -cpu cortex-a57 -nographic
    # Tìm file .s hoặc .S trong thư mục arch/aarch64/
    BOOT_SRC = $(wildcard arch/aarch64/boot*.s) $(wildcard arch/aarch64/boot*.S)
    LINK_SRC = arch/aarch64/linker.ld
    # Sử dụng softfloat để an toàn hơn cho giai đoạn đầu
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

# 1. Biên dịch Rust Core (Nếu có thay đổi)
$(RUST_LIB): rust_core/src/lib.rs rust_core/Cargo.toml
	@echo "--- Đang biên dịch Rust Core ---"
	cd rust_core && cargo build --release --target $(RUST_TARGET)

# 2. Biên dịch Assembly
$(BUILD_DIR)/boot.o: $(BOOT_SRC)
	@mkdir -p $(BUILD_DIR)
	$(AS) $(BOOT_SRC) -o $(BUILD_DIR)/boot.o

# 3. Biên dịch C++
$(BUILD_DIR)/kmain.o: kernel/kmain.cpp
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c kernel/kmain.cpp -o $(BUILD_DIR)/kmain.o

# 4. Liên kết tất cả (Assembly + C++ + Rust)
$(BUILD_DIR)/vylix.elf: $(BUILD_DIR)/boot.o $(BUILD_DIR)/kmain.o $(RUST_LIB)
	@echo "--- Đang liên kết OS hoàn chỉnh ---"
	$(LD) -T $(LINK_SRC) -o $(BUILD_DIR)/vylix.elf $(BUILD_DIR)/boot.o $(BUILD_DIR)/kmain.o $(RUST_LIB)

run: all
	$(QEMU) $(QEMU_FLAGS) -kernel $(BUILD_DIR)/vylix.elf

clean:
	rm -rf build rust_core/target