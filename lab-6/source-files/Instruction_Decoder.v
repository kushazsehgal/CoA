`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Decodes 32 bit instruction into separate fields
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module Instruction_Decoder (
    input [31:0] instruction,
    output [5:0] OP_CODE,
    output [5:0] FUNC_CODE,
    output [25:0] label0,
    output [15:0] label1,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] shamt,
    output [15:0] imm
);

    assign OP_CODE = instruction[31:26];     // OP_CODE
    assign FUNC_CODE = instruction[5:0];         // FUNC_CODEtion code
    assign label0 = instruction[25:0];      // Jump address for 26-bit addresses
    assign label1 = instruction[15:0];      // Jump address for 16-bit addresses
    assign rs = instruction[25:21];         // Register rs
    assign rt = instruction[20:16];         // Register rt
    assign shamt = instruction[15:11];      // Shift amount
    assign imm = instruction[15:0];         // Immediate value
    
endmodule