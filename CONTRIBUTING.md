# **🤝 Contributing to Vylix OS**

First off, thank you for considering contributing to Vylix OS\! It's people like you who make Vylix OS such a modern and exciting hybrid kernel.

## **🏗️ Technical Stack**

* **Languages:** C++23, Rust (no\_std), Assembly (AArch64 & x86\_64).  
* **Build System:** GNU Make.  
* **Emulation:** QEMU.

## **🛠️ How to Get Started**

1. **Fork** the repository on GitHub.  
2. **Clone** your fork locally:  
   git clone https://github.com/ilcde/vylix.git

3. **Install Dependencies** (on Kali Linux/Ubuntu):  
   sudo apt install g++-aarch64-linux-gnu g++-x86\_64-linux-gnu qemu-system-arm qemu-system-x86 make  
   rustup target add aarch64-unknown-none-softfloat x86\_64-unknown-none  
   rustup component add rust-src

4. **Build and Run**:  
\# Run for ARM64 (Mobile)  
make ARCH=aarch64 run

\# Run for x86\_64 (Desktop)  
make ARCH=x86\_64 run

## **📋 Contribution Rules**

* **Branching:** Create a new branch for each feature (feature/your-feature-name).  
* **Coding Style:** \- Use Doxygen style comments for C++.  
  * Use rustdoc for Rust components.  
  * Follow the existing directory structure (arch/, kernel/, rust\_core/).  
* **Hybrid Nature:** Ensure that any shared logic between C++ and Rust uses extern "C" to maintain compatibility.

## **📬 Submitting Changes**

* Commit your changes with clear, descriptive messages.  
* Push to your fork and submit a **Pull Request (PR)**.  
* Describe what your PR does and which issue it fixes.

## **🗺️ Roadmap**

Check our [README.md](https://github.com/ilcde/vylix/blob/main/ROADMAP.md) for current goals (PMM, VMM, Scheduler).