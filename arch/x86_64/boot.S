/*
 * Vylix OS - x86_64 Bootloader (Multiboot2)
 * Entry point for the Desktop version
 */

#define MULTIBOOT2_HEADER_MAGIC     0xe85250d6
#define MULTIBOOT2_ARCHITECTURE_X86 0
#define MULTIBOOT2_HEADER_LENGTH    24
#define MULTIBOOT2_CHECKSUM         -(MULTIBOOT2_HEADER_MAGIC + MULTIBOOT2_ARCHITECTURE_X86 + MULTIBOOT2_HEADER_LENGTH)

.section .multiboot_header
header_start:
    .long MULTIBOOT2_HEADER_MAGIC
    .long MULTIBOOT2_ARCHITECTURE_X86
    .long MULTIBOOT2_HEADER_LENGTH
    .long MULTIBOOT2_CHECKSUM
    /* End Tags */
    .short 0
    .short 0
    .long 8
header_end:

.section .text
.global _start
.type _start, @function

_start:
    /* Setup Stack for x86_64 */
    mov $stack_top, %esp
    
    /* Jump to C++ kmain function */
    extern kmain
    call kmain

hang:
    cli                      /* Disable interrupts */
1:  hlt                      /* Halt the CPU */
    jmp 1b                   /* Infinite loop if halted CPU wakes up */

.section .bss
.align 16
stack_bottom:
.skip 16384                  /* 16KB Stack Space */
stack_top: