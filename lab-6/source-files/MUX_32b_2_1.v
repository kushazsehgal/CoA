`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// A 2x1 mux with 32-bit output
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module MUX_32b_2_1 (
    input [31:0] a0, 
    input [31:0] a1, 
    input sel, 
    output [31:0] out
);
    
    assign out = (sel) ? a1 : a0;

endmodule