`timescale 1ns / 1ps


module OneSecondCounter(
    input CLK, input RESET, input START_COUNTING,
    
    output [7:0] NumOfSec
    );
    //MAIN_RESET is main reset from system, MUST counter = 0; 
    //START_COUNTING is for gating module to only start timer when START_COUNTING = 0;
    
    //this module should count how many seconds have passed since SECOND_RESET = 0;
    
   reg [7:0] numOfSecondsPassed = 0; //2^8 = 256
   reg [13:0] innerCounter = 0;
   reg [13:0] outerCounter = 0;
   
   assign NumOfSec = numOfSecondsPassed; 
   
   always@(posedge CLK)
   begin
    if (RESET || (!START_COUNTING))
    begin
       numOfSecondsPassed <= 0;
       innerCounter <= 0;
       outerCounter <= 0;
    end
    else if (START_COUNTING)
    begin
        if (outerCounter == 9999) // (9999) one second has passed
        begin
            numOfSecondsPassed <= numOfSecondsPassed + 1; 
            outerCounter <= 0;
            innerCounter <= 0;
        end
        
        else if (outerCounter < 9999) // 9999
        begin
            if (innerCounter == 9999) // 9999
            begin
                innerCounter <= 0;
                outerCounter <= outerCounter +1;
            end
            else if (innerCounter < 9999) // 9999
            begin
                innerCounter <= innerCounter +1;
            end
            
        end 
    end
   end
    
endmodule
