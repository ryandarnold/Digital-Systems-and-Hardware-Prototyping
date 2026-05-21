`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/17/2022 10:58:51 PM
// Module Name: tb_binaryToBCD
//////////////////////////////////////////////////////////////////////////////////


module tb_binaryToBCD();


reg [13:0] binaryInput = 0;

wire [3:0] BCD_THOUSANDS;
wire [3:0] BCD_HUNDREDS;
wire [3:0] BCD_TENS;
wire [3:0] BCD_ONES; 


binaryToBCD uut (binaryInput, BCD_THOUSANDS, BCD_HUNDREDS, BCD_TENS, BCD_ONES);

initial begin
//insert input here

binaryInput = 1;

end

endmodule
