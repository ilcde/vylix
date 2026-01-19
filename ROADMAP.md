# **🗺️ Vylix OS Development Roadmap**

Detailed development timeline for the Vylix Operating System \- a Modern Hybrid Microkernel.

## **🏗️ Phase 0: Inception (Current)**

*Setting the foundation and development environment.*

* \[x\] **Define Architecture:** Hybrid design established (C++ Core / Rust Security / ASM Foundation).  
* \[x\] **Setup Cross-Compilation Toolchain:** Configured GCC/Clang \+ Rustc for AArch64 and x86\_64.  
* \[ \] **Configure Build System:** Finalize the build system (GNU Make / CMake \+ Cargo integration).

## **⚡ Phase 1: The Spark (Target: Month 1-3)**

*Kernel boot and first hardware output.*

* \[ \] **Assembly Stubs:** Write boot.s to initialize Stack Pointers and GDT/IDT entries.  
* \[ \] **C++ Entry Point:** Implement the jump from Assembly to the high-level kmain() function.  
* \[ \] **Basic Output:** Implement UART (PL011) and VGA/Serial output to print "Hello Vylix" on QEMU.

## **🧠 Phase 2: The Core Manager (Target: Month 4-6)**

*Fundamental system resource management.*

* \[ \] **Physical Memory Manager (PMM):** Implement a Bitmap-based allocator in C++ to manage 4KB pages.  
* \[ \] **Virtual Memory Manager (VMM):** Enable Paging and MMU, mapping the kernel into the Higher Half.  
* \[ \] **Interrupt Handling:** Set up the GICv3 (ARM) and APIC (x86) to manage hardware signals.

## **🛡️ Phase 3: The Security Shield (Target: Month 7+)**

*Rust integration and preemptive multitasking.*

* \[ \] **Rust FFI:** Successfully link Rust static libraries (.a) into the C++ Kernel core.  
* \[ \] **Safe Drivers:** Rewrite critical drivers (like UART/Timers) in Rust to enforce memory safety.  
* \[ \] **O(1) Scheduler:** Implement a priority-based preemptive scheduler in C++.

## **🌌 Future Horizons**

*User-space and ecosystem development.*

* \[ \] **Userspace Entry:** Execute the first user-mode program at Ring 3 / EL0.  
* \[ \] **System Calls:** Define the syscall interface for cross-language communication.  
* \[ \] **Filesystem:** Support FAT32 or Ext2 read/write operations.