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
    output [5:0] OP_CODE,
    output [4:0] FUNC_CODE
);
    parameter ra = 5'b11111;    // Register ra
    wire enable;
    wire carry, zero, sign, validJump, lastCarry;
    wire [31:0] nextInstrAddr, instruction, writeData, readData1, instrAddr, result, nextPC, readData2, SE1out, b, dataMemReadData;
    wire [25:0] label0;
    wire [15:0] label1, imm;
    wire [4:0] rs, rt, shamt, writeReg;
    wire [31:0] offset;
    
    assign enable = memRead | memWrite;         // Enable signal for the data memory module
    assign offset = nextInstrAddr >>> 2'b10;    // Read address for the instruction memory module
    
    // Instantiating a DFF to store the carry flag value
    DFlipFlop DFF (
        .clk(clk),
        .rst(rst),
        .d(carry),
        .q(lastCarry)
    );
    
    // Instantiating the program counter module
    Program_Counter PC (
        .nextInstrAddr(nextInstrAddr),
        .clk(clk),
        .rst(rst),
        .instrAddr(instrAddr)
    );
    //////////////////////////////////////
    // Instantiating the instruction memory module
    bram_instr_mem instructionMemory (
        .clka(clk),
        .ena(1'b1),
        .addra(offset[9:0]),
        .douta(instruction)
    );
    ////////////////////////////////////////
    // Instantiating the instruction decoder module
    Instruction_Decoder instructionDecoder (
        .instruction(instruction),
        .OP_CODE(OP_CODE),
        .FUNC_CODE(FUNC_CODE),
        .label0(label0),
        .label1(label1),
        .rs(rs),
        .rt(rt),
        .shamt(shamt),
        .imm(imm)
    );

    // Mux to select the register to which data is to be written
    MUX_5b_3_1 MUX1 (
        .a0(rs),
        .a1(rt),
        .a2(ra),
        .sel(regDst),
        .out(writeReg)
    );

    // Instantiating the register file module
    Registers registerFile (
        .rs(rs),
        .rt(rt),
        .regWrite(regWrite),
        .writeReg(writeReg),
        .writeData(writeData),
        .clk(clk),
        .rst(rst),
        .readData1(readData1),
        .readData2(readData2)
    );

    // Instantiating the sign extend module
    Immediate_Sign_Extend SE1 (
        .OP_CODE(OP_CODE),
        .FUNC_CODE(FUNC_CODE),
        .instr(imm),
        .extendImm(SE1out)
    );

    // Mux to choose the second input of the ALU
    MUX_32b_2_1 MUX2 (
        .a0(readData2),
        .a1(SE1out),
        .sel(ALUsrc), 
        .out(b)
    );

    // Instantiating the ALU module
    ALU ALU1 (
        .a(readData1),
        .b(b),
        .ALUsel(ALUsel),
        .ALUop(ALUop),
        .carry(carry),
        .zero(zero), 
        .sign(sign),
        .result(result)
    );

    // Instantiating the jump control module
    Jump_Control JC (
        .OP_CODE(OP_CODE),
        .sign(sign),
        .carry(lastCarry),
        .zero(zero),
        .validJump(validJump)
    );

    // Instantiating the PC increment module
    PC_increment PCInc (
        .instrAddr(instrAddr),
        .nextPC(nextPC)
    );

    // Instantiating the branch unit module
    Branch_Unit branchUnit (
        .nextPC(nextPC),
        .label0(label0),
        .label1(label1),
        .rsAddr(readData1),
        .lblSel(lblSel),
        .jumpAddr(jumpAddr),
        .branch(branch),
        .validJump(validJump),
        .nextAddr(nextInstrAddr)
    );

    // Instantiating the data memory module
    ////////////////////////////////////////////
    bram_data_mem dataMemory (
        .clka(~clk),
        .ena(enable),
        .wea(memWrite),
        .addra(result[9:0] >>> 2'b10),
        .dina(readData2),
        .douta(dataMemReadData)
    );
    ///////////////////////////////////////////////
    // Mux to select the data to be written to the data memory
    MUX_32b_3_1 MUX3 (
        .a0(nextPC),
        .a1(dataMemReadData),
        .a2(result),
        .sel(memToReg),
        .out(writeData)
    );
endmodule