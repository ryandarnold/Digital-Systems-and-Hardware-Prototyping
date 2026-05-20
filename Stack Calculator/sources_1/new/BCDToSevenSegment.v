`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/18/2022 01:38:48 PM
// Module Name: BCDToSevenSegment
//////////////////////////////////////////////////////////////////////////////////


//THIS MODULE TAKES IN A SINGLE BCD DIGIT AND OUTPUTS IT ON THE SEVEN SEGMENT DISPLAY

module BCDToSevenSegment(
    input [3:0] BCD,
    output reg [6:0] sevenSeg
    );
        
    always@(BCD)
    begin
        case (BCD)
        4'b0000 : sevenSeg = 7'b1000000; // 64 for seven seg
        4'b0001 : sevenSeg = 7'b1111001; // 121 for seven seg
        4'b0010 : sevenSeg = 7'b0100100; // 36
        4'b0011 : sevenSeg = 7'b0110000; // 48
        4'b0100 : sevenSeg = 7'b0011001; // 25
        4'b0101 : sevenSeg = 7'b0010010; // 18
        4'b0110 : sevenSeg = 7'b0000010; // 2
        4'b0111 : sevenSeg = 7'b1111000; // 120
        4'b1000 : sevenSeg = 7'b0000000; // 0
        4'b1001 : sevenSeg = 7'b0010000; // 16
        4'b1010 : sevenSeg = 7'b1110111; // 119 : underscore
        default : sevenSeg = 7'b1111111; // 127 : and displays NOTHING
        
        endcase
    

    end
    
    
endmodule
