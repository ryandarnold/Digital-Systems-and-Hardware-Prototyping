`timescale 1ns / 1ps

module Top(

    input CLK, input ButtonUp_unfiltered, input ButtonDown_unfiltered, input ButtonLeft_unfiltered, input ButtonRight_unfiltered,
    input [7:0] SWITCH, 
    
    output [7:0] LED, output mainAnode0, output mainAnode1, output mainAnode2, output mainAnode3, output [6:0] mainTOPsevenSeg 
);
    
wire cs;
wire we;
wire[6:0] addr;
wire[7:0] data_out_mem;
wire[7:0] data_out_ctrl;
wire[7:0] data_bus;


assign data_bus = (we) ? data_out_ctrl : 8'bzzzzzzzz; // 1st driver of the data bus -- tri state switches
                     // function of we and data_out_ctrl
                     
assign data_bus = (~we) ? data_out_mem : 8'bzzzzzzzz; // 2nd driver of the data bus -- tri state switches
                     // function of we and data_out_mem
    
    
    Controller ctrl(CLK, cs, we, addr, data_bus, data_out_ctrl, ButtonUp_unfiltered,ButtonDown_unfiltered,ButtonLeft_unfiltered,ButtonRight_unfiltered,
     SWITCH,LED, mainTOPsevenSeg, mainAnode0, mainAnode1, mainAnode2, mainAnode3);
    
    Memory mem(CLK, cs, we, addr, data_bus, data_out_mem); 

endmodule




