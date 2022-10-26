
`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Top module miniRISC instantiate the datapath and controller units
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module miniRISC (
    input clk,
    input rst
);
    wire [5:0] opcode;
    wire [4:0] func;
    wire [1:0] regDst;
    wire regWrite;
    wire memRead;
    wire memWrite;
    wire [1:0] memToReg;
    wire ALUsrc;
    wire [4:0] ALUop;
    wire ALUsel;
    wire branch;
    wire jumpAddr;
    wire lblSel;

    // Instantiate the control unit
    control_unit CU (
        .opcode(opcode),
        .func(func),
        .regDst(regDst),
        .regWrite(regWrite),
        .memRead(memRead),
        .memWrite(memWrite),
        .memToReg(memToReg),
        .ALUsrc(ALUsrc),
        .ALUop(ALUop),
        .ALUsel(ALUsel),
        .branch(branch),
        .jumpAddr(jumpAddr),
        .lblSel(lblSel)
    );

    // Instantiate the datapath unit
    datapath DP (
        .opcode(opcode),
        .func(func),
        .regDst(regDst),
        .regWrite(regWrite),
        .memRead(memRead),
        .memWrite(memWrite),
        .memToReg(memToReg),
        .ALUsrc(ALUsrc),
        .ALUop(ALUop),
        .ALUsel(ALUsel),
        .branch(branch),
        .jumpAddr(jumpAddr),
        .lblSel(lblSel),
        .clk(clk),
        .rst(rst)
    );
endmodule