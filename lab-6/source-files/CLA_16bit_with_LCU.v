`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Implementing 16 bit Look Ahead Carry Adder
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module CLA_16bit_withLCU(a, b, c, S, C);
	input [15:0] a, b;
	input c;
	output [15:0] S;
	output C;
	
	wire [4:1] carry; // wires for connecting carries from lookahead carry unit to the 4-bit CLAs
	wire [3:0] p, g; // wires for connecting block propagate and generate from 4-bit CLAs to lookahead carry unit
	 
	// 16 bit adder by using four augmented 4-bit CLAs and a lookahead carry unit
	CLA_4bit_augmented cla1(a[3:0], b[3:0], c, S[3:0], p[0], g[0]);
	CLA_4bit_augmented cla2(a[7:4], b[7:4], carry[1], S[7:4], p[1], g[1]);
	CLA_4bit_augmented cla3(a[11:8], b[11:8], carry[2], S[11:8], p[2], g[2]);
	CLA_4bit_augmented cla4(a[15:12], b[15:12], carry[3], S[15:12], p[3], g[3]);
	
	LookAheadCarryUnit lcu(c, p, g, carry);
	
	assign C = carry[4];


endmodule