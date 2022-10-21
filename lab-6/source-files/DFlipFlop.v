`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Implementing D Flip Flop
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module DFlipFlop(
    input clk,
    input rst,
    input d,
    output reg q
);

    always @(posedge clk or posedge rst) begin
        if(rst)
            q <= 1'b0
        else
            q <= d
    end
    
endmodule
