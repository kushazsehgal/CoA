`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Implementation of Complete Datapath
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////


module Datapath (
    input [1:0] RegDst,
    input RegWrite,
    input MemRead,
    input MemWrite,
    input [1:0] MemToReg,
    input ALUsrc,
    input [4:0] ALUop,
    input ALUsel,
    input Branch,
    input JumpAddr,
    input LblSel,
    input clk,
    input rst,
    output [5:0] opcode,
    output [4:0] func
);
    parameter ra = 5'b11111;    // Register ra

endmodule