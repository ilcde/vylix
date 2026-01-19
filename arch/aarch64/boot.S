/*
 * Vylix OS - ARM64 Bootloader
 * First instructions executed upon CPU startup for Mobile/ARM64.
 */

.section .text.boot

.global _start

_start:
    /* 1. Check Processor ID */
    mrs     x0, mpidr_el1
    and     x0, x0, #0xFF        /* Extract the Core ID */
    cbz     x0, master           /* If Core 0 (primary), proceed to master initialization */
    b       hang                 /* Other cores enter low-power wait loop */

master:
    /* 2. Setup Stack Pointer (SP) for C++ */
    /* C++ requires a valid stack for local variables and function calls */
    ldr     x0, =_stack_top
    mov     sp, x0

    /* 3. Clear BSS Section (Uninitialized global variables) */
    ldr     x0, =_bss_start
    ldr     x1, =_bss_end
    sub     x1, x1, x0           /* Calculate BSS size */
    cbz     x1, run_kernel       /* Skip if BSS size is zero */

clear_bss:
    str     xzr, [x0], #8        /* Write zero to memory using xzr register */
    subs    x1, x1, #8           /* Decrement remaining size */
    bgt     clear_bss            /* Continue looping if size > 0 */

run_kernel:
    /* 4. Jump to C++ Kernel Entry Point */
    bl      kmain

hang:
    /* Infinite loop if the Kernel ever exits (unexpected behavior) */
    wfe                          /* Wait For Event - saves power */
    b       hang

/* The linker script will define _stack_top, _bss_start, and _bss_end */