`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/16/2022 03:19:49 PM
// Module Name: tb_Pulse_Generator
//////////////////////////////////////////////////////////////////////////////////


module tb_Pulse_Generator();


reg CLK = 0;
reg [1:0] MODE = 0;
reg START = 0;
reg RESET = 0;

wire PULSE; 


Pulse_Generator uut (CLK, MODE, START, RESET, PULSE);

always #5 CLK = ~CLK; // 100MHz

initial begin
//start typing inputs here

MODE = 2'b11;
RESET = 0;
START = 1; 

end


endmodule
