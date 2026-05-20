`timescale 1ns / 1ps


//this module takes every input from the four main modules and decides which one to display, based on two-second counter, MUX, and binary to seven segment controller


//NOTE: ALL THIS MODULE DOES IS CHANGE 'MODE' VALUE EVERY TWO SECONDS

module outputSelector(
    input CLK, input RESET, input [13:0] totalSteps, input [13:0] distanceCovered, input [13:0] thirtyTwoStepsPerSecond, input [13:0] sixtyFourStepsPerSecond,
    
    output mainAnode0, output mainAnode1, output mainAnode2, output mainAnode3, output [6:0] mainSevenSeg
    );
    
    reg [1:0] outputIndex = 0;
    reg [14:0] outerCounter = 0;
    reg [14:0] innerCounter = 0;
    
    reg [2:0] MODE = 0;
    
    wire twoSecondPulse;
    
    wire [13:0] mainBinaryInput;
   
    combinationalMux_14BitOutput MUX1 (MODE, totalSteps, distanceCovered, thirtyTwoStepsPerSecond, sixtyFourStepsPerSecond, mainBinaryInput);
    
    binaryTo_4Digit_SevenSeg totalStepsHEHE (CLK, RESET, MODE, mainBinaryInput, mainAnode0, mainAnode1, mainAnode2, mainAnode3, mainSevenSeg);


    twoSecondCounter_pulse pulse1 (CLK, RESET, twoSecondPulse );

    always@(posedge twoSecondPulse)
    begin
    
        if (RESET)
        begin
            MODE <= 0;
            outputIndex <= 0;
        end
        
        else 
        begin
            if (outputIndex == 0) // should display totalSteps
            begin
                MODE <= 0;
                outputIndex <= outputIndex +1;
            end
            
            else if (outputIndex == 1) // should display distanceCovered
            begin
                MODE <= 1; 
                outputIndex <= outputIndex +1;
            end
            
            else if (outputIndex == 2) // should display thirtyTwoStepsPerSecond
            begin
                MODE <= 2;
                outputIndex <= outputIndex +1;
            end
            
            else if (outputIndex == 3)
            begin
                MODE <= 3;
                outputIndex <= outputIndex +1;
            end
                  
        end
          
    end
    
    
    
endmodule
