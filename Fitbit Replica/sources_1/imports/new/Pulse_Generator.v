`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/16/2022 03:19:08 PM
// Module Name: Pulse_Generator
//////////////////////////////////////////////////////////////////////////////////


module Pulse_Generator(
    input CLK, input [1:0] MODE, input START, input RESET,
    
    output PULSE
    );
    
    reg slow_clk = 0;
    reg [31:0] value = 0;
    
    reg startHybridCounter = 0;
    
    reg inWalkModeFlag = 0; // 0 means in walk mode
    reg [31:0] walkModeCounter = 0;
    
    reg inJogModeFlag = 0;
    reg [31:0] jogModeCounter = 0;
    
    reg inRunModeFlag = 0;
    reg [31:0] runModeCounter = 0;
    
    reg inHybridModeFlag = 0;
    reg [31:0] hybridModeCounter0 = 0;
    reg [31:0] hybridModeCounter1 = 0; 
    reg [31:0] hybridModeCounter2 = 0;
    reg [31:0] hybridModeCounter3 = 0;
    reg [31:0] hybridModeCounter4 = 0;
    reg [31:0] hybridModeCounter5 = 0;
    reg [31:0] hybridModeCounter6 = 0;
    reg [31:0] hybridModeCounter7 = 0;
    reg [31:0] hybridModeCounter8 = 0;
    reg [31:0] hybridModeCounter9 = 0;
    reg [31:0] hybridModeCounter9_73 = 0;
    reg [31:0] hybridModeCounter73_79 = 0;
    reg [31:0] hybridModeCounter79_144 = 0;
    
    reg secondsPassedFlag_1 = 0;
    reg secondsPassedFlag_2 = 0;
    reg secondsPassedFlag_3 = 0;
    reg secondsPassedFlag_4 = 0;
    reg secondsPassedFlag_5 = 0;
    reg secondsPassedFlag_6 = 0;
    reg secondsPassedFlag_7 = 0;
    reg secondsPassedFlag_8 = 0;
    reg secondsPassedFlag_9_73 = 0;
    reg secondsPassedFlag_73_79 = 0;
    reg secondsPassedFlag_79_144 = 0;
    
    //NOTE: NEED TO MAKE ONE COUUNTER FOR EVERY 'MODE', AND RESET EACH OF THE OTHER COUNTERS IN EVERY 'IF' STATEMENT. THIS IS TO PREVENT STARTING A COUNTING CYCLE ON 
    //TOP OF AN OLD ONE, WHICH WILL SKEW THE NEXT PULSE/SECOND TYPE
    
    wire [7:0] secondsPassed;
    
    assign PULSE = slow_clk; 
    OneSecondCounter C1 (CLK, RESET, startHybridCounter, secondsPassed ); 
    
    
    always@(posedge CLK) 
    begin
        if ( (RESET == 1'b1) || (START == 1'b0)) // highest priority 
        begin
            slow_clk <= 0;
            walkModeCounter <= 0;
            jogModeCounter <= 0;
            runModeCounter <= 0;
            
            inWalkModeFlag <= 0;
            inJogModeFlag <= 0;
            inRunModeFlag <= 0;
            inHybridModeFlag <= 0;
            
            hybridModeCounter0 <= 0;
            hybridModeCounter1 <= 0; 
            hybridModeCounter2 <= 0;
            hybridModeCounter3 <= 0;
            hybridModeCounter4 <= 0;
            hybridModeCounter5 <= 0;
            hybridModeCounter6 <= 0;
            hybridModeCounter7 <= 0;
            hybridModeCounter8 <= 0;
            hybridModeCounter9 <= 0;
            hybridModeCounter9_73 <= 0;
            hybridModeCounter73_79 <= 0;
            hybridModeCounter79_144 <= 0;
            
            value <= 1;
            startHybridCounter <= 0;
        end
    //first need to check what MODE i'm in
    
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//      WALK MODE - outputs 32 pulses/second 
        else if (MODE == 2'b00)   
        begin
            if (inWalkModeFlag == 0)
            begin
                inWalkModeFlag <= 1;
                inJogModeFlag <= 0;
                inRunModeFlag <= 0;
                inHybridModeFlag <= 0;
                
                slow_clk <= 0; // resets clock to zero to count pulses
                
                walkModeCounter <= 0;
            end
            
            else
            begin
                startHybridCounter <= 0;
                value <= 1562500; //(100000000 / (2*32)) = 1562500 //first need to calculate value needed to output 32 pulses/second
                if (walkModeCounter == value)
                begin
                    slow_clk = ~slow_clk;
                    walkModeCounter <= 0;
                end
                else
                begin
                    walkModeCounter <= walkModeCounter + 1;
                end
            end
            
        end
        
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//      JOG MODE - outputs 64 pulses/second        
        else if (MODE == 2'b01) 
        begin
            if (inJogModeFlag == 0)
            begin
                inWalkModeFlag <= 0;
                inJogModeFlag <= 1;
                inRunModeFlag <= 0;
                inHybridModeFlag <= 0;
                
                slow_clk <= 0;
                
                jogModeCounter <= 0;

            end
            
            else
            begin
                startHybridCounter <= 0;
                value <= 781250; // (100000000/(2*64)) = 781250
                if (jogModeCounter == value)
                begin
                    slow_clk <= ~slow_clk;
                    jogModeCounter <= 0;
                end
                else 
                begin
                    jogModeCounter <= jogModeCounter +1;
                end
            end
            
        end   

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//      RUN MODE - outputs 128 pulses/second        
        else if (MODE == 2'b10) 
        begin
            if (inRunModeFlag == 0)
            begin
                inWalkModeFlag <= 0;
                inJogModeFlag <= 0;
                inRunModeFlag <= 1;
                inHybridModeFlag <= 0;
                
                slow_clk <= 0;
                
                runModeCounter <= 0;
            end
            
            else
            begin
                startHybridCounter <= 0;
                value <= 390625; // (100000000/(2*128)) = 390625
                if (runModeCounter == value)
                begin
                    slow_clk = ~slow_clk; 
                    runModeCounter <= 0;
                end
                else 
                begin
                    runModeCounter <= runModeCounter +1;
                end
            end
            
        end
        
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//      HYBRID MODE: MODE = 2'b11
        else if (MODE == 2'b11)      
        begin
        //need a module that keeps track of one second, and then outputs a 'done' signal that shows one second has passed and then sets it = 0; 
            if (inHybridModeFlag == 0)
            begin
                inWalkModeFlag <= 0;
                inJogModeFlag <= 0;
                inRunModeFlag <= 0;
                inHybridModeFlag <= 1;
                
                slow_clk <= 0;
                
                hybridModeCounter0 <= 0;
                hybridModeCounter1 <= 0; 
                hybridModeCounter2 <= 0;
                hybridModeCounter3 <= 0;
                hybridModeCounter4 <= 0;
                hybridModeCounter5 <= 0;
                hybridModeCounter6 <= 0;
                hybridModeCounter7 <= 0;
                hybridModeCounter8 <= 0;
                hybridModeCounter9 <= 0;
                hybridModeCounter9_73 <= 0;
                hybridModeCounter73_79 <= 0;
                hybridModeCounter79_144 <= 0;
            end
            
            else if (inHybridModeFlag == 1)// do actual computation below here
            begin
                startHybridCounter <= 1; // starts counter for finding seconds
                if (secondsPassed == 0) // need to output 20 pulses/sec
                begin
                    value <= 2500000; // (100000000/(2*20)) = 2500000
                    if (hybridModeCounter0 == value)
                    begin
                        slow_clk = ~slow_clk; 
                        hybridModeCounter0 <= 0;
                    end
                    else 
                    begin
                        hybridModeCounter0 <= hybridModeCounter0 +1;
                    end
                end
                
                else if (secondsPassed == 1) //betweeen 1-2 seconds, should output 33 pulses/sec
                begin
                    
                    if (secondsPassedFlag_1 == 0)
                    begin
                        slow_clk <= 0; // need to reset all secondsPassedFlag_X flags to zero in each secondsPassed == X part
                        secondsPassedFlag_1 <= 1;
                        secondsPassedFlag_2 <= 0;
                        secondsPassedFlag_3 <= 0;
                        secondsPassedFlag_4 <= 0;
                        secondsPassedFlag_5 <= 0;
                        secondsPassedFlag_6 <= 0;
                        secondsPassedFlag_7 <= 0;
                        secondsPassedFlag_8 <= 0;
                        secondsPassedFlag_9_73 <= 0;
                        secondsPassedFlag_73_79 <= 0;
                        secondsPassedFlag_79_144 <= 0;
                    end
                    
                    
                    value <= 1515151; // (100000000/(2*33)) = 1515151
                    if (hybridModeCounter1 == value)
                    begin
                        slow_clk = ~slow_clk; 
                        hybridModeCounter1 <= 0;
                    end
                    else 
                    begin
                        hybridModeCounter1 <= hybridModeCounter1 +1;
                    end
                end
                
                else if (secondsPassed == 2)
                begin
                    if (secondsPassedFlag_2 == 0)
                    begin
                        slow_clk <= 0; // need to reset all secondsPassedFlag_X flags to zero in each secondsPassed == X part
                        secondsPassedFlag_2 <= 1;
                        secondsPassedFlag_1 <= 0;
                        secondsPassedFlag_3 <= 0;
                        secondsPassedFlag_4 <= 0;
                        secondsPassedFlag_5 <= 0;
                        secondsPassedFlag_6 <= 0;
                        secondsPassedFlag_7 <= 0;
                        secondsPassedFlag_8 <= 0;
                        secondsPassedFlag_9_73 <= 0;
                        secondsPassedFlag_73_79 <= 0;
                        secondsPassedFlag_79_144 <= 0;
                    end
                    
                    value <= 757575; // (100000000/(2*66)) = 757575
                    if (hybridModeCounter2 == value)
                    begin
                        slow_clk = ~slow_clk; 
                        hybridModeCounter2 <= 0;
                    end
                    else 
                    begin
                        hybridModeCounter2 <= hybridModeCounter2 +1;
                    end
                end
                
                else if (secondsPassed == 3)
                begin
                    if (secondsPassedFlag_3 == 0)
                    begin
                        slow_clk <= 0; // need to reset all secondsPassedFlag_X flags to zero in each secondsPassed == X part
                        secondsPassedFlag_3 <= 1;
                        secondsPassedFlag_1 <= 0;
                        secondsPassedFlag_2 <= 0;
                        secondsPassedFlag_4 <= 0;
                        secondsPassedFlag_5 <= 0;
                        secondsPassedFlag_6 <= 0;
                        secondsPassedFlag_7 <= 0;
                        secondsPassedFlag_8 <= 0;
                        secondsPassedFlag_9_73 <= 0;
                        secondsPassedFlag_73_79 <= 0;
                        secondsPassedFlag_79_144 <= 0;
                    end
                    
                    value <= 1851851; // (100000000/(2*27)) = 1851851
                    if (hybridModeCounter3 == value)
                    begin
                        slow_clk = ~slow_clk; 
                        hybridModeCounter3 <= 0;
                    end
                    else 
                    begin
                        hybridModeCounter3 <= hybridModeCounter3 +1;
                    end
                end 
                
                else if (secondsPassed == 4)
                begin
                
                    if (secondsPassedFlag_4 == 0)
                    begin
                        slow_clk <= 0; // need to reset all secondsPassedFlag_X flags to zero in each secondsPassed == X part
                        secondsPassedFlag_4 <= 1;
                        secondsPassedFlag_1 <= 0;
                        secondsPassedFlag_2 <= 0;
                        secondsPassedFlag_3 <= 0;
                        secondsPassedFlag_5 <= 0;
                        secondsPassedFlag_6 <= 0;
                        secondsPassedFlag_7 <= 0;
                        secondsPassedFlag_8 <= 0;
                        secondsPassedFlag_9_73 <= 0;
                        secondsPassedFlag_73_79 <= 0;
                        secondsPassedFlag_79_144 <= 0;
                    end
                    
                    value <= 714285; // (100000000/(2*70)) = 714285
                    if (hybridModeCounter4 == value)
                    begin
                        slow_clk = ~slow_clk; 
                        hybridModeCounter4 <= 0;
                    end
                    else 
                    begin
                        hybridModeCounter4 <= hybridModeCounter4 +1;
                    end
                end
                
                else if (secondsPassed == 5)
                begin
                    if (secondsPassedFlag_5 == 0)
                    begin
                        slow_clk <= 0; // need to reset all secondsPassedFlag_X flags to zero in each secondsPassed == X part
                        secondsPassedFlag_5 <= 1;
                        secondsPassedFlag_1 <= 0;
                        secondsPassedFlag_2 <= 0;
                        secondsPassedFlag_3 <= 0;
                        secondsPassedFlag_4 <= 0;
                        secondsPassedFlag_6 <= 0;
                        secondsPassedFlag_7 <= 0;
                        secondsPassedFlag_8 <= 0;
                        secondsPassedFlag_9_73 <= 0;
                        secondsPassedFlag_73_79 <= 0;
                        secondsPassedFlag_79_144 <= 0;
                    end
                
                    value <= 1666666; //(100000000/(2*30)) = 1666666 
                    if (hybridModeCounter5 == value)
                    begin
                        slow_clk = ~slow_clk; 
                        hybridModeCounter5 <= 0;
                    end
                    else 
                    begin
                        hybridModeCounter5 <= hybridModeCounter5 +1;
                    end
                end
                
                else if (secondsPassed == 6)
                begin
                    if (secondsPassedFlag_6 == 0)
                    begin
                        slow_clk <= 0; // need to reset all secondsPassedFlag_X flags to zero in each secondsPassed == X part
                        secondsPassedFlag_6 <= 1;
                        secondsPassedFlag_1 <= 0;
                        secondsPassedFlag_2 <= 0;
                        secondsPassedFlag_3 <= 0;
                        secondsPassedFlag_4 <= 0;
                        secondsPassedFlag_5 <= 0;
                        secondsPassedFlag_7 <= 0;
                        secondsPassedFlag_8 <= 0;
                        secondsPassedFlag_9_73 <= 0;
                        secondsPassedFlag_73_79 <= 0;
                        secondsPassedFlag_79_144 <= 0;
                    end
                
                    value <= 2631578; // (100000000/(2*19)) = 2631578
                    if (hybridModeCounter6 == value)
                    begin
                        slow_clk = ~slow_clk; 
                        hybridModeCounter6 <= 0;
                    end
                    else 
                    begin
                        hybridModeCounter6 <= hybridModeCounter6 +1;
                    end
                end
                
                else if (secondsPassed == 7)
                begin
                    if (secondsPassedFlag_7 == 0)
                    begin
                        slow_clk <= 0; // need to reset all secondsPassedFlag_X flags to zero in each secondsPassed == X part
                        secondsPassedFlag_7 <= 1;
                        secondsPassedFlag_1 <= 0;
                        secondsPassedFlag_2 <= 0;
                        secondsPassedFlag_3 <= 0;
                        secondsPassedFlag_4 <= 0;
                        secondsPassedFlag_5 <= 0;
                        secondsPassedFlag_6 <= 0;
                        secondsPassedFlag_8 <= 0;
                        secondsPassedFlag_9_73 <= 0;
                        secondsPassedFlag_73_79 <= 0;
                        secondsPassedFlag_79_144 <= 0;
                    end
                
                    value <= 1666666; // (100000000/(2*30)) = 1666666
                    if (hybridModeCounter7 == value)
                    begin
                        slow_clk = ~slow_clk; 
                        hybridModeCounter7 <= 0;
                    end
                    else 
                    begin
                        hybridModeCounter7 <= hybridModeCounter7 +1;
                    end
                end
                
                else if ((secondsPassed == 8) )
                begin
                    if (secondsPassedFlag_8 == 0)
                    begin
                        slow_clk <= 0; // need to reset all secondsPassedFlag_X flags to zero in each secondsPassed == X part
                        secondsPassedFlag_8 <= 1;
                        secondsPassedFlag_1 <= 0;
                        secondsPassedFlag_2 <= 0;
                        secondsPassedFlag_3 <= 0;
                        secondsPassedFlag_4 <= 0;
                        secondsPassedFlag_5 <= 0;
                        secondsPassedFlag_6 <= 0;
                        secondsPassedFlag_7 <= 0;
                        secondsPassedFlag_9_73 <= 0;
                        secondsPassedFlag_73_79 <= 0;
                        secondsPassedFlag_79_144 <= 0;
                    end
                
                    value <= 1515151; // (100000000/(2*33)) = 1515151
                    if (hybridModeCounter8 == value)
                    begin
                        slow_clk = ~slow_clk; 
                        hybridModeCounter8 <= 0;
                    end
                    else 
                    begin
                        hybridModeCounter8 <= hybridModeCounter8 +1;
                    end
                end
                
                else if ( (secondsPassed >=9) && (secondsPassed < 73))
                begin 
                    if (secondsPassedFlag_9_73 == 0)
                    begin
                        slow_clk <= 0; // need to reset all secondsPassedFlag_X flags to zero in each secondsPassed == X part
                        secondsPassedFlag_9_73 <= 1;
                        secondsPassedFlag_1 <= 0;
                        secondsPassedFlag_2 <= 0;
                        secondsPassedFlag_3 <= 0;
                        secondsPassedFlag_4 <= 0;
                        secondsPassedFlag_5 <= 0;
                        secondsPassedFlag_6 <= 0;
                        secondsPassedFlag_7 <= 0;
                        secondsPassedFlag_8 <= 0;
                        secondsPassedFlag_73_79 <= 0;
                        secondsPassedFlag_79_144 <= 0;
                    end
                
                    value <= 724637; // (100000000/(2*69)) = 724637
                    if (hybridModeCounter9_73 == value)
                    begin
                        slow_clk = ~slow_clk; 
                        hybridModeCounter9_73 <= 0;
                    end
                    else 
                    begin
                        hybridModeCounter9_73 <= hybridModeCounter9_73 +1;
                    end
                end
                
                else if ( (secondsPassed >= 73) && (secondsPassed < 79))
                begin
                
                    if (secondsPassedFlag_73_79 == 0)
                    begin
                        slow_clk <= 0; // need to reset all secondsPassedFlag_X flags to zero in each secondsPassed == X part
                        secondsPassedFlag_73_79 <= 1;
                        secondsPassedFlag_1 <= 0;
                        secondsPassedFlag_2 <= 0;
                        secondsPassedFlag_3 <= 0;
                        secondsPassedFlag_4 <= 0;
                        secondsPassedFlag_5 <= 0;
                        secondsPassedFlag_6 <= 0;
                        secondsPassedFlag_7 <= 0;
                        secondsPassedFlag_8 <= 0;
                        secondsPassedFlag_9_73 <= 0;
                        secondsPassedFlag_79_144 <= 0;
                    end
                    
                    value <= 1470588; // (100000000/(2*34)) = 1470588
                    if (hybridModeCounter73_79 == value)
                    begin
                        slow_clk = ~slow_clk;
                        hybridModeCounter73_79 <= 0; 
                    end
                    else 
                    begin
                        hybridModeCounter73_79 <= hybridModeCounter73_79 +1;
                    end
                end
                
                else if ( (secondsPassed >= 79) && (secondsPassed < 145))
                begin
                
                    if (secondsPassedFlag_79_144 == 0)
                    begin
                        slow_clk <= 0; // need to reset all secondsPassedFlag_X flags to zero in each secondsPassed == X part
                        secondsPassedFlag_79_144 <= 1;
                        secondsPassedFlag_1 <= 0;
                        secondsPassedFlag_2 <= 0;
                        secondsPassedFlag_3 <= 0;
                        secondsPassedFlag_4 <= 0;
                        secondsPassedFlag_5 <= 0;
                        secondsPassedFlag_6 <= 0;
                        secondsPassedFlag_7 <= 0;
                        secondsPassedFlag_8 <= 0;
                        secondsPassedFlag_9_73 <= 0;
                        secondsPassedFlag_73_79 <= 0;
                    end
                    
                    value <= 403225; // (100000000/(2*124)) = 403225
                    if (hybridModeCounter79_144 == value)
                    begin
                        slow_clk = ~slow_clk; 
                        hybridModeCounter79_144 <= 0;
                    end
                    else 
                    begin
                        hybridModeCounter79_144 <= hybridModeCounter79_144 +1;
                    end
                end
                
                
                else if (secondsPassed >= 145)
                begin
                    slow_clk <= 0;
                end
              
            end
        end      
    end
    
    
    
endmodule
