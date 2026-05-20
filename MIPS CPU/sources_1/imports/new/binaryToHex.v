`timescale 1ns / 1ps

module binaryToHexToSevenSeg(
    input [3:0] SingleHexRegisterValueToDisplay,
    output reg [6:0] sevenSeg
    );
    
    
    always@(SingleHexRegisterValueToDisplay)
    begin
        case (SingleHexRegisterValueToDisplay)
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
        4'b1010 : sevenSeg = 7'b0001000; //A //A-F untested
        4'b1011 : sevenSeg = 7'b0000011; //B
        4'b1100 : sevenSeg = 7'b1000110; //C
        4'b1101 : sevenSeg = 7'b0100001; //D
        4'b1110 : sevenSeg = 7'b0000110; //E
        4'b1111 : sevenSeg = 7'b0001110; //F
        default : sevenSeg = 7'b1111111; // 127 : and displays NOTHING
        
        endcase
    end
    
endmodule
