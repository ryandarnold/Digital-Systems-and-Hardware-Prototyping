`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 10/16/2022 09:25:35 PM
// Module Name: tb_Controller
//////////////////////////////////////////////////////////////////////////////////

module tb_Controller();

reg CLK =0;
reg ButtonUp_unfiltered = 0;
reg ButtonDown_unfiltered = 0;
reg ButtonLeft_unfiltered = 0;
reg ButtonRight_unfiltered =0;
reg [7:0] SWITCH = 0;

wire [6:0] sevenSeg; 
wire anode0_controller;
wire anode1_controller;
wire anode2_controller;
wire anode3_controller; 

always #5 CLK = ~CLK; // 100MHz

Controller uut (CLK,ButtonUp_unfiltered,ButtonDown_unfiltered,ButtonLeft_unfiltered,ButtonRight_unfiltered,SWITCH,sevenSeg,anode0_controller,anode1_controller,
anode2_controller,anode3_controller); 

initial begin
ButtonUp_unfiltered = 0;
ButtonDown_unfiltered = 0;
ButtonLeft_unfiltered = 0;
ButtonRight_unfiltered =0;

#50000
ButtonUp_unfiltered = 1;
ButtonDown_unfiltered = 1;
ButtonLeft_unfiltered = 1;
ButtonRight_unfiltered = 1;

#1000000000
ButtonUp_unfiltered = 0; 
ButtonDown_unfiltered = 0;
ButtonLeft_unfiltered = 0;
ButtonRight_unfiltered = 0;

#250000000
ButtonUp_unfiltered = 1; 
ButtonDown_unfiltered = 1;
ButtonLeft_unfiltered = 1;
ButtonRight_unfiltered = 1;


end
endmodule
