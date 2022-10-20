`timescale 1ns/1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Implementing 32 bit Adder using 2 16-bit CLAs
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////
module Adder_32_bit(
    input [31:0]a,
    input [31:0]b,
    input c_in,
    output [31:0]sum
    output c_out
);
    wire c_out_temp;

    CLA_16bit_withLCU CLA1(.a(a[15:0]),.b(b[15:0]),.c(c_in),.s(sum[15:0]),.C(c_out_temp));
    CLA_16bit_withLCU CLA2(.a(a[31:16]),.b(b[31:16]),.c(c_out_temp),.s(sum[31:16]),.C(c_out));

endmodule