`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 3 - CS31001
// Testing 4 bit Look Ahead Carry Adder
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module CLA_4bit_Test;

	// Inputs
	reg [3:0] a;
	reg [3:0] b;
	reg c;

	// Outputs
	wire [3:0] S;
	wire C;

	// Instantiate the Unit Under Test (UUT)
	CLA_4bit uut (
		.a(a), 
		.b(b), 
		.c(c), 
		.S(S), 
		.C(C)
	);

	initial begin
		$monitor ("a = %d, b = %d, c = %d, S = %d, C = %d", a, b, c, S, C);
		// Initialize Inputs

		a = 4'd15; b = 4'd0; c = 0; // S = 15 C = 0
		#100;
		a = 4'd0; b = 4'd15; c = 1; // S = 0 C = 1 
		#100;
		a = 4'd8; b = 4'd7; c = 0; // S = 15 C = 0
		#100;
		a = 4'd2; b = 4'd3; c = 1; // S = 6 C = 0
		#100;
		a = 4'd1; b = 4'd7; c = 0; // S = 8 C = 0
		#100;
		a = 4'd1; b = 4'd3; c = 1; // S = 5 C = 0
		#100;

	end
      
endmodule

