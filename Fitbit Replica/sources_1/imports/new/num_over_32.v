`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Created by Daniel Krueger and Ryan Arnold
//////////////////////////////////////////////////////////////////////////////////

`define totalnum 10
`define step 32

module num_over_32(
    input pulse //indicates an input step or pulse
    ,input secondclk //clock with a period of 1second
    ,input reset
    ,output reg [13:0] overnum = 0
);

//count up as long as second clock is not turned over
reg [5:0] ttholder = 0;
reg [5:0] ttholder1 = 0;
reg clearflag = 1'b0;
reg [3:0] totalnum = 0;

    always @(posedge pulse)
    begin
        if(pulse && ~clearflag && (ttholder < 33))
        begin
            ttholder1 <= 0;//ttholder 1 clears
            ttholder <= ttholder + 1; //ttholder1 increments
        end
        if(pulse && clearflag && (ttholder1<33))
        begin
            ttholder <= 0;//ttholder clears
            ttholder1 <= ttholder1 + 1; //ttholder1 increments
        end
        if(reset)
        begin
            ttholder <= 0;//on reset everything becomes 0
            ttholder1 <= 0;
        end
end

    always @(negedge secondclk)
    begin
        //check for more than 32 steps
        if(((ttholder >= `step)||(ttholder1 >= `step)) && ((totalnum < `totalnum) || (totalnum == 15)) && (overnum < (`totalnum - 1)))
        begin
            totalnum <= totalnum + 1;
            overnum <= overnum + 1;
            clearflag <= ~clearflag;

        end
        //if not 32 steps then increase totalnum and keep going
        else if ((ttholder < `step) && (ttholder1 < `step) && ((totalnum < `totalnum)))
        begin
            totalnum <= totalnum + 1;
            clearflag <= ~clearflag;
        end
        //reset if all fails
        if(reset)
        begin
            overnum <= 0;
            totalnum <= 0;
        end
end

endmodule
