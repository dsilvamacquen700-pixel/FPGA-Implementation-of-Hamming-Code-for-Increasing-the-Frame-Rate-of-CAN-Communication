# FPGA Implementation of Hamming Code for Increasing the Frame Rate of CAN Communication

> A hardware-based error correction system using Hamming Code, implemented on FPGA via Verilog HDL, to improve the reliability and frame rate of CAN (Controller Area Network) communication over noisy channels.

---

## Team Members

| Role | Name | ID |
|---|---|---|
| Team Leader | Macquen Joysten Dsilva | 4S024EC062 |
| Member | Melisha Iyana Lobo | 4S024EC069 |
| Member | Marwin Carvallo | 4S024EC067 |
| Member | Joel Pinto | 4S024EC054 |

---

## Table of Contents

- [Overview](#overview)
- [Problem Statement](#problem-statement)
- [Objectives](#objectives)
- [Literature Review](#literature-review)
- [Proposed System Design](#proposed-system-design)
- [Leaf Cell Designs](#leaf-cell-designs)
- [Formula](#formula-used)
- [Simulation Results](#simulation-results)
- [Tools Used](#tools-used)
- [References](#references)

---

## Overview

Digital communication systems — including satellite networks, wireless systems, and CAN buses — are susceptible to bit errors introduced by channel noise. This project designs an **FPGA-based Hamming Syndrome Decoder** that detects and corrects single-bit errors in real time, improving CAN communication reliability and frame rate without the overhead of software-based correction.

---

## Problem Statement

Reliable digital communication is critical in applications such as:
- Disaster management systems
- Satellite communication
- Rural connectivity networks

Noisy communication channels introduce transmission errors that degrade data accuracy. Existing **software-based error correction** methods increase computational complexity and processing delay. This project addresses the need for a fast, hardware-based solution.

---

## Objectives

- Understand the fundamentals of Error Control Coding and Hamming Code
- Design a Hamming Syndrome Decoder for detecting and correcting single-bit errors
- Implement the decoder on FPGA using **Verilog HDL**
- Generate syndrome bits for accurate error identification
- Simulate and verify the design using **AMD Vivado** tools
- Improve reliable digital communication over noisy CAN channels

---

## Literature Review

### Paper 1 — FPGA Implementation of Hamming Code for CAN Communication
- Uses Hamming Code ECC for CAN communication
- Improves frame rate using FPGA (Virtex-5); achieves ~1050 fps throughput using 116 LUTs
- **Limitation:** Single-bit error correction only; limited to CAN applications

### Paper 2 — Implementation of Improved Hamming Code for Reliable CAN Protocol on FPGA
- Presents an improved Hamming Encoder/Decoder with syndrome-based correction
- Reduces area (11× lower than CRC) and power consumption on Artix-7 FPGA
- **Limitation:** Handles single-bit errors; less effective in high-noise environments

### Paper 3 — CAN Bus Communication System Design and Error Handling
- Focuses on reliability in radiation environments using Hamming coding
- **Limitation:** No detailed FPGA performance or hardware utilization analysis

### Comparison Table

| Feature | Paper 1 | Paper 2 | Paper 3 |
|---|---|---|---|
| Main Focus | CAN Frame Rate | Improved CAN Reliability | Radiation Hardening |
| ECC Technique | Hamming Code | Improved Hamming Code | Hamming Code |
| FPGA Platform | Virtex-5 | Artix-7 | VHDL-based |
| Throughput | ~1050 fps | Improved frame rate | Not specified |
| Resource Usage | 116 LUTs | 11× lower area than CRC | Not specified |
| Main Limitation | Single-bit correction | Medium scalability | No throughput analysis |

### Research Gap

- Existing designs focus on either speed **or** hardware efficiency — not both simultaneously
- Many works lack proper performance and power analysis
- A simple, fast, and efficient FPGA-based Hamming Syndrome Decoder is needed for reliable real-time communication over noisy channels

---

## Proposed System Design

### Design Justification

| Design Choice | Rationale |
|---|---|
| **Hamming Code** | Simple, effective single-bit error correction for CAN protocol |
| **Syndrome-Based Detection** | XOR-based syndrome generation for fast error location |
| **Low Hardware Complexity** | Minimal FPGA resource usage for real-time efficiency |
| **FPGA Implementation** | Enables parallel processing and deterministic timing |
| **Verilog HDL** | Clean RTL design, compatible with AMD Vivado synthesis tools |

### System Architecture

The system integrates an FPGA-based CAN communication controller with a Hamming error correction pipeline. The data flow is:

```
CAN Input Frame
      │
      ▼
 Hamming Encoder (Parity Generation)
      │
      ▼
 Noisy Channel (Bit Errors Introduced)
      │
      ▼
 Syndrome Calculator (Error Detection)
      │
      ▼
 Error Corrector (Single-Bit Fix)
      │
      ▼
 Corrected CAN Output Frame
```

---

## Leaf Cell Designs

Each fundamental hardware block is independently designed, optimized, and simulated.

### 1. Register
- **Function:** Stores binary data temporarily; synchronizes I/O with the system clock
- **RTL:** D flip-flops using `always @(posedge clk)` with synchronous reset
- **Optimization:** Clock gating, parameterized width, minimal fan-out

### 2. MUX (Multiplexer)
- **Function:** Selects one input from multiple sources based on select lines
- **RTL:** `assign` statement or `case` block (pure combinational logic)
- **Optimization:** Logic minimization (K-map style), shared data paths

### 3. XOR Logic
- **Function:** Exclusive-OR operation for parity generation and syndrome calculation
- **RTL:** `^` operator with multi-input XOR tree structure
- **Optimization:** Balanced XOR tree to reduce propagation delay on the critical path

### 4. Counter
- **Function:** Counts clock cycles for sequencing, framing, and bit tracking
- **RTL:** `always @(posedge clk)` with increment logic; resettable and parameterized
- **Optimization:** Synchronous reset, enable/disable control signal, clock gating

### 5. Shift Register
- **Function:** Converts parallel data to serial (and vice versa) for CAN transmission
- **RTL:** Flip-flop chain using `{}` concatenation operator
- **Optimization:** Reduces I/O pin usage; pipeline-friendly; supports high-speed shifting

### 6. FSM (Finite State Machine)
- **Function:** Controls operation sequencing in the CAN controller and encoder/decoder flow
- **RTL:** Two-process model — sequential state register + combinational next-state logic
- **Optimization:** One-hot or binary state encoding; registered outputs to reduce glitching

### 7. Parity Generator
- **Function:** Generates parity bits for Hamming code error detection
- **RTL:** XOR network of selected input bits (combinational block)
- **Optimization:** Structured XOR grouping, tree-based reduction to minimize logic depth

### 8. Syndrome Calculator
- **Function:** Detects error location in a received Hamming codeword
- **RTL:** XOR-based parity check matrix producing a syndrome vector
- **Optimization:** Parallel XOR computation, optimized H-matrix mapping, critical path reduction

---
## Formula used
R(x)=H^(−1)(C(T(H(D))))
  D= Input Data 
  H(D)= Hamming Encoding 
  T= CAN Transmission 
  C= CAN Reception and CRC checking 
  H^(-1)= Hamming Decoding and Error Correction 
  R(x)= Corrected Received Data


## Simulation Results

All leaf cells were simulated in **Xilinx Vivado 2018.2**. The following simulation results are documented in the project report:

| Cell | Simulation Status |
|---|---|
| Register | ✅ Verified |
| MUX | ✅ Verified |
| XOR Gate | ✅ Verified |
| Counter | ✅ Verified |
| Shift Register | ✅ Verified |
| Parity Generator | ✅ Verified |
| Syndrome Calculator | ✅ Verified |
| FSM | ✅ Verified |

---

## Tools Used

| Tool | Purpose |
|---|---|
| **Xilinx Vivado 2018.2** | RTL simulation, synthesis, and FPGA implementation |
| **Verilog HDL** | Hardware description language for all modules |
| **draw.io** | Block diagram and architecture diagram creation |
| **IEEE Xplore** | Reference paper sourcing |

---

## References

1. R. O. S. Juan, M. W. Jeong, H. W. Cha and H. S. Kim, *"FPGA implementation of hamming code for increasing the frame rate of CAN communication,"* 2016 IEEE Asia Pacific Conference on Circuits and Systems (APCCAS), Jeju, Korea, 2016, pp. 684–687.
   [https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=7804065](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=7804065)

2. Nagarathna, H., Ramesh Kumar, K., *"Implementation of improved hamming code for reliable CAN protocol on FPGA,"* Discov Electron 3, 57 (2026).
   [https://link.springer.com/article/10.1007/s44291-026-00206-x](https://link.springer.com/article/10.1007/s44291-026-00206-x)

3. Y. He and J. Li, *"CAN Bus Communication System Design and Error Handling,"* Proceedings of the 33rd Chinese Control Conference, Nanjing, China, 2014, pp. 4142–4147.
   [https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=6895632](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=6895632)

---

*Project Type: PBL (Project-Based Learning) Secondary Research Report*
