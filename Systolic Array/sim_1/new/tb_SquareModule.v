`timescale 1ns / 1ps


module tb_SquareModule();
    
reg CLK = 0;
reg RESET = 0;
reg [7:0] currentAxy_in = 0;
reg [7:0] currentBxy_in = 0;
reg PERFORM_NEXT_OPERATION = 0;

wire [7:0] currentAxy_out;
wire [7:0] currentBxy_out; 
wire doneMultiplying;
wire [7:0] cOutput; 


always #5 CLK = ~CLK; // 100MHz

//instantiate SquareModule 

SquareModule uut (CLK,RESET,currentAxy_in,currentBxy_in,PERFORM_NEXT_OPERATION,currentAxy_out,currentBxy_out,doneMultiplying,cOutput);
    
initial begin
RESET = 1;
currentAxy_in = 0;
currentBxy_in = 0;
PERFORM_NEXT_OPERATION = 0;

#5
RESET = 0;
PERFORM_NEXT_OPERATION = 1;
currentAxy_in = 1;
currentBxy_in = 10;

#10
PERFORM_NEXT_OPERATION = 1;
currentAxy_in = 2;
currentBxy_in = 13;

#10
PERFORM_NEXT_OPERATION = 1;
currentAxy_in = 3;
currentBxy_in = 16;

#20
PERFORM_NEXT_OPERATION = 0;
/*
#500000
RESET = 1;
PERFORM_NEXT_OPERATION = 1;
currentAxy_in = 4;
currentBxy_in = 5;

#500000
RESET = 0;
PERFORM_NEXT_OPERATION = 0;
currentAxy_in = 4;
currentBxy_in = 5;
*/

end
    
endmodule
