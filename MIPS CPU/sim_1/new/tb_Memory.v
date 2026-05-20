`timescale 1ns / 1ps


module tb_Memory();

reg CS; 
reg WE;
reg CLK;
reg [6:0] ADDR;
wire [31:0] Mem_Bus;

always #5 CLK = ~CLK; // 100MHz

Memory testMEM (CS, WE, CLK, ADDR, Mem_Bus); 

initial begin
CLK = 0;
CS = 1;
WE = 0; 
ADDR = 1; // read out secondn line of .mem file

end

endmodule
