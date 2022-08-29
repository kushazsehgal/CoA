`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 3 - CS31001
// Implementing Full Adder
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module FullAdder(a, b, c, S, C);
	input a, b, c;
	output S, C;
	wire x, y, z;
	xor(S, a, b, c);
	and(x, a, b);
	and(y, b, c);
	and(z, c, a);
	or(C, x, y, z);
endmodule
