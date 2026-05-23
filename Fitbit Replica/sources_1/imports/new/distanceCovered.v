`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/21/2022 11:02:55 PM
// Module Name: distanceCovered
//////////////////////////////////////////////////////////////////////////////////


module distanceCovered(
    input CLK, input [22:0] ActualSteps, input RESET, // should be [17:0] ActualSteps
    
    output [13:0] mileCounter
    );
    
    
    reg [17:0] previousStepCount = 0;
    reg [17:0] multiplesOfTwentyFortyEight = 2048;
    reg [3:0] allZeros = 4'b0000;
    reg [13:0] mileCounter_REG= 0; 
    assign mileCounter = mileCounter_REG;
    //NOTE: MAKE SURE TO ACCOUNT FOR THE DIFFERNCE IN SEVEN SEG OUT WHEN BELOW 10 MILES RAN AND 10 MILES AND GREATER RAN. 9_5 VS. 10_0
    //2ND NOTE: MAY NOT NEED TO ACCOUNT FOR THIS because upper numbers will always be zero if < 10 

    always@(posedge CLK) 
    begin
        
        if (RESET)
        begin
            //reset everything here
            previousStepCount <= 0;
            multiplesOfTwentyFortyEight <= 2048;
            mileCounter_REG <= 0;
            
        end
        
        else //normal functionalty
        begin
            if (previousStepCount == ActualSteps) // first need to check if there are actually increasing numbers of steps and you aren't standing still
            begin
                //do nothing because you aren't moving
            end
            else if (previousStepCount != ActualSteps) // more pulses incoming, then need to do stuff
            begin
                if (ActualSteps > multiplesOfTwentyFortyEight)
                begin
                    multiplesOfTwentyFortyEight <= multiplesOfTwentyFortyEight + 2048;
                    mileCounter_REG <=  mileCounter_REG + 5; 
                    previousStepCount <= ActualSteps; 
                end
                
                else if (ActualSteps <= multiplesOfTwentyFortyEight)
                begin
                    // do nothing
                end
                
                
            end
        
        
        end
        
    end
    
endmodule
