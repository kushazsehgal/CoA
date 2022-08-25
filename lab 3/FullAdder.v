`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:12:17 08/25/2022 
// Design Name: 
// Module Name:    FullAdder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module FullAdder(a, b, c, S, C);
	input a, b, c;
	output S, C;
	wire x, y, z;
	xor(S, a, b, c);
	and(x, a, b);
	and(y, b, c);
	and(z, c, a);
	or(C, x, y, z);
endmodule
