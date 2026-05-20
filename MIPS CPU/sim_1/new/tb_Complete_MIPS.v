`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 06/28/2024 02:36:47 PM
// Module Name: tb_Complete_MIPS
//////////////////////////////////////////////////////////////////////////////////

module tb_Complete_MIPS();

reg CLK = 1;
reg RST = 0;

wire [6:0] Address_Out;
wire[31:0] Data_Out;
    
    
always #5 CLK = ~CLK; // 100MHz

Complete_MIPS main(CLK, RST, Address_Out, Data_Out);

initial begin
RST=0;
#5
RST = 1;
#10
RST = 0;

end

endmodule
