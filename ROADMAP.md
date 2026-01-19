<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:word' xmlns='http://www.w3.org/TR/REC-html40'>
            <head><meta charset='utf-8'><title>Export HTML to Word Document with JavaScript</title>
            <style>
                body { font-family: 'Times New Roman', serif; font-size: 12pt; }
                h1 { font-size: 24pt; font-weight: bold; color: #1a202c; }
                h2 { font-size: 18pt; font-weight: bold; color: #2d3748; border-bottom: 1px solid #ccc; padding-bottom: 5px; margin-top: 20px; }
                h3 { font-size: 14pt; font-weight: bold; color: #4a5568; }
                code { font-family: 'Courier New', monospace; background: #eee; padding: 2px; }
                pre { background: #f7fafc; padding: 10px; border: 1px solid #e2e8f0; font-family: 'Courier New', monospace; }
                table { border-collapse: collapse; width: 100%; margin: 10px 0; }
                th, td { border: 1px solid #cbd5e0; padding: 8px; text-align: left; }
                th { background-color: #edf2f7; font-weight: bold; }
                blockquote { border-left: 4px solid #4299e1; padding-left: 10px; color: #718096; margin-left: 0; }
            </style>
            </head><body><h1>Vylix OS Development Timeline</h1>
<h2>Phase 0: Inception (Current)</h2>
<ul>
<li><input checked="" disabled="" type="checkbox"> Define Architecture: C++ Core / Rust Security / ASM Foundation.</li>
<li><input disabled="" type="checkbox"> Setup Cross-Compilation Toolchain (GCC/Clang + Rustc).</li>
<li><input disabled="" type="checkbox"> Configure Build System (CMake + Cargo).</li>
</ul>
<h2>Phase 1: The Spark (Target: Month 1-3)</h2>
<ul>
<li><input disabled="" type="checkbox"> <strong>Assembly:</strong> Write <code>boot.s</code> to setup stack pointer on ARM64.</li>
<li><input disabled="" type="checkbox"> <strong>C++ Entry:</strong> Jump to <code>kmain()</code> in C++.</li>
<li><input disabled="" type="checkbox"> <strong>Output:</strong> Print "Hello Vylix" via UART (PL011) on QEMU.</li>
</ul>
<h2>Phase 2: The Core Manager (Target: Month 4-6)</h2>
<ul>
<li><input disabled="" type="checkbox"> <strong>Memory:</strong> Implement PMM Bitmap in C++.</li>
<li><input disabled="" type="checkbox"> <strong>Paging:</strong> Map kernel into higher half memory.</li>
<li><input disabled="" type="checkbox"> <strong>Interrupts:</strong> Handle GICv3 interrupts in Assembly/C++.</li>
</ul>
<h2>Phase 3: The Security Shield (Target: Month 7+)</h2>
<ul>
<li><input disabled="" type="checkbox"> <strong>Rust Integration:</strong> Link Rust static libraries into C++ Kernel.</li>
<li><input disabled="" type="checkbox"> <strong>First Driver:</strong> Write a safe UART driver in Rust.</li>
<li><input disabled="" type="checkbox"> <strong>Scheduler:</strong> Implement O(1) Scheduler in C++.</li>
</ul>
</body></html>