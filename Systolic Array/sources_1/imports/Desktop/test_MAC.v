`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//MAC for testing behavioral logic of code 
//////////////////////////////////////////////////////////////////////////////////


module test_MAC(
    input [7:0] A
    ,input [7:0] B
    ,input [7:0] C
    ,input updateflag//updates the contents of the MAC when changed
    //,input reset//resets all values to 0 ADD THESE FLAGS WHEN NEEDED
    ,output reg [7:0] outputMAC
    );
    
    
    always @(A,B,C,updateflag)
        begin
            outputMAC = A + (B*C);
        end
        
        
endmodule
