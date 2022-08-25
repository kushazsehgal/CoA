`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:08:36 08/25/2022
// Design Name:   HalfAdder
// Module Name:   C:/Users/Jay Kumar Thakur/RCA/HalfAdderTest.v
// Project Name:  RCA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: HalfAdder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module HalfAdderTest;

	// Inputs
	reg a;
	reg b;

	// Outputs
	wire S;
	wire C;

	// Instantiate the Unit Under Test (UUT)
	HalfAdder uut (
		.a(a), 
		.b(b), 
		.S(S), 
		.C(C)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
	end
	always #2 a = ~a;
	always #3 b = ~b;
	initial $monitor($time, "a=%b, b=%b", a, b);
	initial #50 $finish;
      
endmodule

