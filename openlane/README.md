---

# ASIC Implementation Results

The Ethernet RX Gateway ASIC was successfully implemented using the Sky130 PDK and OpenLane 2 RTL-to-GDSII flow.

## Physical Design Flow

- RTL Design ✅
- Functional Verification ✅
- Logic Synthesis ✅
- Floorplanning ✅
- Placement ✅
- Clock Tree Synthesis (CTS) ✅
- Global Routing ✅
- Detailed Routing ✅
- Static Timing Analysis (STA) ✅
- Design Rule Check (DRC) ✅
- Layout Versus Schematic (LVS) ✅
- GDSII Generation ✅

## Generated Deliverables

| File | Description |
|------|-------------|
| GDSII | Final chip layout |
| DEF | Physical design |
| LEF | Abstract physical model |
| Gate-Level Netlist | Synthesized netlist |
| SPEF | Extracted parasitics |
| SDF | Timing delays |
| SPICE | Extracted transistor-level netlist |
| Liberty | Timing models |

## Layout Screenshot

<p align="center">
<img src="results/screenshots/final_layout.png" width="700">
</p>

---

## Tools Used

- SystemVerilog
- Icarus Verilog
- GTKWave
- Yosys
- OpenROAD
- OpenLane 2
- Magic
- KLayout
- Netgen
- Sky130 PDK

---

## Project Status

**Status:** ✅ Complete

This project demonstrates a complete RTL-to-GDSII digital ASIC implementation flow for an Ethernet Receive Gateway using the Sky130 open-source PDK.

