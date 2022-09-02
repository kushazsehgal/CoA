`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 3 - CS31001
// Testing 16 bit ripple Carry Look Ahead Adder
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module LCA_16bit_ripple_Test;

	// Inputs
	reg [15:0] a;
	reg [15:0] b;
	reg c;

	// Outputs
	wire [15:0] S;
	wire C;

	// Instantiate the Unit Under Test (UUT)
	LCA_16bit_ripple uut (
		.a(a), 
		.b(b), 
		.c(c), 
		.S(S), 
		.C(C)
	);

	initial begin
		$monitor ("a = %d, b = %d, c = %d, S = %d, C = %d", a, b, c, S, C);
		// Initialize Inputs

		a = 16'd65500; b = 16'd36; c = 0; // S = 0 C = 1
		#100;
		a = 16'd65530; b = 16'd6; c = 1; // S = 1 C = 1
		#100;
		a = 16'd231; b = 16'd25; c = 0; // S = 256 C = 0
		#100;
		a = 16'd21150; b = 16'd14256; c = 1; // S = 35407 C = 0
		#100;
		a = 16'd231; b = 16'd0; c = 0; // S = 231 C = 0
		#100;
		a = 16'd231; b = 16'd25; c = 1; // S = 257 C = 0
		#100;

	end
      
endmodule

