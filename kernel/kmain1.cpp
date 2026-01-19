#include <stdint.h>

/**
 * Vylix OS - C++ Main Entry
 * Đây là nơi "bộ não" của hệ điều hành bắt đầu xử lý
 */

/* Địa chỉ cổng UART0 trên giả lập QEMU ARM Virt (Dùng để in chữ) */
volatile uint8_t* UART0 = (uint8_t*)0x09000000;

extern "C" void kmain() {
    /* Lời chào đầu tiên của Vylix OS */
    const char* message = "WELCOME TO VYLIX OS!\nStatus: Kernel C++ Booted Successfully on ARM64.\n";
    
    /* Vòng lặp gửi từng ký tự ra màn hình console */
    for(int i = 0; message[i] != '\0'; i++) {
        *UART0 = (uint8_t)message[i];
    }

    /* Vòng lặp vô tận giữ hệ điều hành luôn chạy */
    while(1) {
        /* Lệnh Assembly giúp CPU nghỉ ngơi khi không có việc */
        asm volatile("wfi");
    }
}