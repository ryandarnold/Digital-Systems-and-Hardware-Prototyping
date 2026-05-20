`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/22/2022 03:28:17 PM
// Module Name: tb_distanceCovered
//////////////////////////////////////////////////////////////////////////////////


module tb_distanceCovered();

reg CLK = 0;
reg RESET = 0;
reg [17:0] ActualSteps;

wire anodeSelect0;
wire anodeSelect1;
wire anodeSelect2;
wire anodeSelect3;
wire [3:0] sevenSeg; 

distanceCovered uut (CLK, ActualSteps, RESET, anodeSelect0, anodeSelect1, anodeSelect2, anodeSelect3, sevenSeg); 

always #5 CLK = ~CLK; // 100MHz

initial begin
//inputs here


RESET = 0;
ActualSteps = 0;

#50
ActualSteps = 1000;
#20
ActualSteps = 2000;
#20 
ActualSteps = 2048; 
#20
ActualSteps = 2049;

end

endmodule
