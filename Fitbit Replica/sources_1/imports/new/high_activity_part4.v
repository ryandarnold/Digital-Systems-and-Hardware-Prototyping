`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Created by Daniel Krueger and Ryan Arnold
//////////////////////////////////////////////////////////////////////////////////

//simulation constants
//`define higha 64 //number of pulses needed for high activity
//`define limit 6 //number of seconds needed for high activity

`define higha 64//64 pulses needed to count as high activity

//Please try with a lower limit if this doesn't work
`define limit 60 //60 seconds needed to add time onto high activity


module high_activity_part4(
    input pulse
    ,input secondclk
    ,input reset
    ,output reg [13:0] highatime = 0
);

    reg [15:0] stepcnt = 0;
    reg [15:0] stepcnt1 = 0;
    reg clearflag = 0;

    reg [13:0] highaseconds = 0;

    always @ (posedge pulse)
    begin
    //reset both counters to 0 on reset
        if(reset)
        begin
            stepcnt = 0;
            stepcnt1 = 0;
        end
        if((pulse && (stepcnt < `higha) && ~clearflag) && ~reset)
        begin
            stepcnt = stepcnt+1;
            stepcnt1 = 0;
        end

        else if((~pulse && ~clearflag) && ~reset)
        begin
            stepcnt1 = 0;
        end

        else if ((pulse && (stepcnt1 < `higha) && clearflag) && ~reset)
        begin
            stepcnt1 = stepcnt1 + 1;
            stepcnt = 0;
        end
        else if (~pulse && clearflag && ~reset)
        begin
            stepcnt = 0;
        end

    end


    always @(posedge secondclk)
    begin
        if(reset)
        begin
            highaseconds <= 0;
            highatime <= 0;
        end

        if (((stepcnt >= (`higha))||(stepcnt1 >= (`higha)))&&~reset)
        begin
            highaseconds <= highaseconds + 1;
            clearflag <= ~clearflag;
        end
        else if(((stepcnt < (`higha))||(stepcnt1 < (`higha)))&&~reset)
        begin
            highaseconds <= 0;
            clearflag <= ~clearflag;
        end
        else
        clearflag <= ~clearflag;

        //adjust highatime
        if(((highaseconds == (`limit-1)) && ((stepcnt >= (`higha))||(stepcnt1 >= (`higha)))) && ~reset)
        begin
            highatime <= highatime + highaseconds + 1;
        end
        else if(((highaseconds > (`limit-1))&&((stepcnt >= (`higha))||(stepcnt1 >= (`higha)))) && ~reset)
        begin
            highatime <= highatime+1;//grab the value that highaseconds will become
        end


end
endmodule
