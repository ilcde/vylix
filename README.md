# **🌌 Vylix OS**

**A Modern Hybrid Microkernel built with C++23 and Rust.**

Vylix OS is an experimental operating system designed to explore the synergy between C++23's performance and Rust's memory safety in a cross-platform environment (AArch64 & x86\_64).

## **✨ Key Features**

* **Hybrid Core:** Leveraging C++ for hardware abstraction and Rust for safety-critical components.  
* **Multi-Architecture:** First-class support for both Mobile (ARM64) and Desktop (x86\_64).  
* **Modern Standards:** Built using C++23 and Rust no\_std.  
* **Bare-metal:** Zero dependencies on existing operating systems.

## **🛠️ Current Development Status**

* \[x\] Multi-arch Bootloader (Multiboot2 for x86, Virt for ARM)  
* \[x\] Cross-language FFI (C++ calling Rust)  
* \[x\] Basic Serial I/O (UART & I/O Ports)  
* \[ \] Physical Memory Manager (PMM) \- **Active Development**  
* \[ \] Virtual Memory Manager (VMM)  
* \[ \] Preemptive Scheduler

## **🚀 Quick Start**

\# Clone the project  
git clone \[https://github.com/ilcde/vylix.git\](https://github.com/ilcde/vylix.git)  
cd vylix

\# Run for ARM64 (Mobile)  
make ARCH=aarch64 run

\# Run for x86\_64 (Desktop)  
make ARCH=x86\_64 run

## **🤝 Community**

We welcome all kinds of contributions\! Whether you are an expert in Assembly, a C++ enthusiast, or a Rustacean, there's a place for you in Vylix OS.

Please read our [CONTRIBUTING.md](https://www.google.com/search?q=CONTRIBUTING.md) to get started.

## **📄 License**

This project is licensed under the MIT License \- see the [LICENSE](https://www.google.com/search?q=LICENSE) file for details.