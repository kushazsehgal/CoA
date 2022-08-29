`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 3 - CS31001
// Implementing 16 bit ripple Carry Look Ahead Adder
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module LCA_16bit_ripple(a, b, c, S, C);
	input [15:0] a, b;
	input c;
	output [15:0] S;
	output C;
	
	wire [3:0] carry;
	
	CLA_4bit cla1(a[3:0], b[3:0], c, S[3:0], carry[0]);
	CLA_4bit cla2(a[7:4], b[7:4], carry[0], S[7:4], carry[1]);
	CLA_4bit cla3(a[11:8], b[11:8], carry[1], S[11:8], carry[2]);
	CLA_4bit cla4(a[15:12], b[15:12], carry[2], S[15:12], C);

endmodule
