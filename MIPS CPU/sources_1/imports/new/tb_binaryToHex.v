`timescale 1ns / 1ps


module tb_binaryToHex();
reg CLK;
reg [31:0] registerToOutput;
wire [3:0] hex8;
wire [3:0] hex7;
wire [3:0] hex6;
wire [3:0] hex5;
wire [3:0] hex4;
wire [3:0] hex3;
wire [3:0] hex2;
wire [3:0] hex1;
wire [3:0] hex0;

binaryToHexToSevenSeg uut (CLK, registerToOutput,hex8,hex7,hex6,hex5,hex4,hex3,hex2,hex1,hex0 );

initial begin

end

endmodule
