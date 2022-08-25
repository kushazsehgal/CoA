`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 3 - CS31001
// Testing Full Adder
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

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

