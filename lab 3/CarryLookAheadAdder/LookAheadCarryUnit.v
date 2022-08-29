`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 3 - CS31001
// Implementing Look Ahead Carry Unit
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module LookAheadCarryUnit(c, p, g, C, P, G);
	input [3:0] p, g;
	input c;
	output [4:1] C;
	output P, G;
	
	assign C[1] = g[0] | (p[0] & c);
	assign C[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c);
	assign C[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c);
	assign C[4] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & c);
	
	assign P = p[3] & p[2] & p[1] & p[0];
	assign G = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);

endmodule
