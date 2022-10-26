`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Register File --> 32 registers with 32 bits each
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module Registers (
    input [4:0] rs,
    input [4:0] rt,
    input regWrite,
    input [4:0] writeReg,
    input [31:0] writeData,
    input clk,
    input rst,
    output reg [31:0] readData1,
    output reg [31:0] readData2
);
    reg signed [31:0] RegisterBank [31:0];
    integer i;
    always @(posedge clk posedge rst) begin
        if (rst) begin
            for(i = 0;i < 32;i++)
                RegisterBank[i] = 32'b00000000000000000000000000000000
        end
        else if (regWrite) begin    
            RegisterBank[writeReg] <= writeData;
        end
    end

    always @(*) begin
        readData1 <= RegisterBank[rs]
        readData2 <= RegisterBank[rt]
    end
    
endmodule   