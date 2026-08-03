# Ethernet RX Gateway ASIC Architecture
o
## Overview

The Ethernet RX Gateway ASIC is a SystemVerilog-based ASIC that receives Ethernet frames over the RMII interface, parses incoming packets, buffers the payload, and forwards valid data through a synchronized FIFO. The design is optimized for modularity and ASIC implementation using the Sky130 PDK and OpenLane flow.

## Architecture Diagram

![System Architecture](images/architecture.png)

## Functional Blocks

### RMII Receiver (`rmii_rx.sv`)
- Receives RMII data from the PHY.
- Reconstructs Ethernet byte streams.
- Detects valid receive signals.

### Ethernet Frame Parser (`eth_frame_parser.sv`)
- Parses Ethernet frame headers.
- Identifies packet boundaries.
- Validates incoming frames.

### Packet Buffer (`eth_packet_buffer.sv`)
- Temporarily stores received packets.
- Provides stable data transfer between modules.

### Synchronization FIFO (`sync_fifo.sv`)
- Buffers packet data.
- Synchronizes transfers between processing stages.

### RX Path Controller (`eth_rx_path.sv`)
- Controls the receive data path.
- Connects the receiver, parser, and packet buffer.

### Top Module (`eth_rx_gateway_core.sv`)
- Integrates all RTL modules.
- Coordinates the complete Ethernet receive pipeline.

## Data Flow

```text
RMII PHY
    │
    ▼
RMII Receiver
    │
    ▼
Frame Parser
    │
    ▼
Packet Buffer
    │
    ▼
Sync FIFO
    │
    ▼
Gateway Output
```

## Design Features

- Modular SystemVerilog RTL
- RMII compliant receiver
- Packet buffering
- Synchronous FIFO architecture
- ASIC-ready implementation
- Sky130 compatible
