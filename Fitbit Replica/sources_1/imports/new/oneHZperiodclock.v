`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Created By Daniel Krueger and Ryan Arnold
//////////////////////////////////////////////////////////////////////////////////

//real frequency
//(100*10^6)/2 = 50000000
`define frequency 50000000


module oneHZperiodclock(
    input clk //input the 
    ,output reg secondclk = 0
    ,output twosecondclk
    );
    
    
    reg [30:0] clkstore = 0;
    reg [1:0] twosecondstore = 0;
    assign twosecondclk = twosecondstore[1];
    
    always @(posedge clk)
        begin 
            if(clkstore < `frequency)
                begin
                    clkstore = clkstore + 1;
                end
            else
                begin
                    secondclk = ~secondclk;
                    clkstore = 0;
                    twosecondstore = twosecondstore + 1;
                end
        end
    
endmodule
