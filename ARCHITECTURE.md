# **Vylix System Architecture**

This document outlines the structural layers and memory strategy of the Vylix Microkernel.

## **1\. The Low-Level Layer (Assembly)**

**Location:** arch/

This layer acts as the direct interface with the hardware, handling tasks that high-level languages cannot perform directly.

* **Boot:** Responsible for transitioning the CPU from Firmware (EL3/UEFI) to Kernel mode (EL1/Ring 0).  
* **Traps:** Manages hardware exceptions and interrupts (IRQ/FIQ).  
* **Context Switch:** Handles saving and restoring generic registers (x0-x30 for ARM64 or rax-r15 for x86\_64) during task switching.

## **2\. The Kernel Core (C++23)**

**Location:** kernel/core/

The heart of Vylix, written in Modern C++23 and optimized for raw execution speed.

* **Scheduler:** Manages thread states including Ready, Running, and Blocked.  
* **PMM (Physical Memory Manager):** Utilizes a Bitmap allocator to manage 4KB physical pages efficiently.  
* **VMM (Virtual Memory Manager):** Manages Page Tables (TTBR0/CR3) to provide isolated address spaces.  
* **IPC (Inter-Process Communication):** A fast-path message-passing mechanism for microkernel services.

## **3\. The Security Layer (Rust)**

**Location:** kernel/security/ and drivers/

Written in Rust to leverage its memory safety guarantees for the most vulnerable parts of the system.

* **Capability Server:** Validates access rights to ensure zero-trust security between processes.  
* **Device Drivers:**  
  * **Network:** Wi-Fi/5G stacks.  
  * **Storage:** NVMe and UFS drivers.  
  * **Input:** Touchscreen and Keyboard handlers.  
* **Why Rust?** These components process untrusted data from the external world. Rust's ownership model guarantees they are memory-safe, preventing common vulnerabilities like buffer overflows.

## **4\. Memory Layout Strategy**

The physical memory space is organized as follows:

* **0x0000\_0000 \- 0x3FFF\_FFFF:** MMIO (Memory Mapped I/O for Peripherals).  
* **0x4000\_0000 \- 0x4800\_0000:** Kernel Image (Contains Code and Static Data).  
* **0x4800\_0000 \- 0x........:** Dynamic Heap (Managed by the C++ Physical Memory Manager).