`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// A 2x1 mux with 1-bit output
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module MUX_1b_2_1 (
    input a0, 
    input a1, 
    input sel, 
    output out
);
    
    assign out = (sel) ? a1 : a0;

endmodule