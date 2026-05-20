`timescale 1ns / 1ps

//THIS MODULE OUTPUTS A POSEDGE 'TWOSECONDPULSE' EVERY 2 SECONDS


module twoSecondCounter_pulse(
    input CLK, input RESET,
    
    output twoSecondPulse
    );
    
    
   reg [13:0] innerCounter = 0;
   reg [13:0] outerCounter = 0;
   reg twoSecondPulse_REG = 0;
   assign twoSecondPulse = twoSecondPulse_REG;
    
   always@(posedge CLK)
   begin
    if (RESET)
    begin
       innerCounter <= 0;
       outerCounter <= 0;
       twoSecondPulse_REG <= 0;
    end
    
    else
    begin
        if (outerCounter == 9999) // one seconds have passed
        begin
            outerCounter <= 0;
            innerCounter <= 0;
            twoSecondPulse_REG <= ~twoSecondPulse_REG;
        end
        
        else if (outerCounter < 9999)
        begin
            if (innerCounter == 9999)
            begin
                innerCounter <= 0;
                outerCounter <= outerCounter +1;
            end
            else if (innerCounter < 9999)
            begin
                innerCounter <= innerCounter +1;
            end
            
        end 
    end
   end
    
endmodule
