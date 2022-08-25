`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:27:26 08/25/2022
// Design Name:   FullAdder
// Module Name:   C:/Users/Jay Kumar Thakur/RCA/FullAdderTest.v
// Project Name:  RCA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FullAdder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FullAdderTest;

	// Inputs
	reg a;
	reg b;
	reg c;

	// Outputs
	wire S;
	wire C;

	// Instantiate the Unit Under Test (UUT)
	FullAdder uut (
		.a(a), 
		.b(b), 
		.c(c), 
		.S(S), 
		.C(C)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		c = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
   always #2 a = ~a;
	always #3 b = ~b;
	always #4 c = ~c;
	initial $monitor($time, "a=%b, b=%b", a, b);
	initial #50 $finish;
endmodule

