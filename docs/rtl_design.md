# RTL Design

## Overview

The Ethernet RX Gateway ASIC is implemented using a modular RTL architecture in SystemVerilog. Each module performs a dedicated function in the receive pipeline, improving scalability, maintainability, and verification.

## RTL Module Hierarchy

![RTL Module Hierarchy](images/rtl_module_hierarchy.png)

## Top-Level Module

**eth_rx_gateway_core.sv**

This module integrates all RTL blocks and controls the complete Ethernet receive data path.

## RTL Modules

| Module | Function |
|---------|----------|
| `rmii_rx.sv` | Receives RMII data and reconstructs Ethernet bytes |
| `eth_frame_parser.sv` | Parses Ethernet headers and validates frames |
| `eth_packet_buffer.sv` | Buffers received Ethernet packets |
| `sync_fifo.sv` | Provides synchronized packet buffering |
| `eth_rx_path.sv` | Controls packet movement through the pipeline |
| `eth_rx_gateway_core.sv` | Top-level integration module |

## RTL Features

- Modular SystemVerilog implementation
- Parameterized FIFO
- Synchronous design
- RMII compliant interface
- Hierarchical architecture
- ASIC synthesizable RTL

## Design Advantages

- Easy to verify
- Easy to maintain
- Scalable architecture
- Reusable modules
- Suitable for ASIC implementation
