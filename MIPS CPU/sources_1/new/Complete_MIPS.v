`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 11/17/2022 03:44:25 PM
// Module Name: Complete_MIPS
//////////////////////////////////////////////////////////////////////////////////


module Complete_MIPS(CLK, RST, Address_Out, Data_Out);
  input CLK;
  input RST;
  output [6:0] Address_Out;
  output [31:0] Data_Out;
  wire CS, WE;
  wire [6:0] ADDR;
  wire [31:0] Mem_Bus;

  MIPS CPU(CLK, RST, CS, WE, ADDR, Mem_Bus);
  Memory MEM(CS, WE, CLK, ADDR, Mem_Bus);
    
endmodule
