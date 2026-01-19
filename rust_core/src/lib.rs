#![no_std]
#![no_main]

/**
 * Vylix OS - Rust Core Component
 * File này chứa các hàm xử lý an toàn mức thấp cho nhân hệ điều hành.
 */

/* * Hàm xử lý lỗi nghiêm trọng (Panic) được gọi từ C++.
 * Chúng ta sử dụng #[no_mangle] để giữ nguyên tên hàm khi liên kết (Link).
 */
#[no_mangle]
pub extern "C" fn rust_panic_handler() -> ! {
    // Trong các giai đoạn tới, chúng ta sẽ lập trình để in thông báo lỗi 
    // chi tiết ra màn hình UART hoặc Framebuffer tại đây.
    loop {
        // Lệnh gợi ý CPU nghỉ ngơi để tránh quá nhiệt trong vòng lặp vô tận
    }
}

/**
 * Panic Handler bắt buộc cho môi trường no_std.
 * Hàm này sẽ được gọi khi code Rust xảy ra lỗi runtime (ví dụ: truy cập mảng ngoài phạm vi).
 */
#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
    // Gọi hàm panic handler chung của hệ thống
    rust_panic_handler()
}