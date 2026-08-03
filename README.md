# ethernet-rx-gateway-asic
# Ethernet RX Gateway ASIC
![SystemVerilog](https://img.shields.io/badge/Language-SystemVerilog-blue)
![OpenLane](https://img.shields.io/badge/OpenLane-2.0-success)
![Sky130](https://img.shields.io/badge/PDK-Sky130-orange)
![ASIC](https://img.shields.io/badge/Design-ASIC-red)
![License](https://img.shields.io/badge/License-MIT-green)

## Overview

This project implements an **Ethernet RX Gateway Core ASIC** using **SystemVerilog** and the **OpenLane 2** RTL-to-GDSII flow with the **Sky130** Process Design Kit (PDK).

The design receives Ethernet frames through an RMII interface, buffers incoming packets, parses Ethernet frames, and forwards valid data to the gateway logic. The complete ASIC implementation includes RTL design, synthesis, floorplanning, placement, clock tree synthesis (CTS), routing, timing analysis, and GDSII generation.

---

## Features

- RMII Ethernet Receiver
- Ethernet Frame Parser
- Packet Buffer
- Synchronous FIFO
- Gateway Processing Logic
- RTL written in SystemVerilog
- ASIC implementation using OpenLane 2
- Sky130 open-source PDK

---

## 📊 Implementation Summary

| Parameter | Value |
|-----------|-------|
| RTL Language | SystemVerilog |
| Technology | Sky130 HD |
| Physical Design Flow | OpenLane 2 |
| Top Module | eth_rx_gateway_core |
| Standard Cells | 1072 |
| Cell Area | 10364.9 µm² |
| Total Power | 1.003 mW |
| Setup Violations | 0 |
| Hold Violations | 0 |
| GDS Generated | ✅ |

## Project Structure

```text
ethernet-rx-gateway-asic
│
├── rtl/
├── verification/
├── simulations/
├── openlane/
├── results/
├── reports/
├── docs/
└── scripts/
```

---

## RTL Modules

| Module | Description |
|---------|-------------|
| eth_rx_gateway_core | Top-level module |
| rmii_rx | RMII receiver |
| eth_rx_path | Receive datapath |
| eth_frame_parser | Ethernet frame parser |
| eth_packet_buffer | Packet buffer |
| sync_fifo | Synchronous FIFO |

---

## ASIC Design Flow

1. RTL Design
2. Functional Verification
3. Logic Synthesis
4. Floorplanning
5. Placement
6. Clock Tree Synthesis
7. Routing
8. Timing Analysis
9. Physical Verification
10. GDSII Generation

---

## Implementation Results

| Metric | Result |
|---------|--------|
| Standard Cells | 1072 |
| Cell Area | 10364.9 µm² |
| Total Power | ~1.003 mW |
| Setup Violations | 0 |
| Hold Violations | 0 |

---

## Tools Used

- SystemVerilog
- OpenLane 2
- OpenROAD
- Yosys
- Magic
- KLayout
- Netgen
- Sky130 PDK

---

## Future Work

- Add complete verification testbench
- Support additional Ethernet frame types
- Improve buffering architecture
- Add DMA interface
- Extend to Gigabit Ethernet

---

# 📚 Documentation

Detailed project documentation is available below:

| Document | Description |
|----------|-------------|
| [System Architecture](docs/architecture.md) | Complete system architecture and data flow |
| [RTL Design](docs/rtl_design.md) | RTL hierarchy and module descriptions |
| [Verification](docs/verification.md) | Functional verification methodology |
| [OpenLane Flow](docs/openlane_flow.md) | RTL-to-GDSII implementation flow |
| [Results](docs/results.md) | ASIC implementation metrics |
| [Future Work](docs/future_work.md) | Planned enhancements |

---
## Author

**Hemanth N**
