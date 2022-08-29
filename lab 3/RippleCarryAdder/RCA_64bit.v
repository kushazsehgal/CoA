`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 3 - CS31001
// Implementing 64 bit Ripple Carry Adder
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module RCA_64bit(a,b,c,S,C);
	input [63:0] a,b;			// input 16 bit summands
	input c;						// carry input
	output [63:0] S;			// 16 bit sum output
	output C;					// Output Carry
	wire carry;					// Buffer Carry
	
	// Cascading two 32 bit Ripple Carry Adders to create a 64 bit Ripple Carry Adder
	RCA_32bit rca0(a[31:0],b[31:0],c,S[31:0],carry);
	RCA_32bit rca1(a[63:32],b[63:32],carry,S[63:32],C);

endmodule
