#include <stdint.h>

/* Khai báo hàm từ Rust */
extern "C" {
    void rust_panic_handler();
}

/**
 * Hàm HAL: Dừng CPU chờ ngắt
 * Giúp code C++ không bị phụ thuộc vào Assembly của từng chip
 */
inline void cpu_halt() {
#ifdef __aarch64__
    asm volatile("wfi");
#elif defined(__x86_64__)
    asm volatile("hlt");
#endif
}

/* Lưu ý: Địa chỉ UART này chỉ đúng trên ARM QEMU */
/* Trên x86, chúng ta sẽ cần một phương pháp in khác (I/O Ports) */
volatile uint8_t* UART0 = (uint8_t*)0x09000000;

void print(const char* s) {
#ifdef __aarch64__
    while(*s != '\0') {
        *UART0 = (uint8_t)(*s);
        s++;
    }
#elif defined(__x86_64__)
    // Tạm thời trên x86 chúng ta chưa có driver UART/Serial
    // Mình sẽ hướng dẫn bạn viết driver x86 sau
#endif
}

extern "C" void kmain() {
    print("Vylix OS is booting...\n");

    while(1) {
        cpu_halt();
    }
}