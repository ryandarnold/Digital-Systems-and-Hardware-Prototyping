`timescale 1ns / 1ps


module SlowClockForMemory(

    input CLK, 
    
    output reg SlowCLK
    );
    
    reg [1:0] counter = 0;
    
    initial begin
    SlowCLK = 0;
    end
    
always@(posedge CLK)
    begin
    
        if (counter == 2)
        begin
            counter <= 0;
            SlowCLK <= ~SlowCLK;
        end
        
        else 
        begin
            counter <= counter +1;
        end
    
    end
    
    
endmodule
