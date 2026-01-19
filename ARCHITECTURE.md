<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:word' xmlns='http://www.w3.org/TR/REC-html40'>
            <head><meta charset='utf-8'><title>ARCHITECTURE.md</title>
            <style>
                body { font-family: 'Times New Roman', serif; font-size: 12pt; }
                h1 { font-size: 24pt; font-weight: bold; margin-bottom: 20px; }
                h2 { font-size: 18pt; font-weight: bold; margin-top: 20px; border-bottom: 1px solid #ccc; }
                code { font-family: 'Courier New', monospace; background: #f0f0f0; padding: 2px 4px; }
                pre { background: #f5f5f5; padding: 10px; border: 1px solid #ddd; }
                table { width: 100%; border-collapse: collapse; margin: 15px 0; }
                th, td { border: 1px solid #bbb; padding: 8px; text-align: left; }
                th { background-color: #eee; }
            </style>
            </head><body><h1>Vylix System Architecture</h1>
<h2>1. The Low-Level Layer (Assembly)</h2>
<p>Located in <code>arch/</code>.</p>
<ul>
<li><strong>Boot:</strong> Responsible for transitioning the CPU from Firmware (EL3/UEFI) to Kernel (EL1/Ring 0).</li>
<li><strong>Traps:</strong> Handling hardware exceptions and interrupts (IRQ/FIQ).</li>
<li><strong>Context Switch:</strong> Saving/Restoring generic registers (<code>x0</code>-<code>x30</code> or <code>rax</code>-<code>r15</code>) during task switching.</li>
</ul>
<h2>2. The Kernel Core (C++23)</h2>
<p>Located in <code>kernel/core/</code>. This is the heart of Vylix, optimized for speed.</p>
<ul>
<li><strong>Scheduler:</strong> Manages thread states (Ready, Running, Blocked).</li>
<li><strong>PMM (Physical Memory Manager):</strong> Uses a Bitmap allocator to manage 4KB physical pages efficiently.</li>
<li><strong>VMM (Virtual Memory Manager):</strong> Manages Page Tables (TTBR0/CR3).</li>
<li><strong>IPC:</strong> Fast path message passing mechanism.</li>
</ul>
<h2>3. The Security Layer (Rust)</h2>
<p>Located in <code>kernel/security/</code> and <code>drivers/</code>.</p>
<ul>
<li><strong>Capability Server:</strong> Written in Rust to validate access rights.</li>
<li><strong>Device Drivers:</strong><ul>
<li>Network (Wi-Fi/5G)</li>
<li>Storage (NVMe/UFS)</li>
<li>Input (Touch/Keyboard)</li>
<li><em>Why Rust?</em> These components process untrusted data from the outside world. Rust guarantees they are memory-safe.</li>
</ul>
</li>
</ul>
<h2>4. Memory Layout Strategy</h2>
<ul>
<li><code>0x0000_0000</code> - <code>0x3FFF_FFFF</code>: MMIO (Peripherals)</li>
<li><code>0x4000_0000</code> - <code>0x4800_0000</code>: Kernel Image (Code + Data)</li>
<li><code>0x4800_0000</code> - <code>0x........</code>: Dynamic Heap (Managed by C++ PMM)</li>
</ul>
</body></html>