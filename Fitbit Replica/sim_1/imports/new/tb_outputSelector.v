`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/23/2022 03:27:58 PM
// Module Name: tb_outputSelector
//////////////////////////////////////////////////////////////////////////////////


module tb_outputSelector();

reg CLK = 0;
reg RESET = 0;
reg [13:0] totalSteps = 0;


wire mainAnode0;
wire mainAnode1;
wire mainAnode2;
wire mainAnode3;    
wire [6:0] mainSevenSeg; 

outputSelector uut (CLK, RESET, totalSteps,distanceCovered, thirtyTwoStepsPerSecond, sixtyFourStepsPerSecond, mainAnode0, mainAnode1, mainAnode2, mainAnode3, mainSevenSeg);

always #5 CLK = ~CLK; // 100MHz

initial begin
//inputs here

RESET = 0;
#10 
totalSteps = 1234;

end


endmodule
