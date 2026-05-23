# Stack Calculator

A stack-based calculator implemented on an FPGA using Verilog and Block RAM. This project performs arithmetic operations using a stack memory structure and board switch inputs/outputs.

## Features

- Push and pop stack operations
- Addition and subtraction using stack operands
- Reset and 
- Decrement address register
- Delete and reset display address register pointer to top of stack
- Increment and decrement address pointer

## Source Files

| `Top.v` | Integrates the controller, memory, data bus, and display logic into the full calculator system. |

| `Controller.v` | Implements the stack calculator control logic and memory operations |

| `memory.v` | Stores stack values using FPGA block RAM for calculator operations. |
