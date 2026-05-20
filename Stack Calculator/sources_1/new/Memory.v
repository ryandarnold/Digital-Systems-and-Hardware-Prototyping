`timescale 1ns / 1ps



module Memory(
    
    input CLK, input CS, input WE, input [6:0] ADDRESS_memory, input [7:0] data_in, 
    output reg [7:0] data_out
    );

reg[7:0] RAM[0:127];
reg [7:0] DATA_OUT_REG = 0;

always @ (negedge CLK)
    begin
        if((WE == 1) && (CS == 1))
        begin
            RAM[ADDRESS_memory] <= data_in[7:0];
        end
        
        data_out <= RAM[ADDRESS_memory];
    end
    
endmodule
