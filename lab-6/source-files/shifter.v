`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Decodes 32 bit instruction into separate fields
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

// Module to implement shift operations for the ALU
module shifter(
    input signed [31:0] in, 
    input [31:0] shamt, 
    input direction, 
    input a_or_l,
    output reg [31:0] out
);
    // a_or_l = 0 indicates logical shift and a_or_l = 1 indicates arithmetic shift
    // direction = 0 indicates right shift and direction = 1 indicates left shift
    always @(*) begin
        if (a_or_l) begin
            if (!direction) begin
                out = in >>> shamt;     // Arithmetic right shift
            end else begin
                out = in;
            end
        end else begin
            if (!direction) begin
                out = in >> shamt;      // Logical right shift
            end else begin
                out = in << shamt;      // Left shift
            end
        end
    end

endmodule