`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/23/2022 09:52:28 PM
// Module Name: tb_oneSecondCounter_pulse
//////////////////////////////////////////////////////////////////////////////////


module tb_twoSecondCounter_pulse();

reg CLK = 0;
reg RESET = 0;

wire twoSecondPulse; 

twoSecondCounter_pulse uut (CLK, RESET, twoSecondPulse);

always #5 CLK = ~CLK; // 100MHz

initial begin

//inputs here


end

endmodule
