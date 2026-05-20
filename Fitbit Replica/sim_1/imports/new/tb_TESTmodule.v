`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/24/2022 06:01:57 PM
// Module Name: tb_TESTmodule  
//////////////////////////////////////////////////////////////////////////////////


module tb_TESTmodule();

reg CLK = 0;
reg [1:0] MODE = 0;
reg START = 0;
reg RESET = 0;

wire [13:0] highatime;
TESTmodule uut (CLK, MODE, START, RESET,highatime );  

always #5 CLK = ~CLK; // 100MHz

initial begin
//inputs here

RESET = 0;
START = 1;
MODE = 1;

end
endmodule
