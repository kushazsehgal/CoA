`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 3 - CS31001
// Implementing Carry Look Ahead Adder
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module CLA_4bit(a, b, c, S, C);
	input [3:0] a, b;
	input c;
	output [3:0] S;
	output C;
	
	wire [3:0] G, P, carry; // wires for bitwise generate, propagate and carries
	
	// calculate bitwise generate and propagate
	assign G = a & b;
	assign P = a ^ b;
	
	// calculate subsequent carries using generates and propagates
	assign carry[0] = c;
	assign carry[1] = G[0] | (P[0] & c);
	assign carry[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & c);
	assign carry[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & c);
	// here the output carry C is our carry[4]
	assign C = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & c);
	
	// calculate final Sum using propagate and carries
	assign S = P ^ carry;

endmodule
