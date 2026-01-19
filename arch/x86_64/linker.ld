/*

Vylix OS - x86_64 Linker Script

Defines the memory layout for the Desktop version.
*/

ENTRY(_start)

SECTIONS
{
/* PC platforms typically start loading the Kernel at the 1MB mark */
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