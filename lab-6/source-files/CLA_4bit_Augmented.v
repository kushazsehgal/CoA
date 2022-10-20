`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Implementing 4 bit augmented Look Ahead Carry Adder
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module CLA_4bit_augmented(a, b, c, S, P, G);
	
	input [3:0] a, b;
	input c;
	output [3:0] S;
	output P, G;
	
	wire [3:0] g, p, carry; // wires for bitwise generate, propagate and carries
	
	// calculate bitwise generate and propagate
	assign g = a & b;
	assign p = a ^ b;
	
	// calculate subsequent carries using generates and propagates
	assign carry[0] = c;
	assign carry[1] = g[0] | (p[0] & c);
	assign carry[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c);
	// assign carry[2] = g[1] | (p[1] & (g[0] | (p[0] & c));
	assign carry[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c);
	
	// calculate final S using propagate and carries
	assign S = p ^ carry;
	
	// calculate block propagate and generate for next level
	assign P = p[3] & p[2] & p[1] & p[0];
	assign G = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);


endmodule
