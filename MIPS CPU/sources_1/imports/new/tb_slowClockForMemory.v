`timescale 1ns / 1ps

module tb_slowClockForMemory();

reg CLK = 0;

wire SlowCLK; 
always #5 CLK = ~CLK; // 100MHz

SlowClockForMemory SC1 (CLK, SlowCLK);

endmodule
