
`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Testbench for 16-bit carry look-ahead adder module using the look-ahead carry unit
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module CLA_16bit_with_LCU_tb;

    // Inputs
    reg [15:0] A = 16'd0, B = 16'd0;
    reg c_in = 1'b0;

    // Outputs
    wire [15:0] sum;
    wire c_out;

    // Instantiate the unit under test
    CLA_16_bit_with_LCU CLA(.a(A), .b(B), .c(c_in), .S(sum), .C(c_out));

    initial begin
        // Monitor the changes
        $monitor("A = %d, B = %d, c_in = %b, sum = %d, c_out = %b, block propagate = %b, block generate = %b", A, B, c_in, sum, c_out, P, G);
        
        // Stimulus to verify the working of the 16-bit carry look-ahead adder
        #5 A = 16'd414; B = 16'd1036;
        #5 A = 16'd5045; B = 16'd45042;
        #5 A = 16'd32768; B = 16'd32768;
        #5 A = 16'd65535; B = 16'd65535;
        #5 $finish;
    end
endmodule