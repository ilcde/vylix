#include <stdint.h>

/**

* Vylix OS - C++ Main Entry

* This is where the operating system's "brain" begins processing

*/

/* UART0 port address on the QEMU ARM Virt emulator (Used for printing text) */
volatile uint8_t* UART0 = (uint8_t*)0x09000000;

extern "C" void kmain() {

/* Vylix OS's first greeting */

const char* message = "WELCOME TO VYLIX OS!\nStatus: Kernel C++ Booted Successfully on ARM64.\n";

/* Loop to send each character to the console */

for(int i = 0; message[i] != '\0'; i++) {

*UART0 = (uint8_t)message[i];

}

/* Infinite loop keeps the operating system running */

while(1) {

/* Assembly instruction lets the CPU rest when not in use */

asm volatile("wfi");

}
}