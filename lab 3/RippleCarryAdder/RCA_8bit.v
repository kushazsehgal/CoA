`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 3 - CS31001
// Implementing 8 bit Ripple Carry Adder
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module RCA_8bit(a, b, c, S, C);
	input [7:0] a, b;		// input 8 bit summands
	input c;					// input carry
	output [7:0] S;		// SUM
	output C;			   // CARRY
	wire [6:0] carry;
	
	// Cascading 8 FULL-ADDERS to add two 8 bit numbers
	FullAdder fad_0(a[0],b[0],c,S[0],carry[0]);
	FullAdder fad_1(a[1],b[1],carry[0],S[1],carry[1]);
	FullAdder fad_2(a[2],b[2],carry[1],S[2],carry[2]);
	FullAdder fad_3(a[3],b[3],carry[2],S[3],carry[3]);
	FullAdder fad_4(a[4],b[4],carry[3],S[4],carry[4]);
	FullAdder fad_5(a[5],b[5],carry[4],S[5],carry[5]);
	FullAdder fad_6(a[6],b[6],carry[5],S[6],carry[6]);
	FullAdder fad_7(a[7],b[7],carry[6],S[7],C);
	
endmodule
