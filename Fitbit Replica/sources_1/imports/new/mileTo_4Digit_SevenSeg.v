`timescale 1ns / 1ps


module mileTo_4Digit_SevenSeg(
    input CLK, input RESET, input [13:0] binaryDigit,
    
    output reg anodeSelect0, output reg anodeSelect1, output reg anodeSelect2, output reg anodeSelect3, output [6:0]sevenSeg
    );
    
    //can try switching every second to see if switching works, then up to every 1/1000 of a second
    
    
    reg [14:0] outerCounter = 0;
    reg [14:0] innerCounter = 0;
    
    reg [3:0] digitIndex = 0;
    
    reg [3:0] mainOutput = 0;
    
    wire [3:0] BCD_ONES;
    wire [3:0] BCD_TENS;
    wire [3:0] BCD_HUNDREDS;
    wire [3:0] BCD_THOUSANDS;   
    
    binaryToBCD BCDmain (binaryDigit, BCD_THOUSANDS, BCD_HUNDREDS, BCD_TENS, BCD_ONES);
    
    BCDToSevenSegment OUTPUTdigit (mainOutput, sevenSeg);
    
    always@(posedge CLK)
    begin
        if (RESET)
        begin
            //reset everything here 
            anodeSelect0 <= 1;
            anodeSelect1 <= 1;
            anodeSelect2 <= 1;
            anodeSelect3 <= 1;
            
            outerCounter <= 0;
            innerCounter <= 0;
            digitIndex <= 0;
            
        end
        
        else //if not in reset mode
        begin
            if (outerCounter == 1999)  // if two seconds have passed (19999)
            begin
                outerCounter <= 0; 
                digitIndex <= digitIndex + 1;
                if (digitIndex > 3) //need to display LSB
                begin
                    digitIndex <= 0; 
                    mainOutput <= BCD_ONES; 
                    
                    anodeSelect0 <= 0; // i think anode = 0 turns it on
                    anodeSelect1 <= 1; //  i think anode = 1 turns it off
                    anodeSelect2 <= 1;
                    anodeSelect3 <= 1;
                end
                
                else if (digitIndex == 1)
                begin
                    //mainOutput <= BCD_TENS; 
                    mainOutput <= 4'b1010; // should be underscore
                    anodeSelect0 <= 1; // i think anode = 0 turns it on
                    anodeSelect1 <= 0; //  i think anode = 1 turns it off;
                    anodeSelect2 <= 1;
                    anodeSelect3 <= 1;
                end
                
                else if (digitIndex == 2)
                begin
                    mainOutput <= BCD_TENS; 
                    anodeSelect0 <= 1; // i think anode = 0 turns it on
                    anodeSelect1 <= 1; //  i think anode = 1 turns it off;
                    anodeSelect2 <= 0;
                    anodeSelect3 <= 1;
                end
                
                else if (digitIndex == 3)
                begin
                    mainOutput <= BCD_HUNDREDS; 
                    anodeSelect0 <= 1; // i think anode = 0 turns it on
                    anodeSelect1 <= 1; //  i think anode = 1 turns it off;
                    anodeSelect2 <= 1;
                    anodeSelect3 <= 0;
                end
                
            end
            
            else if (outerCounter < 1999) // (19999) everything in this else if statement is just to count to 2 seconds 
            begin
                if (innerCounter == 99) //(9999)
                begin
                    innerCounter <= 0;
                    outerCounter <= outerCounter + 1;
                end
                
                else if (innerCounter < 99) //(9999)
                begin
                    innerCounter <= innerCounter + 1;
                end
            end
            
        end
    
    end
    
endmodule
