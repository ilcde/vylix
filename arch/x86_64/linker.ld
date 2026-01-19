/*

Vylix OS - x86_64 Linker Script
*/

ENTRY(_start)

SECTIONS
{
/* PC thường bắt đầu nạp Kernel tại 1MB */
. = 1M;

.text BLOCK(4K) : ALIGN(4K)
{
    KEEP(*(.multiboot_header))
    *(.text .text.*)
}

.rodata BLOCK(4K) : ALIGN(4K)
{
    *(.rodata .rodata.*)
}

.data BLOCK(4K) : ALIGN(4K)
{
    *(.data .data.*)
}

.bss BLOCK(4K) : ALIGN(4K)
{
    *(COMMON)
    *(.bss .bss.*)
}


}