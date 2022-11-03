
`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Implementing program counter (updates at every clock edge)
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module Program_Counter (
    input [31:0] nextInstrAddr,
    input clk, 
    input rst,
    output reg [31:0] instrAddr
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            instrAddr <= -32'd4;
        end else begin
            instrAddr <= nextInstrAddr;     // Update the program counter
        end
    end

endmodule