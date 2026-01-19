#include <stdint.h>

/* Declare a function from Rust */

extern "C" {
void rust_panic_handler();

}

/**

* HAL function: Stops the CPU waiting for an interrupt

* Helps C++ code not depend on the assembly of each chip

*/
inline void cpu_halt() {
#ifdef __aarch64__

asm volatile("wfi");

#elif defined(__x86_64__)

asm volatile("hlt");

#endif

}

/* Note: This UART address is only correct on ARM QEMU */

/* On x86, we will need a different printing method (I/O Ports) */

volatile uint8_t* UART0 = (uint8_t*)0x09000000;

void print(const char* s) {
#ifdef __aarch64__

while(*s != '\0') {
*UART0 = (uint8_t)(*s);

s++;

}
#elif defined(__x86_64__)

// For now, we don't have a UART/Serial driver on x86

// I will guide you on how to write the x86 driver later
#endif

}

extern "C" void kmain() {

print("Vylix OS is booting...\n");

while(1) {
cpu_halt();

}
}