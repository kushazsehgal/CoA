`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 3 - CS31001
// Implementing 16 bit Ripple Carry Adder
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module RCA_16bit(a,b,c,S,C);
	input [15:0] a,b;			// input 16 bit summands
	input c;						// carry input
	output [15:0] S;			// 16 bit sum output
	output C;					// Output Carry
	wire carry;					// Buffer Carry
	
	// Cascading two 8 bit Ripple Carry Adders to create a 16 bit Ripple Carry Adder
	RCA_8bit rca0(a[7:0],b[7:0],c,S[7:0],carry);
	RCA_8bit rca1(a[15:8],b[15:8],carry,S[15:8],C);

endmodule
