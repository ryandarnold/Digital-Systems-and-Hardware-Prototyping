`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/17/2022 10:57:55 PM 
// Module Name: binaryToBCD
//////////////////////////////////////////////////////////////////////////////////


module binaryToBCD(
    input [13:0] binaryInput,
    
    output reg [3:0] BCD_THOUSANDS,
    output reg [3:0] BCD_HUNDREDS,
    output reg [3:0] BCD_TENS,
    output reg [3:0] BCD_ONES
    
    );
    
    //  https://www.youtube.com/watch?v=IBgiB7KXfEY
    integer index; 
    
    always@(binaryInput)
    begin
        //first reset the BCD outputs
        BCD_ONES = 4'b0000;
        BCD_TENS = 4'b0000;
        BCD_HUNDREDS = 4'b0000;
        BCD_THOUSANDS = 4'b0000;
        
        for (index = 13; index >= 0; index = index -1)
        begin
            if (BCD_THOUSANDS >= 5)
            begin
                BCD_THOUSANDS = BCD_THOUSANDS + 3;
            end
            if (BCD_HUNDREDS >= 5)
            begin
                BCD_HUNDREDS = BCD_HUNDREDS + 3;
            end
            if (BCD_TENS >= 5)
            begin
                BCD_TENS = BCD_TENS + 3;
            end
            if (BCD_ONES >= 5)
            begin
                BCD_ONES = BCD_ONES +3;
            end
            
            BCD_THOUSANDS = BCD_THOUSANDS << 1; 
            BCD_THOUSANDS[0] = BCD_HUNDREDS[3];
            
            BCD_HUNDREDS = BCD_HUNDREDS << 1;
            BCD_HUNDREDS[0] = BCD_TENS[3];
            
            BCD_TENS = BCD_TENS << 1;
            BCD_TENS[0] = BCD_ONES[3];
            
            BCD_ONES = BCD_ONES << 1;
            BCD_ONES[0] = binaryInput[index];
        end
    end
    
    
endmodule
