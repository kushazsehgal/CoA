
`timescale 1ns / 1ps

// Testbench for shifter module
module Shifter_tb;

	// Inputs 
    reg  direction, a_or_l;
    reg [31:0] shamt;
    reg [31:0] in;

    // Output
    wire [31:0] out;
    
    // Instantiate the unit under test
    shifter S1(.in(in), .shamt(shamt), .direction(direction), .out(out), .a_or_l(a_or_l));
    
    initial begin

        // Monitor the changes
        $monitor("time = %0d, shamt = %b, direction = %b, in = %b, out = %b, a_or_l = %b", $time, shamt, direction, in, out, a_or_l);
        
        // Specify input, directionection and shift amount
        in = 4567; direction = 1'b1; shamt = 4; a_or_l = 0;

        // Change the shifting directionection
        #5 direction = 1'b0; a_or_l = 1'b0;

        #5 direction = 1'b0; a_or_l = 1'b1;

        #5 direction = 1'b1; a_or_l = 1'b0; in = -64;

        #5 direction = 1'b0; a_or_l = 1'b0;

        #5 direction = 1'b0; a_or_l = 1'b1;
        
        #5 $finish;

    end
      
endmodule