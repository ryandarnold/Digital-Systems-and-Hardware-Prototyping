`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/22/2022 01:32:40 PM
// Module Name: tb_binaryTo_4Digit_SevenSeg
//////////////////////////////////////////////////////////////////////////////////


module tb_binaryTo_4Digit_SevenSeg();

reg CLK = 0;
reg RESET = 0;
reg [2:0] MODE = 0;
reg [13:0] binaryDigit = 0;

wire anodeSelect0;
wire anodeSelect1;
wire anodeSelect2;
wire anodeSelect3;
wire [6:0] sevenSeg; 

binaryTo_4Digit_SevenSeg uut (CLK, RESET, MODE, binaryDigit, anodeSelect0, anodeSelect1, anodeSelect2, anodeSelect3, sevenSeg);

always #5 CLK = ~CLK; // 100MHz

initial begin
//type inputs here

RESET = 0;
MODE = 0;
#5
binaryDigit = 234;
#25000000
MODE = 1;

end

endmodule
