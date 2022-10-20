`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// A 3x1 mux with 5-bit output
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module MUX_5b_3_1 (
    input [4:0] a0, 
    input [4:0] a1, 
    input [4:0] a2, 
    input [1:0] sel, 
    output reg [4:0] out
);

    always @(*) begin
        case (sel)
            2'b00 : out = a0;
            2'b01 : out = a1;
            2'b10 : out = a2;
            default : out = a2;
        endcase
    end
    
endmodule