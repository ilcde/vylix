# Makefile cho Vylix OS - ARM64
# Cách dùng: gõ 'make run'

# Công cụ biên dịch chéo
AS = aarch64-linux-gnu-as
CC = aarch64-linux-gnu-g++
LD = aarch64-linux-gnu-ld

# Cấu hình biên dịch (Tắt thư viện chuẩn, tối ưu hệ thống)
CFLAGS = -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti -std=c++23

all: build/vylix.elf

# 1. Biên dịch file khởi động Assembly
build/boot.o: arch/aarch64/boot_arm64.S
	mkdir -p build
	$(AS) arch/aarch64/boot_arm64.S -o build/boot.o

# 2. Biên dịch file nhân C++
build/kmain.o: kernel/kmain.cpp
	mkdir -p build
	$(CC) $(CFLAGS) -c kernel/kmain.cpp -o build/kmain.o

# 3. Liên kết (Link) các file thành file OS hoàn chỉnh
build/vylix.elf: build/boot.o build/kmain.o
	$(LD) -T arch/aarch64/linker.ld -o build/vylix.elf build/boot.o build/kmain.o

# 4. Chạy giả lập QEMU
run: all
	qemu-system-aarch64 -M virt -cpu cortex-a57 -nographic -kernel build/vylix.elf

clean:
	rm -rf build