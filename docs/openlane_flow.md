# OpenLane RTL-to-GDSII Flow

## Overview

The Ethernet RX Gateway ASIC was implemented using the OpenLane 2 automated ASIC flow targeting the Sky130 HD Process Design Kit (PDK).

## Design Flow

```text
RTL (SystemVerilog)
        │
        ▼
Logic Synthesis (Yosys)
        │
        ▼
Floorplanning
        │
        ▼
Cell Placement
        │
        ▼
Clock Tree Synthesis (CTS)
        │
        ▼
Global Routing
        │
        ▼
Detailed Routing
        │
        ▼
Static Timing Analysis
        │
        ▼
DRC/LVS Checks
        │
        ▼
GDSII Generation
```

## Tools Used

- OpenLane 2
- OpenROAD
- Yosys
- Magic
- KLayout
- Netgen

## Technology

- Sky130 HD Standard Cell Library

## Implementation Outcome

The design successfully completed the RTL-to-GDSII flow and generated the final layout without setup or hold timing violations.
