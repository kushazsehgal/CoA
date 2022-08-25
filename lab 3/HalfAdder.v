`timescale 1ns / 1ps

////////////////////////////////////////////////////////
// Assignment 3 - CS31001
// Implementing Half Adder
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module HalfAdder(a, b, S, C);
	input a, b;
	output S, C;
	xor(S, a, b);
	and(C, a, b);
endmodule
