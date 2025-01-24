# Smart Parking System

## Description
This project implements a Smart Parking System using Verilog and FPGA technology. It manages a parking lot with 4 spaces, featuring real-time updates, entry/exit management, and visual indicators.
This project was a part of the Logic Circuit Design course at Amirkabir University of Technology (AUT).

## Features
- 4-slot parking lot management with status indicators.
- Entry/Exit sensors (simulated with buttons) for vehicle detection.
- 7-segment display showing:
  - Number of available slots.
  - Recommended parking slot (prioritizes lowest-numbered slot).
- A "FULL" signal when the lot is fully occupied. (If someone tries to enter while the lot is full, the "FULL" LED will flash 3 times)
- A "DOOR OPEN" LED that flashes 20 times whenever a vehicle enters or exits the parking lot.
- FSM implemented in both behavioral and gate-level designs.
- Fully verified with simulation testbenches.
  
## Tools Used
- **Hardware Description Language:** Verilog
- **Simulation Tools:** Icarus Verilog, GTKWave
- **Target Hardware:** FPGA

## Simulation Result
!(docs/simulation_result.png)
