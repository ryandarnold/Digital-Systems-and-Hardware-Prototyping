`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 11/02/2022 06:07:11 PM
// Module Name: SquareModule
//////////////////////////////////////////////////////////////////////////////////


module SquareModule(
    input CLK,
    input RESET,
    //input START_Multiplying, // this signal comes from previous square module
    input [7:0] currentAxy_in,
    input [7:0] currentBxy_in,
    input PERFORM_NEXT_OPERATION,
    output [7:0] currentAxy_out,
    output [7:0] currentBxy_out,
    output doneMultiplying,
    output reg [7:0] cOutput = 0
    );
    
    reg [2:0] numberOfMACsCompleted;
    reg [7:0] currentAxy_out_REG;
    reg [7:0] currentBxy_out_REG;
    
    //Danny's added variables
    reg [7:0] currentVal = 0;
    wire [7:0] outputMAC;
    reg reset = 0;
    reg updateflag = 0;
    
    //MAC u1(.A(currentVal),.B(currentAxy_in),.C(currentBxy_in),.outputMAC(outputMAC),.updateflag(updateflag),.resetflag(RESET));
    test_MAC u1(.B(currentAxy_in),.C(currentBxy_in),.outputMAC(outputMAC),.A(currentVal));
    ///////////////////////////////////////
    
    
    reg doneMultiplying_REG;
    initial 
    begin
        numberOfMACsCompleted = 0;
        currentAxy_out_REG = 0;
        currentBxy_out_REG = 0;
        doneMultiplying_REG = 0;
    end
     
    assign currentAxy_out = currentAxy_out_REG;
    assign currentBxy_out = currentBxy_out_REG;
    assign doneMultiplying = doneMultiplying_REG;
    
    //could have two always@ blocks. One for computing the multiplication, 
    //and the other for timing and strictly outputting for the block to the right and block down of the current square

reg [3:0] outputNextCounter = 0;
reg [7:0] tempStoreAxy_in = 0;
reg [7:0] tempStoreBxy_in = 0;
always@(posedge CLK) // this clock for determining when to output the next block's input bc each non a00/b00 clock needs its inputs delayed by 'x' clock cycles
begin
    //need to always output the incoming Axy row to the module to the right
    //need to also always output the incoming Bxy row to the module below 
    if (RESET ==1)
    begin
        currentAxy_out_REG <= 0;
        currentBxy_out_REG <= 0;
        
        outputNextCounter <= 0;
    end
    
    else if ( (PERFORM_NEXT_OPERATION == 1) /*&& (outputNextCounter == 0)*/)
    begin
        //need to start finding a way to output next Axy/Bxy value
        currentAxy_out_REG <= currentAxy_in;
        currentBxy_out_REG <= currentBxy_in;
    end
    
    /*else if ( (PERFORM_NEXT_OPERATION == 1) && (outputNextCounter == 1) ) // change output == 'x' if needed
    begin
        currentAxy_out_REG <= tempStoreAxy_in; 
        currentBxy_out_REG <= tempStoreBxy_in;
        outputNextCounter <= 0;
    end*/
    
    
end

    
    
    
always@(posedge CLK) // this always@ block for computing multiply and add accumulation. 
    begin
        if (RESET == 1)
        begin
            cOutput <= 0;
            numberOfMACsCompleted <= 0;
            doneMultiplying_REG <= 0;
        end
        
        //// ready to multiply next two matrix values
        else if ( (PERFORM_NEXT_OPERATION == 1) && (numberOfMACsCompleted < 3) /*&& (START_Multiplying ==1)*/) 
        begin
        //Should only multiply the two values if only have multiplied the three needed matrix values
        //If done multiplying, then need to just output current value and wait until top module signals
        //to multiply again (AKA reset is asserted 
            cOutput <= outputMAC; //need to comment out this line once we get floating-point MAC to work perfectly
            currentVal <= outputMAC; //update the value stored in the MAC
            
            numberOfMACsCompleted <= numberOfMACsCompleted + 1; // execute Multiply-accumulate only 3 times for 3x3 matrix
            doneMultiplying_REG <= 1;
        end
        
        
    end
    
    
    
endmodule
