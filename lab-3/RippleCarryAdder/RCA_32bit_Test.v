`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 3 - CS31001
// Testing 32bit Ripple Carry Adder
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module RCA_32bit_Test;

	// Inputs
	reg [31:0] a;
	reg [31:0] b;
	reg c;

	// Outputs
	wire [31:0] S;
	wire C;

	// Instantiate the Unit Under Test (UUT)
	RCA_32bit uut (
		.a(a), 
		.b(b), 
		.c(c), 
		.S(S), 
		.C(C)
	);

	initial begin
		$monitor ("a = %d, b = %d, c = %d, S = %d, C = %d", a, b, c, S, C);
		// Initialize Inputs
		// 2^32 = 4294967296
		a = 32'd4294000000; b = 32'd967296; c = 0; // S = 0 C = 1
		#100;
		a = 32'd4294000000; b = 32'd967295; c = 0; // S = 4294967295 C = 0
		#100;
		a = 32'd42400000; b = 32'd429; c = 1; // S = 42400430 C = 0
		#100;
		a = 32'd231; b = 32'd2445345; c = 1; // S = 2445577 C = 0
		#100;
		a = 32'd4294967295; b = 32'd1; c = 1; // S = 1 C = 1
		#100;
		a = 32'd231; b = 32'd25; c = 1; // S = 257 C = 0
		#100;
	end
      
endmodule

