`timescale 1ns / 1ps


module Controller(

    input CLK, 
    output reg CS, output reg WE, output reg [6:0] ADDRESS_OUT, 
    
    input [7:0] data_in, 
    output reg [7:0] data_out, 
    
    input ButtonUp_unfiltered, input ButtonDown_unfiltered, input ButtonLeft_unfiltered, input ButtonRight_unfiltered, input [7:0] SWITCH_controller, 
    output [7:0] LED_controller, output [6:0] sevenSeg_controller, 
    output anode0_controller, output anode1_controller, output anode2_controller, output anode3_controller
    );
    
    reg RESET = 0; //DO NOT UPDATE
    reg displayOutputFlag = 1;//DO NOT UPDATE
    
    reg [6:0] DAR = 0; // DISPLAY ADDRESS REGISTER
    reg [6:0] SPR = 8'h7F; // STACK POINTER
    reg [7:0] DVR = 0; // DISPLAY VALUE REGISTER 
    reg EMPTYFLAG = 1; // originally empty stack
    
    binaryTo_4Digit_SevenSeg OUT1 (CLK, RESET, displayOutputFlag,{6'b000000,DVR},anode0_controller,anode1_controller,anode2_controller,anode3_controller,sevenSeg_controller);  
    
    initial begin
    CS = 0; // chip select
    WE = 0;// write enable
    end
    
     wire Button0 = ButtonUp_unfiltered;
     wire Button1 = ButtonDown_unfiltered;
     wire Button2 = ButtonRight_unfiltered;
     wire Button3 = ButtonLeft_unfiltered;
     
     assign LED_controller[7] = EMPTYFLAG;
     assign LED_controller[6:0] = DAR; // LED[6:0] show contents of DAR register
     
     //BELOW REGS AND FLAGS ARE FOR THE ADD OPERATOR
     reg [7:0] StackStoreFIRST = 0; // stores top stack value
     reg [7:0] additionRegister = 0; // stores second to top stack value
     //reg [7:0] 
     reg startedAddFlag = 0;
     
     reg ADD_currentlyOnFirstReadStep = 1;
     reg ADD_currentlyOnFirstWriteStep = 0;
     reg ADD_currentlyOnSecondReadStep = 0;
     reg ADD_currentlyOnSecondWriteStep = 0;
     
     reg ADD_waitOneClockCycle1 = 0;
     reg ADD_waitOneClockCycle2 = 0;
     reg ADD_waitOneClockCycle3 = 0;
     //ABOVE REGS AND FLAGS ARE FOR THE ADD OPERATOR
     
     //BELOW REGS AND FLAGS ARE FOR THE SUBTRACT OPERATOR
     reg [7:0] subtract_StackStoreFIRST = 0; // stores top stack value
     reg [7:0] subtractionRegister = 0; // stores second to top stack value
     //reg [7:0] 
     reg startedSubtractFlag = 0;
     
     reg subtract_currentlyOnFirstReadStep = 1; 
     reg subtract_currentlyOnFirstWriteStep = 0;
     reg subtract_currentlyOnSecondReadStep = 0;
     reg subtract_currentlyOnSecondWriteStep = 0; 
     
     reg subtract_waitOneClockCycle1 = 0; // gucci
     reg subtract_waitOneClockCycle2 = 0; // gucci
     reg subtract_waitOneClockCycle3 = 0; // gucci
     //ABOVE REGS AND FLAGS ARE FOR THE SUBTRACT OPERATOR
     
     
     reg [2:0] Enter_PushWEFlag = 0;
     reg [2:0] Delete_PopWEFlag = 0;
     reg [2:0] Add_WEFlag = 0;
     reg [2:0] Subtract_WEFlag = 0;
     reg [2:0] Top_WEFlag =0;
     reg [2:0] Dec_WEFlag = 0;
     reg [2:0] Inc_WEFlag = 0;
     reg only_perform_action_once = 0;
    always@(posedge CLK)
        begin 
        //NOTE: BUTTON SETTINGS: 
        //UP = 0, DOWN = 1, LEFT = 3, RIGHT = 2
        
            if (SPR == 8'h7F) // need to check EMPTYFLAG every clock cycle so I don't have to check it continuously in each if statement block below
            begin
                EMPTYFLAG = 1; //now empty
            end
            
            else
            begin
                EMPTYFLAG = 0;  // not empty
            end
            
            
            //NEED TO CHECK RESET STATE HERE
            if ( (Button3==1) && (Button2==0) && (Button1==1) && (Button0==0)) //CLR/RESET 
            begin
                // Resets the SPR to 0x7F, DAR to 0x00 and DVR to 0x00. Stack should be empty (EMPTY flag=1)       
                DAR <= 0; 
                SPR <= 8'h7F; 
                DVR <= 0;
            end
            
            //resets flag so the action happens only once per push
            else if ((Button3==0) && (Button2==0) && (Button1==0) && (Button0==0))
            begin
                only_perform_action_once <= 0;
            end
            
            // Enter/Push
            else if ((((Button3==0)&&(Button2==0)&&(Button1==0)&&(Button0 ==1)) || (Enter_PushWEFlag > 0)) && (only_perform_action_once == 0)) 
                begin
                    //reads the value from switches on the board and pushes it on the top of the stack
                    Enter_PushWEFlag <= Enter_PushWEFlag +1; // makes sure to reset WE equal to zero most of the time
                    if (Enter_PushWEFlag == 0) // might need to make this == 0 OR == 1 to make sure it can write properly
                    begin
                        CS <= 1; // gonna write data to stack
                        WE <= 1; // gonna write data to stack
                        SPR <= SPR -1;
                        DAR <= DAR -1; // may have to change this to "DAR <= DAR + 1" but not sure
                        
                        ADDRESS_OUT <= SPR;
                        data_out <= SWITCH_controller; // should put the value of SWITCHES on top of stack
                    end
                    
                    else if (Enter_PushWEFlag == 1)
                    begin
                        WE <=0;
                        ADDRESS_OUT <= DAR; //new DAR (should be old SPR)
                    end
                    else if (Enter_PushWEFlag == 3)
                    begin
                        Enter_PushWEFlag <= 0;
                        DVR <= data_in; // this may not work, may need to wait two total clock cycles after 'pushing' to read in DVR <= data_in
                        only_perform_action_once <= 1;
                    end
                       
                end
                
            //Delete/Pop
            else if ((((Button3==0)&&(Button2==0)&&(Button1==1)&&(Button0==0)) || (Delete_PopWEFlag > 0))&&(only_perform_action_once==0) ) 
            begin
                //Pops and discards the 8-bit value on top fo the stack
                Delete_PopWEFlag <= Delete_PopWEFlag +1;
                if (Delete_PopWEFlag == 0)
                begin
                    CS <= 1;
                    WE <= 1;
                    SPR <= SPR + 1; //Stack pointer goes up one (stack gets smaller) 
                    DAR <= DAR + 1;  
                    
                    ADDRESS_OUT <= DAR; 
                    data_out <= 0;  // need to reset top of the stack's value to zero
                end
                
                else if (Delete_PopWEFlag == 2)
                begin
                    WE <=0;
                    ADDRESS_OUT <= DAR;
                end
                
                else if (Delete_PopWEFlag == 4)
                begin
                    Delete_PopWEFlag <= 0;
                    DVR <= data_in;
                    only_perform_action_once<=1;
                end
                
            end
            
            
            //ADD
            else if ((((Button3==0)&&(Button2==1)&&(Button1==0)&&(Button0==1))||(startedAddFlag == 1)||(Add_WEFlag > 0)) && (only_perform_action_once==0))  
            begin
                //Pops the top two 8-bit values on the stack, adds them, and pushes the 8-bit value result back on the top of the stack, discarding the carry bit
                //need actual Add code here
                
                //read step: step 1: read in the value at address DAR and store it into a register. set WE = 0
                //write step: step 2: on next clock cycle, set value at DAR to zero and decrement SPR and DAR (and therefore update DVR). Set WE = 1;
                //read step: on next clock cycle, get value at new DAR and add it with previous register stored value. Set WE = 0;
                //write step: on next clock cycle, output register value at DAR address (DAR should be subtracted only once). Set WE = 1 
                
                //step 1: 
                startedAddFlag <= 1;
                if (ADD_currentlyOnFirstReadStep == 1)
                begin
                // NEED TO READ IN VALUES AT THIS TIME
                    WE <= 0; 
                    ADDRESS_OUT <= SPR + 1;
                    //StackStoreFIRST <= data_in; //storing data @ DAR address into first register to eventually add
                    ADD_currentlyOnFirstReadStep <= 0;
                    ADD_currentlyOnFirstWriteStep <= 1;
                    ADD_waitOneClockCycle1 <= 1;
                end
                
                else if (ADD_waitOneClockCycle1== 1)
                begin
                    ADD_waitOneClockCycle1 <= 0;
                    StackStoreFIRST <= data_in;
                end
                
                else if ( (ADD_currentlyOnFirstWriteStep == 1) && (ADD_waitOneClockCycle1 == 0)) //flags should be set from if statement above
                begin
                //need to write current data at SPR +1 address = 0 so stack gets cleared
                    WE <= 1;
                    ADDRESS_OUT <= SPR +1; // needs to change top of stack to ZERO
                    SPR <= SPR +1; //updates stack pointer to new value 
                    data_out <= 0; // reset current DAR address data to zero
                    ADD_currentlyOnFirstWriteStep <= 0;
                    ADD_currentlyOnSecondReadStep <= 1; 
                    ADD_waitOneClockCycle2 <= 1;
                end
                
                else if (ADD_waitOneClockCycle2 == 1)
                begin
                    ADD_waitOneClockCycle2 <= 0;
                end 
                
                else if ( (ADD_currentlyOnSecondReadStep == 1) && (ADD_waitOneClockCycle2 == 0))
                begin
                    //currently on second read step
                    WE <= 0;
                    ADDRESS_OUT <= SPR +1; // need to read in second value from top of stack 
                    ADD_currentlyOnSecondReadStep <= 0;
                    ADD_currentlyOnSecondWriteStep <= 1;
                    ADD_waitOneClockCycle3 <= 1;
                end
                
                else if ( (ADD_waitOneClockCycle3) == 1)
                begin
                    ADD_waitOneClockCycle3 <= 0;
                    additionRegister <= data_in + StackStoreFIRST; //stores second stack value. We add here because it takes one clock cycle to read in data_in once ADDRESS_OUT <= DAR
                end
                
                else if ( (ADD_currentlyOnSecondWriteStep == 1) && (ADD_waitOneClockCycle3 == 0))
                begin // on second and final write step
                    WE <= 1;
                    ADDRESS_OUT <= SPR +1; //now need to write
                    data_out <= additionRegister; //this addition performed in previous else if statement
                    ADD_currentlyOnSecondWriteStep <= 0;
                    Add_WEFlag <= Add_WEFlag + 1; 
                end
                
                else if (Add_WEFlag == 1) // these two last else if statements are just to update the DVR properly
                begin
                    WE <= 0;
                    ADDRESS_OUT <= DAR;
                    Add_WEFlag <= Add_WEFlag +1;
                end
                
                else if (Add_WEFlag == 2) 
                begin
                    Add_WEFlag <= 0;
                    DVR <= data_in;
                    startedAddFlag <= 0;
                    ADD_currentlyOnFirstReadStep <= 1;
                    only_perform_action_once <= 1;
                end
                
            end
            
            
            //Subtract
            else if ((((Button3==0)&&(Button2==1)&&(Button1==1)&&(Button0==0))||(startedSubtractFlag ==1)||(Subtract_WEFlag > 0))&&(only_perform_action_once==0)) 
            begin
                //pops the top two 8-bit values on the stack, subtracts them, and pushes the 8-bit result on the top of the stack, discarding the borrow bit (High minus Low)
                
                startedSubtractFlag <= 1;
                if (subtract_currentlyOnFirstReadStep == 1)
                begin
                // NEED TO READ IN VALUES AT THIS TIME
                    WE <= 0; 
                    ADDRESS_OUT <= SPR +1;
                    subtract_currentlyOnFirstReadStep <= 0;
                    subtract_currentlyOnFirstWriteStep <= 1;
                    subtract_waitOneClockCycle1 <= 1;
                end
                
                else if (subtract_waitOneClockCycle1== 1)
                begin
                    subtract_waitOneClockCycle1 <= 0;
                    subtract_StackStoreFIRST <= data_in;
                end
                
                else if ( (subtract_currentlyOnFirstWriteStep == 1) && (subtract_waitOneClockCycle1 == 0)) //flags should be set from if statement above
                begin
                //need to write current data at DAR address = 0 so stack gets cleared
                    WE <= 1;
                    ADDRESS_OUT <= SPR + 1;
                    SPR <= SPR +1; //updates stack pointer to new value 
                    data_out <= 0; // reset current DAR address data to zero
                    subtract_currentlyOnFirstWriteStep <= 0;
                    subtract_currentlyOnSecondReadStep <= 1; 
                    subtract_waitOneClockCycle2 <= 1;
                end
                
                else if (subtract_waitOneClockCycle2 == 1)
                begin
                    subtract_waitOneClockCycle2 <= 0;
                end 
                
                else if ( (subtract_currentlyOnSecondReadStep == 1) && (subtract_waitOneClockCycle2 == 0))
                begin
                    WE <= 0;
                    ADDRESS_OUT <= SPR+1;
                    subtract_currentlyOnSecondReadStep <= 0;
                    subtract_currentlyOnSecondWriteStep <= 1;
                    subtract_waitOneClockCycle3 <= 1;
                end
                
                else if ( (subtract_waitOneClockCycle3) == 1)
                begin
                    subtract_waitOneClockCycle3 <= 0;
                    subtractionRegister <= data_in - subtract_StackStoreFIRST; //stores second stack value. We add here because it takes one clock cycle to read in data_in once ADDRESS_OUT <= DAR
                end
                
                else if ( (subtract_currentlyOnSecondWriteStep == 1) && (subtract_waitOneClockCycle3 == 0))
                begin
                    WE <= 1;
                    ADDRESS_OUT <= SPR +1;
                    data_out <= subtractionRegister; //this addition performed in previous else if statement
                    subtract_currentlyOnSecondWriteStep <= 0;
                    Subtract_WEFlag <= Subtract_WEFlag + 1;
                end
                
                else if (Subtract_WEFlag == 1) // below here is just to update DVR
                begin
                    WE <= 0;
                    ADDRESS_OUT <= DAR;
                    Subtract_WEFlag <= Subtract_WEFlag +1;
                end
                
                 else if (Subtract_WEFlag == 2)
                begin
                    Subtract_WEFlag <= 0;
                    DVR <= data_in;
                    startedSubtractFlag <= 0;
                    subtract_currentlyOnFirstReadStep <= 1;
                    only_perform_action_once <= 1;
                end
            end
            
            
            // TOP
            else if (((Button3==1)&&(Button2==0)&&(Button1==0)&&(Button0==1) || (Top_WEFlag > 0)) && (only_perform_action_once==0)) 
            begin
                //sets the DAR to the top of the stack (SPR+1; will cause DVR to update)
                //need actual TOP code here
                Top_WEFlag <= Top_WEFlag +1;
                if (Top_WEFlag == 0)
                begin
                    DAR <= SPR +1; 
                end
                
                else if (Top_WEFlag == 2)
                begin
                    WE <=0;
                    ADDRESS_OUT <= DAR;
                end
                
                else if (Top_WEFlag == 4)
                begin
                    Top_WEFlag <= 0;
                    DVR <= data_in;
                    only_perform_action_once <= 1;
                end
                
            end
            
            
            //DEC ADDR
            else if ((((Button3==1)&&(Button2==1)&&(Button1==1)&&(Button0==0)) || (Dec_WEFlag > 0)) && (only_perform_action_once==0))
            begin
                //Decrements the DAR by 1
                Dec_WEFlag <= Dec_WEFlag +1;
                if (Dec_WEFlag == 0)
                begin
                    DAR <= DAR -1;
                end
                
                else if (Dec_WEFlag == 2)
                begin
                    WE <=0;
                    ADDRESS_OUT <= DAR;
                end
                
                else if (Dec_WEFlag == 4)
                begin
                    Dec_WEFlag <= 0;
                    DVR <= data_in;
                    only_perform_action_once <= 1;
                end
                
            end
            
            
            //INC ADDR
            else if ((((Button3==1)&&(Button2==1)&&(Button1==0)&&(Button0==1)) || (Inc_WEFlag > 0))&& (only_perform_action_once==0)) // INC ADDR
            begin
                //increments the DAR by 1                
                Inc_WEFlag <= Inc_WEFlag +1;
                if (Inc_WEFlag == 0)
                begin
                    DAR <= DAR + 1;
                end
                
                else if (Inc_WEFlag == 2)
                begin
                    WE <=0;
                    ADDRESS_OUT <= DAR;
                end
                
                else if (Inc_WEFlag == 4)
                begin
                    Inc_WEFlag <= 0;
                    DVR <= data_in;
                    only_perform_action_once <= 1;
                end
                
            end          
                      
        end
              
endmodule
