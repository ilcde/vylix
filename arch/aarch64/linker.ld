/* * VYLIX OS - Linker Script cho ARM64
 * Xác định vị trí các thành phần mã nguồn trong RAM khi khởi động
 */

ENTRY(_start)

SECTIONS
{
    /* QEMU ARM 'virt' board bắt đầu nạp Kernel tại địa chỉ 0x40000000 */
    . = 0x40000000;

    /* 1. Phần mã lệnh (Code) */
    .text : {
        KEEP(*(.text.boot)) /* Đảm bảo code boot không bị trình biên dịch xóa */
        *(.text .text.*)
    }

    /* 2. Phần dữ liệu chỉ đọc (Hằng số, chuỗi chữ) */
    .rodata : {
        *(.rodata .rodata.*)
    }

    /* 3. Phần dữ liệu có thể ghi (Biến toàn cục đã khởi tạo) */
    .data : {
        *(.data .data.*)
    }

    /* 4. Phần dữ liệu chưa khởi tạo (BSS) */
    .bss : {
        . = ALIGN(16);
        _bss_start = .;
        *(.bss .bss.*)
        *(COMMON)
        _bss_end = .;
    }

    /* 5. Thiết lập vùng Stack (Ngăn xếp) cho C++ - Độ lớn 16KB */
    . = ALIGN(16);
    . += 0x4000; 
    _stack_top = .;

    /* Loại bỏ các phần không cần thiết để file OS nhẹ hơn */
    /DISCARD/ : { *(.comment) *(.gnu*) *(.note*) *(.eh_frame) }
}