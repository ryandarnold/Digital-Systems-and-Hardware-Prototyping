`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/23/2022 05:44:09 PM
// Module Name: combinationalMux_14BitOutput
//////////////////////////////////////////////////////////////////////////////////


module combinationalMux_14BitOutput(
    input [2:0] MODE, input [13:0] totalSteps, input [13:0] distanceCovered, input [13:0] thirtyTwoStepsPerSecond, input [13:0] sixtyFourStepsPerSecond,
    
    output reg [13:0] mainOutputForMUX
    );
    
    always@(*)
    begin
        if (MODE == 0)
        begin
            mainOutputForMUX = totalSteps;
        end
        
        else if (MODE == 1)
        begin
            mainOutputForMUX = distanceCovered;
        end
        
        else if (MODE == 2)
        begin
            mainOutputForMUX = thirtyTwoStepsPerSecond;
        end
        
        else //MODE == 3
        begin
            mainOutputForMUX = sixtyFourStepsPerSecond;
        end
        
    end
endmodule
