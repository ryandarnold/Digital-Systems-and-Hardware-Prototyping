`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/18/2022 03:39:57 PM
// Module Name: tb_totalStepCount
//////////////////////////////////////////////////////////////////////////////////


module tb_totalStepCount();

reg PULSE = 0;
reg RESET = 0;

wire [13:0] sevenSegOut; 
wire [13:0] totalStepsOut; 
wire SI; 


totalStepCount uut (PULSE, RESET, sevenSegOut, totalStepsOut, SI);

initial begin

//put inputs here
RESET = 0;
PULSE = 0;


#10 // 1st PULSE
PULSE = 1;
#10
PULSE = 0;

#10 // 2nd PULSE
PULSE = 1;
#10 
PULSE = 0;

#10 //3rd PULSE
PULSE = 1;
#10 
PULSE = 0;


end 


endmodule
