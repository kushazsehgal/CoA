
`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Testbench for the jump control module
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module Jump_Control_tb;
    // Inputs
    reg sign, carry, zero;
    reg [5:0] OP_CODE;
    
    // Outputs
    wire validJump;

    // Instantiate the unit under test
    Jump_Control JC (
        .OP_CODE(OP_CODE),
        .sign(sign),
        .carry(carry),
        .zero(zero),
        .validJump(validJump)
    );

    initial begin
        // Monitor the changes
        $monitor("OP_CODE = %b, zero = %b, sign = %b, carry = %b, validJump = %b", OP_CODE, zero, sign, carry, validJump);

        // Provide the stimulus
        OP_CODE = 6'b000111; zero = 1'b0; sign = 1'b1; carry = 1'b0;
        #5 OP_CODE = 6'b000111; zero = 1'b0; sign = 1'b0; carry = 1'b0;
        #5 OP_CODE = 6'b001000; zero = 1'b1; sign = 1'b0; carry = 1'b0;
        #5 OP_CODE = 6'b001010;
        #5 OP_CODE = 6'b001101; zero = 1'b0; sign = 1'b0; carry = 1'b1;
        #5 OP_CODE = 6'b001101; zero = 1'b0; sign = 1'b0; carry = 1'b1;
        #5 OP_CODE = 6'b001110; zero = 1'b0; sign = 1'b0; carry = 1'b1;

        #5 $finish;
    end
endmodule