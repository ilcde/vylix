/*
 * Vylix OS - ARM64 Bootloader
 * Đây là những dòng code đầu tiên chạy khi bật máy (Mobile)
 */

.section .text.boot

.global _start

_start:
    /* 1. Kiểm tra mã định danh CPU (Processor ID) */
    mrs     x0, mpidr_el1
    and     x0, x0, #0xFF        /* Lấy Core ID */
    cbz     x0, master           /* Nếu là Core 0 (nhân chính) -> Chạy tiếp */
    b       hang                 /* Các nhân khác -> Cho ngủ (tiết kiệm điện) */

master:
    /* 2. Thiết lập ngăn xếp (Stack) cho C++ */
    /* C++ cần Stack để lưu biến cục bộ và gọi hàm */
    ldr     x0, =_stack_top
    mov     sp, x0

    /* 3. Xóa sạch vùng nhớ BSS (Biến toàn cục chưa khởi tạo) */
    ldr     x0, =_bss_start
    ldr     x1, =_bss_end
    sub     x1, x1, x0           /* Tính toán kích thước vùng BSS */
    cbz     x1, run_kernel       /* Nếu kích thước bằng 0, nhảy thẳng vào kernel */

clear_bss:
    str     xzr, [x0], #8        /* Ghi đè số 0 vào vùng nhớ */
    subs    x1, x1, #8           /* Giảm kích thước còn lại */
    bgt     clear_bss            /* Tiếp tục nếu còn vùng nhớ */

run_kernel:
    /* 4. Nhảy vào hàm kmain của C++ */
    bl      kmain

hang:
    /* Vòng lặp vô tận nếu Kernel thoát (không nên xảy ra) */
    wfe
    b       hang