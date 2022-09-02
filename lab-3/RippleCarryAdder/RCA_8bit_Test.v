`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 3 - CS31001
// Testing 8 bit Ripple Carry Adder
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module RCA_8bit_Test;


	// Inputs
	reg [7:0] a;
	reg [7:0] b;
	reg c;
	// Outputs
	wire [7:0] S;
	wire C;

	// Instantiate the Unit Under Test (UUT)
	RCA_8bit uut (
		.a(a),
		.b(b),
		.c(c),
		.S(S),
		.C(C)
	);
	

	initial begin
		$monitor ("a = %d, b = %d, c = %d, S = %d, C = %d", a, b, c, S, C);
		// Initialize Inputs

		a = 8'd153; b = 8'd64; c = 0; // S = 217 C = 0
		#100;
		a = 8'd153; b = 8'd64; c = 1; // S = 218
		#100;
		a = 8'd231; b = 8'd24; c = 0; // S = 255 C = 0
		#100;
		a = 8'd231; b = 8'd24; c = 1; // S = 0 C = 1
		#100;
		a = 8'd231; b = 8'd25; c = 0; // S = 0 C = 1
		#100;
		a = 8'd231; b = 8'd25; c = 1; // S = 1 C = 1
		#100;
	end
      
endmodule

