# Systolic Array Matrix Multiplier

A 3×3 matrix multiplication system implemented in Verilog using a systolic array architecture and multiply-accumulate (MAC) units. This project demonstrates hardware acceleration for matrix operations on an FPGA.

## Features

- 3×3 matrix multiplication
- Systolic array architecture
- Multiply-and-accumulate (MAC) units

## Source Files

| File | Description |
|-------|-------------|
| `test_Systolic_Matrix.v` | Coordinates data through a 3×3 systolic array to perform matrix multiplication and generate the final output matrix. |
| `MAC.v` | Performs multiply-and-accumulate operations for matrix computation. |
| `SquareModule.v` | A single processing unit in the systolic array that does MAC operations and sends matrix data to next modules. |
| `tb_*.v` | Testbench files used to simulate and verify module functionality. |

