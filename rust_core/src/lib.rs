#![no_std]
#![no_main]

/**

* Vylix OS - Rust Core Component

* This file contains low-level safe handling functions for the operating system kernel.

*/

* * The Panic handler function is called from C++.

* We use #[no_mangle] to keep the function name intact when linking.

*/
#[no_mangle]
pub extern "C" fn rust_panic_handler() -> ! {

/ // In the following stages, we will program to print the error message

/ // details to the UART or Framebuffer screen here.

loop {

/ Command to suggest CPU rest to avoid overheating in the infinite loop

}
}

/**
* Panic Handler is required for the no_std environment.

* This function will be called when Rust code encounters a runtime error (e.g., out-of-scope array access).

*/
#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {

// Call the system's common panic handler function

rust_panic_handler()
}