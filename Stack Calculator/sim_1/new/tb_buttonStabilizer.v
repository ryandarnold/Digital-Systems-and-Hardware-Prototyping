`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 10/16/2022 04:50:00 PM
// Module Name: tb_buttonStabilizer
//////////////////////////////////////////////////////////////////////////////////


module tb_buttonStabilizer();

reg CLK = 0;
reg ButtonUp_Unfiltered = 0;
reg ButtonDown_Unfiltered = 0;
reg ButtonLeft_Unfiltered = 0;
reg ButtonRight_Unfiltered = 0;

wire StabilizedUp;
wire StabilizedDown;
wire StabilizedLeft;
wire StabilizedRight;

wire PerfectUp; 
wire PerfectDown;
wire PerfectLeft;
wire PerfectRight; 

always #5 CLK = ~CLK; // 100MHz

buttonStabilizer uut (CLK,ButtonUp_Unfiltered,ButtonDown_Unfiltered,ButtonLeft_Unfiltered,ButtonRight_Unfiltered,StabilizedUp,StabilizedDown,StabilizedLeft,StabilizedRight,
PerfectUp, PerfectDown, PerfectLeft, PerfectRight );

initial begin
ButtonUp_Unfiltered = 0;
ButtonDown_Unfiltered = 0;
ButtonLeft_Unfiltered = 0;
ButtonRight_Unfiltered = 0;


#50000
ButtonUp_Unfiltered = 1;
ButtonDown_Unfiltered = 1;
ButtonLeft_Unfiltered = 1;
ButtonRight_Unfiltered = 1;

#1000000000
ButtonUp_Unfiltered = 0; 
ButtonDown_Unfiltered = 0;
ButtonLeft_Unfiltered = 0;
ButtonRight_Unfiltered = 0;

#250000000
ButtonUp_Unfiltered = 1; 
ButtonDown_Unfiltered = 1;
ButtonLeft_Unfiltered = 1;
ButtonRight_Unfiltered = 1;


end


endmodule
