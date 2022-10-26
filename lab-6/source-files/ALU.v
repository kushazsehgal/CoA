`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Implementation of ALU
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////


module ALU (
    input signed [31:0] a, 
    input signed [31:0] b, 
    input ALUsel, 
    input [4:0] ALUop, 
    output reg carry, 
    output reg zero, 
    output reg sign, 
    output reg [31:0] result
);

endmodule
