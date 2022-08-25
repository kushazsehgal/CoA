`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 3 - CS31001
// Testing 64bit Ripple Carry Adder
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module RCA_64bit_Test;

	// Inputs
	reg [63:0] a;
	reg [63:0] b;
	reg c;

	// Outputs
	wire [63:0] S;
	wire C;

	// Instantiate the Unit Under Test (UUT)
	RCA_64bit uut (
		.a(a), 
		.b(b), 
		.c(c), 
		.S(S), 
		.C(C)
	);

	initial begin
		$monitor ("a = %d, b = %d, c = %d, S = %d, C = %d", a, b, c, S, C);
		// Initialize Inputs
		// 2^64 = 18446744073709551616

		a = 64'd18446744073709551615; b = 64'd1; c = 0; // S = 0 C = 1
		#100;
		a = 64'd18446744073700000000; b = 64'd9551615; c = 0; // S = 18446744073709551615 C = 0
		#100;
		a = 64'd435984375334; b = 64'd342589435; c = 0; // S = 436326964769 C = 0
		#100;
		a = 64'd456254255436; b = 64'd1844673951116699725; c = 0; // S = 1844674407370955161 C = 0
		#100;
		a = 64'd231; b = 64'd25; c = 0; // S = 256 C = 0
		#100;
		a = 64'd231; b = 64'd0; c = 1; // S = 232 C = 0
		#100;
	end
      
endmodule

