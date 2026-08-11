
# MIPS CPU

A MIPS processor implemented in Verilog and synthesized on an FPGA. This project supports a subset of the MIPS instruction set architecture (ISA), integrates board-level I/O, and extends the processor with additional ARM-like instructions.

## Features

- Instruction memory initialization using Verilog Text-IO
- FPGA board integration with switches and seven-segment displays
- Custom ISA extensions:
  - JAL (Jump and Link)
      → JAL puts the return address in register $31 and then goes to the input's address
    <img src="https://github.com/user-attachments/assets/81620064-d3e2-4d5d-9d45-9c6caf2df04d" width="600">

  operation:
  $31 = PC + 1;
  
  New_PC = Target;
  
  -----------------------------------------------------------------------------------------------------------------
  - LUI (Load Upper Immediate)
      → The immediate value is shifted left 16 bits and stored in the register. The lower 16 bits are zeroes.

  <img src="https://github.com/user-attachments/assets/fe0c4748-4273-4493-8ef5-3482064da2f3" width="600">

  operation:

  $rt = imm << 16;

  -----------------------------------------------------------------------------------------------------------------
  - ADD8 (Byte-wise Addition)
      → Perform byte-wise addition

<img src="https://github.com/user-attachments/assets/7831cc9b-e2ac-4d9d-8ae3-f942ab5c7d4c" width="600">

  operation: 
  
  rd[31:24] = rs[31:24]+rt[31:24]
  
  rd[23:16] = rs[23:16]+rt[23:16]
  
  rd[15:8] = rs[15:8]+ rt[15:8] rd[7:0]
  
  = rs[7:0]+ rt[7:0]
    
  - RBIT (Bit Reversal)
  - REV (Byte Reversal)
  - SADD (Saturating Addition)
  - SSUB (Saturating Subtraction)
- MIPS assembly program execution and machine code loading

## Source Files

| File | Description |
|-------|-------------|
| `Complete_MIPS.v` | Integrates overall MIPS processor and memory segments. |
| `MIPS.v` | Implements the core MIPS processor datapath and control logic. |
| `Memory.v` | Stores and retrieves instruction/data memory contents. |
| `REG.v` | Manages processor register reads and writes. |
| `tb_*.v` | Testbench files used to simulate and verify processor functionality. |

