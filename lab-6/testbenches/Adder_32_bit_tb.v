
`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Testbench for the 32-bit ripple carry adder module
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////


module Adder_32_bit_tb;

    // Inputs
    reg [31:0] A = 32'd0, B = 32'd0;
    reg c_in = 1'b0;

    // Outputs
    wire [31:0] sum;
    wire c_out;

    // Instantiate the unit under test
    Adder_32_bit UUT(.a(A), .b(B), .c_in(c_in), .sum(sum), .c_out(c_out));

    initial begin
        // Monitor the changes
        $monitor("A = %d, B = %d, c_in = %b, sum = %d, c_out = %b", A, B, c_in, sum, c_out);
        
        // Stimulus to verify the working of the 32-bit adder
        #5 A = 32'd1024; B = 32'd4096;
        #5 A = 32'd34343434; B = 32'd8123659;
        #5 A = 32'd4294967295; B = 32'd4294967295;
        #5 $finish;
    end
endmodule