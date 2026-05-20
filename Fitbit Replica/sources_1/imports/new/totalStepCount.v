`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/18/2022 03:37:49 PM
// Module Name: totalStepCount
//////////////////////////////////////////////////////////////////////////////////


module totalStepCount(
    input PULSE, input RESET,
    
    output [13:0] sevenSegOut, output [22:0] actualTotalStepsOut, output SI
    );
    
    //MAKE SURE TO SET BELOW COUNTERS TO ZERO
    reg [13:0] counter_SevenSegment = 0; // limited to output up to 9999
    reg [22:0] counter_actualTotal = 0;  
    reg SI_REG = 0;
    
    assign SI = SI_REG; 
    assign sevenSegOut = counter_SevenSegment; 
    assign actualTotalStepsOut = counter_actualTotal; 
    
    
    always@(posedge PULSE or posedge RESET)
    begin
        if (RESET)
        begin
            counter_actualTotal <= 0;
            counter_SevenSegment <= 0;
            SI_REG <= 0;
        end
        
        else
        begin
            if (counter_actualTotal >= 9999) // need to keep incrementing counter_actualTotal and stop incrementing counter_SevenSegment
            begin
                counter_actualTotal <= counter_actualTotal + 1;
                counter_SevenSegment <= 9999;
                SI_REG <= 1;
            end
            
            else if (counter_actualTotal < 9999)
            begin
                counter_actualTotal <= counter_actualTotal + 1;
                counter_SevenSegment <= counter_SevenSegment + 1;
                SI_REG <= 0;
            end
            
        end
    
    end
    
endmodule
