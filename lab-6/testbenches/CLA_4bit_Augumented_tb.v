`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Testbench for 4-bit carry look-ahead adder module with augmentation to compute next level block generate and propagate
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module CLA_4bit_Augumented_tb;

    // Inputs
    reg [3:0] A = 4'b0000, B = 4'b0000;
    reg c_in = 1'b0;

    // Outputs
    wire [3:0] sum;
    wire c_out, P, G;

    // Instantiate the unit under test
    CLAl_4bit_Augumented CLA(.a(A), .b(B), .c(c_in), .S(sum), .P(P), .G(G));

    initial begin
        // Monitor the changes
        $monitor("A = %b, B = %b, c_in = %b, sum = %b, c_out = %b, block propagate = %b, block generate = %b", A, B, c_in, sum, c_out, P, G);
        
        // Stimulus to verify the working of the 4-bit carry look-ahead adder
        #5 A = 4'b0100; B = 4'b1001;
        #5 A = 4'b1001; B = 4'b1010;
        #5 A = 4'b1100; B = 4'b0011;
        #5 A = 4'b1111; B = 4'b1111;
        #5 $finish;
    end
endmodule