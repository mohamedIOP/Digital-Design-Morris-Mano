# 📘 Digital Design — Morris Mano (5th Edition)
> Verilog HDL solutions for problems from *Digital Design* by M. Morris Mano & Michael D. Ciletti, 5th Edition.

---

## 📂 Repository Structure

```
Digital-Design-Morris-Mano/
│
├── CH3/   — Combinational Logic
├── CH4/   — Combinational Logic (MSI Components & Decoders/Encoders)
├── CH5/   — Synchronous Sequential Logic
├── CH6/   — Registers, Counters & Memory Units
├── CH8/   — Design at the Register Transfer Level
│
├── Digital Design Summary.pdf                    ← Printable summary
└── Digital_Design_Summary_Digital-Version.pdf    ← Digital/navigable summary
```

---

## 📖 About

This repository contains **Verilog HDL implementations** of the end-of-chapter problems from one of the most widely used digital design textbooks. Each chapter folder holds `.v` source files corresponding to specific exercises.

The solutions were written and organized by **SAWY** as a practical companion to the book — useful for students who want to see how theoretical circuit designs translate into actual hardware description language code.

---

## 🗂️ Chapters Covered

| Chapter | Topic |
|---------|-------|
| **CH3** | Combinational Logic — Boolean algebra, logic gates, simplification |
| **CH4** | Combinational Logic — Adders, subtractors, multiplexers, decoders |
| **CH5** | Synchronous Sequential Logic — Flip-flops, state machines |
| **CH6** | Registers, counters, shift registers, memory unit design |
| **CH8** | Register Transfer Level (RTL) design, datapaths & control units |

---

## 🛠️ Tools & Requirements

To simulate or synthesize the Verilog files in this repo, you can use any of the following tools:

- **[ModelSim / QuestaSim](https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/model-sim.html)** — Industry-standard Verilog/VHDL simulation
- **[Icarus Verilog (iverilog)](http://iverilog.icarus.com/)** — Free, open-source Verilog simulator
- **[GTKWave](http://gtkwave.sourceforge.net/)** — Open-source waveform viewer (pairs with iverilog)
- **[Quartus Prime](https://www.intel.com/content/www/us/en/products/details/fpga/development-tools/quartus-prime.html)** — Intel FPGA synthesis & simulation

### Quick simulation with Icarus Verilog

```bash
# Compile
iverilog -o output filename.v testbench.v

# Run
vvp output

# View waveforms (if $dumpfile is used)
gtkwave dump.vcd
```

---

## 📄 Summary PDFs

Two summary documents are included for quick reference:

- **`Digital Design Summary.pdf`** — Best for printing
- **`Digital_Design_Summary_Digital-Version.pdf`** — Best for on-screen reading, with navigation-friendly formatting

---

## 🤝 Contributing

Found a bug or want to add missing chapters? Feel free to:

1. Fork the repository
2. Create a new branch (`git checkout -b fix/ch5-problem3`)
3. Commit your changes
4. Open a Pull Request

---

## 👤 Author

- **[mohamedIOP](https://github.com/mohamedIOP)** (SAWY) — Solutions author & repository maintainer
