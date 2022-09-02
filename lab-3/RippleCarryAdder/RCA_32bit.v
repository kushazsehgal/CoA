`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 3 - CS31001
// Implementing 32 bit Ripple Carry Adder
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module RCA_32bit(a,b,c,S,C);
	input [31:0] a,b;			// input 32 bit summands
	input c;						// carry input
	output [31:0] S;			// 32 bit sum output
	output C;					// Output Carry
	wire carry;					// Buffer Carry
	
	// Cascading two 16 bit Ripple Carry Adders to create a 32 bit Ripple Carry Adder
	RCA_16bit rca0(a[15:0],b[15:0],c,S[15:0],carry);
	RCA_16bit rca1(a[31:16],b[31:16],carry,S[31:16],C);

endmodule
