`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/18/2022 01:39:39 PM 
// Module Name: tb_BCDToSevenSegment
//////////////////////////////////////////////////////////////////////////////////


module tb_BCDToSevenSegment();

reg [3:0] BCD = 0;

wire [6:0] sevenSeg; 
wire anodeSelect; 

BCDToSevenSegment uut (BCD, sevenSeg, anodeSelect);


initial begin

BCD = 4'b1010;

end

endmodule
