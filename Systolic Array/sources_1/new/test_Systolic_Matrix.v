`timescale 1ns / 1ps

module test_Systolic_Matrix(

    input CLK,
    input RESET,
    input START,
    input [7:0] a00,a01,a02,a10,a11,a12,a20,a21,a22,
    input [7:0] b00,b01,b02,b10,b11,b12,b20,b21,b22,
     
    output [7:0] M1_out, M2_out, M3_out, M4_out, M5_out, M6_out, M7_out, M8_out, M9_out,
    output DONE

    ); 
    
//BELOW: regs/wires needed to get signals out of each square module 
reg [7:0] C00currentAxy_in = 0;
reg [7:0] C00currentBxy_in = 0;
wire [7:0] C00currentAxy_out;
wire [7:0] C00currentBxy_out;
wire C00_doneMultiplying;
wire [7:0] C00Output;

reg [7:0] C01currentBxy_in = 0;
wire [7:0] C01currentAxy_out; 
wire [7:0] C01currentBxy_out;
wire C01_doneMultiplying;
wire [7:0] C01Output;

reg [7:0] C02currentBxy_in=0;
wire [7:0] C02currentAxy_out;
wire [7:0] C02currentBxy_out;
wire C02_doneMultiplying;
wire [7:0] C02Output;

reg [7:0] C10currentAxy_in = 0;
reg [7:0] C10currentBxy_in = 0;
wire [7:0] C10currentAxy_out;
wire [7:0] C10currentBxy_out;
wire C10_doneMultiplying;
wire [7:0] C10Output;

wire [7:0]C11currentAxy_out;
wire [7:0]C11currentBxy_out;
wire C11_doneMultiplying;
wire[7:0] C11Output;

wire [7:0] C12currentAxy_out;
wire [7:0] C12currentBxy_out;
wire C12_doneMultiplying;
wire [7:0]C12Output;

reg [7:0] C20currentAxy_in=0;
wire [7:0]C20currentAxy_out;
wire [7:0]C20currentBxy_out;
wire C20_doneMultiplying;
wire[7:0] C20Output;

wire[7:0]C21currentAxy_out;
wire[7:0]C21currentBxy_out;
wire C21_doneMultiplying;
wire[7:0] C21Output;

wire[7:0]C22currentAxy_out;
wire[7:0]C22currentBxy_out;
wire C22_doneMultiplying;
wire[7:0] C22Output;

//ABOVE: regs/wires needed to get signals out of each square module 

assign M1_out = C00Output; 
assign M2_out = C01Output;
assign M3_out = C02Output;
assign M4_out = C10Output;
assign M5_out = C11Output;
assign M6_out = C12Output;
assign M7_out = C20Output;
assign M8_out = C21Output;
assign M9_out = C22Output;

reg C00NextOperation = 0;
reg C01NextOperation = 0;
reg C02NextOperation = 0;
reg C10NextOperation = 0;
reg C11NextOperation = 0;
reg C12NextOperation = 0;
reg C20NextOperation = 0;
reg C21NextOperation = 0;
reg C22NextOperation = 0;

SquareModule C00(CLK,RESET,C00currentAxy_in, C00currentBxy_in, C00NextOperation,C00currentAxy_out,C00currentBxy_out,
C00_doneMultiplying,C00Output);

SquareModule C01(CLK,RESET,C00currentAxy_out,C01currentBxy_in,C01NextOperation,C01currentAxy_out,C01currentBxy_out,
C01_doneMultiplying,C01Output);

SquareModule C02(CLK,RESET,C01currentAxy_out,C02currentBxy_in,C02NextOperation,C02currentAxy_out,C02currentBxy_out,
C02_doneMultiplying,C02Output);

SquareModule C10 (CLK,RESET,C10currentAxy_in,C00currentBxy_out,C10NextOperation,C10currentAxy_out,C10currentBxy_out,
C10_doneMultiplying,C10Output);

SquareModule C11(CLK,RESET,C10currentAxy_out,C01currentBxy_out,C11NextOperation,C11currentAxy_out,C11currentBxy_out,
C11_doneMultiplying,C11Output);

SquareModule C12(CLK,RESET,C11currentAxy_out,C02currentBxy_out,C12NextOperation,C12currentAxy_out,C12currentBxy_out,
C12_doneMultiplying,C12Output);

SquareModule C20(CLK,RESET,C20currentAxy_in,C10currentBxy_out,C20NextOperation,C20currentAxy_out,C20currentBxy_out,
C20_doneMultiplying,C20Output);

SquareModule C21(CLK,RESET,C20currentAxy_out,C11currentBxy_out,C21NextOperation,C21currentAxy_out,C21currentBxy_out,
C21_doneMultiplying,C21Output);

SquareModule C22(CLK,RESET,C21currentAxy_out,C12currentBxy_out,C22NextOperation,C22currentAxy_out,C22currentBxy_out,
C22_doneMultiplying,C22Output);

reg StartExecutionFlag = 0;
reg [3:0] clockCycleCount = 0;
always@(posedge CLK) // I believe the only thing this always@ block will do is provide signals and inputs into the square modules and time the inputs correctly
begin
    
    if (RESET == 1)
    begin
        //reset every output, register and flag = 0
        StartExecutionFlag <=0;
        clockCycleCount <= 0;
        C00NextOperation <= 0;
        C01NextOperation <= 0;
        C02NextOperation <= 0;
        C10NextOperation <= 0;
        C11NextOperation <= 0;
        C12NextOperation <=0;
        C20NextOperation <= 0;
        C21NextOperation <=0;
        C22NextOperation <=0;
        
        C20currentAxy_in <=0;
        C10currentAxy_in <= 0;
        C10currentBxy_in <= 0;
        C02currentBxy_in <=0;
        C01currentBxy_in <= 0;
        C00currentAxy_in <= 0;
        C00currentBxy_in <= 0;
    end
    
    //all the below statement should do is delay the inputs into the five outer square modules depending on what position it is in
    //the square modules take care of sending its input to the next square module
    else if ((START == 1) || (StartExecutionFlag == 1)) // time to do it
    begin
        //  this is C00 module (top left)
        StartExecutionFlag <= 1; // doesn't finish operations until matrix fully complete
        
        if ( clockCycleCount == 0 ) //first diagonal
        begin 
            C00NextOperation <= 1;
            C00currentAxy_in <= a00;
            C00currentBxy_in <= b00;
            
            clockCycleCount <= clockCycleCount +1;
        end
        
        else if ( clockCycleCount == 1 ) //second diagonal
        begin
            //Need to input second Axy_in and Bxy_in into C00, and need to input first Bxy_in and Axy_in into C01 and C10
            C00NextOperation <= 1; // should stay ==1 for three clock cycles
            C00currentAxy_in <= a01;
            C00currentBxy_in <= b10;
            
            //remember to add logic to put axy_in and bxy_in into C01 and C10 module, 
            //as well as set their 'perform next operation' input == 1 to start executing their code
            C01NextOperation <= 1;
            C01currentBxy_in <= b01;
            
            C10NextOperation <= 1;
            C10currentAxy_in <= a10;
            
            clockCycleCount <= clockCycleCount +1;
            
        end
        
        else if ( clockCycleCount == 2 ) // third diagonal
        begin
            C00NextOperation <= 1; // should stay ==1 for three clock cycles
            C00currentAxy_in <= a02;
            C00currentBxy_in <= b20; // 
            //remember to add logic to put axy_in and bxy_in into needed Cxy modules, 
            //as well as set their 'perform next operation' input == 1 to start executing their code
            C01NextOperation <= 1; // 
            C01currentBxy_in <= b11;
            
            C02NextOperation <= 1;
            C02currentBxy_in <= b02;
            
            C10NextOperation <= 1;
            C10currentAxy_in <= a11;
            
            C11NextOperation <=1;
            
            C20NextOperation <= 1;
            C20currentAxy_in <= a20;
            
            clockCycleCount <= clockCycleCount +1;
        end
        
        else if ( clockCycleCount == 3) // fourth diagonal
        begin
            C01NextOperation <= 1; //should be last time c01 needs to execute
            C01currentBxy_in <= b21;
            
            C02NextOperation <= 1;
            C02currentBxy_in <= b12;
            
            C10NextOperation <= 1; // should be last time c10 needs to execute
            C10currentAxy_in <= a12;
            
            C11NextOperation <=1;
            
            C20NextOperation <= 1;
            C20currentAxy_in <= a21;
            
            C12NextOperation <= 1;
            
            C21NextOperation <= 1;
            
            
            clockCycleCount <= clockCycleCount +1;
        end
        
        else if ( clockCycleCount == 4) // fifth diagonal
        begin            
            C02NextOperation <= 1;
            C02currentBxy_in <= b22;
            
            C11NextOperation <=1;
            
            C12NextOperation <= 1;
            
            C20NextOperation <= 1;
            C20currentAxy_in <= a22;
            
            C21NextOperation <= 1;
            
            C22NextOperation <=1;
            
        end
        
        else if ( clockCycleCount == 5 )
        begin
            C12NextOperation <= 1;
            
            C21NextOperation <= 1;
            
            C22NextOperation <= 1;
        end
        
        else if ( clockCycleCount == 6 )
        begin
            C22NextOperation <= 1;
            
        end
        
    end
    
end    
    
endmodule
