`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 09/24/2022 12:19:36 PM
// Module Name: Top
//////////////////////////////////////////////////////////////////////////////////


module Top(
    input CLK, input RESET, input START, input [1:0] MODE,
    
    output SI, output mainTOPAnode0, output mainTOPAnode1, output mainTOPAnode2, output mainTOPAnode3, output [6:0] mainTOPSevenSeg
    );
    
    wire [13:0] totalStepsToSevenSeg;
    wire [22:0] actualTotalSteps;
    wire [13:0] mileCounter; 
    wire PULSE;
    
    wire secondclk;
    wire twosecondclk;
    wire [13:0] overnum;
    wire [13:0] highatime; 
    Pulse_Generator PG1 (CLK, MODE, START, RESET, PULSE );
    
    totalStepCount TS1 (PULSE, RESET, totalStepsToSevenSeg, actualTotalSteps, SI );
    distanceCovered DC1 (CLK,actualTotalSteps,RESET, mileCounter );
    
    oneHZperiodclock CLK1 (CLK,secondclk,twosecondclk );
    num_over_32 OVER32 (PULSE, secondclk, RESET,overnum ); // overnum keeps track of number of seconds over 32 for first 9 seconds
    high_activity_part4 HA1 (PULSE,secondclk,RESET,highatime);
    outputSelector OS1 (CLK, RESET,totalStepsToSevenSeg,mileCounter,overnum,highatime,mainTOPAnode0,mainTOPAnode1,mainTOPAnode2,mainTOPAnode3,mainTOPSevenSeg );
    
    
endmodule
