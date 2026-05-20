`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/24/2022 12:20:41 PM
// Module Name: tb_Top
//////////////////////////////////////////////////////////////////////////////////


module tb_Top();

reg CLK = 0;
reg RESET = 0;
reg START = 0;
reg [1:0] MODE = 0;

wire SI; 
wire mainTOPAnode0; 
wire mainTOPAnode1;
wire mainTOPAnode2;
wire mainTOPAnode3; 
wire [6:0] mainTOPSevenSeg;

Top uut (CLK, RESET, START, MODE, SI, mainTOPAnode0, mainTOPAnode1,mainTOPAnode2,mainTOPAnode3,mainTOPSevenSeg);

always #5 CLK = ~CLK; // 100MHz

initial begin
//inputs here

RESET = 0; 
START = 1;
MODE = 2;


end

endmodule
