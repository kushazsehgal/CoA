`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Implementing D Flip Flop
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module control_unit(
    input [5:0]OP_CODE,
    input [5:0]FUNC_CODE,
    output [1:0]RegDst,
    output RegWrite,
    output JumpAddr,
    output Branch,
    output ALUsel,
    output MemRead,
    output MemWrite,
    output [1:0]MemtoReg,
    output ALUsrc,
    output [4:0]ALUop,
    output LblSel
);
    always @(OP_CODE or FUNC_CODE) begin
        case(opcode)