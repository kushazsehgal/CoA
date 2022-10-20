
`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Implementing program counter (add 4 to PC)
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module PC_increment (
    input [31:0] instrAddr,
    output [31:0] nextPC
);

    assign nextPC = instrAddr + 32'b00000000000000000000000000000100;
    
endmodule