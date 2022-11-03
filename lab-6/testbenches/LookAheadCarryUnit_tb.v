`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Testbench for Look-ahead carry unit module
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module LookAheadCarryUnit_tb;

    // Inputs
    reg [3:0] p = 4'b0000, g = 4'b0000;
    reg c_in = 1'b0;

    // Outputs
    wire [3:0] carry;

    // Instantiate the unit under test
    LookAheadCarryUnit LCU(.p(p), .g(g), .c(c_in), .C(carry));

    initial begin
        // Monitor the changes
        $monitor("input propagates = %b, input generates = %b, c_in = %b, carry(s) = %b, c_out = %b, LCU propagate = %b, LCU generate = %b", p, g, c_in, carry, c_out, P, G);
        
        // Stimulus to verify the working of the look-ahead carry unit
        #5 p = 4'b1111; g = 4'b0110;
        #5 p = 4'b1101; g = 4'b0010;
        #5 p = 4'b1100; g = 4'b1001;
        #5 $finish;
    end
endmodule