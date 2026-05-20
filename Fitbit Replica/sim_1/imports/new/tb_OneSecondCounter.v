`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/17/2022 03:37:33 PM
// Module Name: tb_OneSecondCounter
//////////////////////////////////////////////////////////////////////////////////


module tb_OneSecondCounter();

reg CLK = 0;
reg RESET = 0;
reg START_COUNTING = 0;

wire [7:0] NumOfSec; 

OneSecondCounter uut (CLK, RESET, START_COUNTING, NumOfSec);

always #5 CLK = ~CLK; // 100MHz

initial begin
//start typing inputs here

RESET = 0;
START_COUNTING = 0;
#20 
START_COUNTING = 1;






end

endmodule
