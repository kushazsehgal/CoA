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
    input [5:0] ALUop, 
    output reg carry, 
    output reg zero, 
    output reg sign, 
    output reg [31:0] result
);

    wire carry_buffer;
    wire [31:0] not_b,input1,input2,add_output,xor_output,and_output,shift_output;
    assign not_b = ~b;
    MUX_32b_2_1 mux1(.a0(a),.a1(1),.sel(ALUsel),.out(input1));
    MUX_32b_2_1 mux2(.a0(b),.a1(not_b),.sel(ALUsel),.out(input2));

    assign and_output = input1 & input2;
    assign xor_output = input1 ^ input2;

    Adder_32_bit add(.a(input1),.b(input2),.c_in(0),.sum(add_output),.c_out(carry_buffer));
    


endmodule
