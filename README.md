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
            </head><body><h1>VYLIX MICROKERNEL</h1>
<p><a href="LICENSE"><img src="https://img.shields.io/badge/License-GPLv3-blue.svg" alt="License: GPL v3"></a>
<a href=""><img src="https://img.shields.io/badge/Kernel_Core-C%2B%2B23-blue" alt="Core"></a>
<a href=""><img src="https://img.shields.io/badge/Security_Layer-Rust-orange" alt="Security"></a>
<a href=""><img src="https://img.shields.io/badge/Platform-Mobile%20%7C%20Desktop-lightgrey" alt="Platform"></a></p>
<pre><code class="language-text">__     __   _ _        
\ \   / /  | (_)_  __  
 \ \ / /_  | | \ \/ /  
  \ V /| |_| | |&gt;  &lt;   
   \_/  \__, |_/_/\_\  
        |___/          
</code></pre>
<h2>Abstract</h2>
<p><strong>Vylix</strong> is an experimental, universal microkernel designed to bridge the gap between mobile (ARM64) and desktop (x86_64) computing.</p>
<p>It implements a <strong>Hybrid-Safe Architecture</strong>:</p>
<ol>
<li><strong>The Foundation (Ring -1):</strong> Direct hardware initialization via <strong>Assembly</strong> (AArch64/x86_64).</li>
<li><strong>The Engine (Ring 0):</strong> A low-latency kernel core written in <strong>Modern C++23</strong> for raw performance and manual resource management.</li>
<li><strong>The Shield (Ring 1/3):</strong> Critical security modules and drivers written in <strong>Rust</strong> to enforce memory safety boundaries.</li>
</ol>
<blockquote>
<p><strong>Current Status:</strong> <em>Phase 0 (Architecture Planning). This repository currently hosts design documents and build system configuration. No bootable artifacts are available yet.</em></p>
</blockquote>
<h2>The Tech Stack Strategy</h2>
<table>
<thead>
<tr>
<th align="left">Layer</th>
<th align="left">Language</th>
<th align="left">Responsibility</th>
<th align="left">Why?</th>
</tr>
</thead>
<tbody><tr>
<td align="left"><strong>Hardware</strong></td>
<td align="left"><strong>Assembly</strong></td>
<td align="left">Bootloader, Context Switch.</td>
<td align="left">Absolute control over silicon startup.</td>
</tr>
<tr>
<td align="left"><strong>Kernel Core</strong></td>
<td align="left"><strong>C++23</strong></td>
<td align="left">Scheduler, PMM/VMM, IPC.</td>
<td align="left">Zero-cost abstractions for performance.</td>
</tr>
<tr>
<td align="left"><strong>Security</strong></td>
<td align="left"><strong>Rust</strong></td>
<td align="left">Network, USB Drivers.</td>
<td align="left">Prevents memory safety bugs.</td>
</tr>
</tbody></table>
<h2>Core Principles</h2>
<h3>1. Zero-Latency Scheduling</h3>
<p>Vylix utilizes an O(1) priority-based preemptive scheduler written in C++. It guarantees UI threads receive CPU time within a fixed microsecond window, ensuring 120Hz+ fluidity.</p>
<h3>2. Verified Isolation</h3>
<p>While the core engine is C++, the "gates" to the outside world (drivers) are guarded by Rust. This ensures a buggy Wi-Fi driver cannot corrupt kernel memory.</p>
<h3>3. Universal Design</h3>
<p>Targeting <strong>ARMv8-A (Qualcomm/MediaTek)</strong> for mobile and <strong>x86_64</strong> for desktop. We aim to create a single cohesive ecosystem.</p>
<h2>Licensing</h2>
<p>Vylix is developed in Vietnam 🇻🇳 and licensed under the <strong>GNU General Public License v3.0</strong>.</p>
</body></html>