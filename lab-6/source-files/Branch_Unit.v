`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Decodes 32 bit instruction into separate fields
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

// Branch Unit to compute the next instruction based on branch instructions
module Branch_Unit (
    input [31:0] nextPC,
    input [25:0] label0,
    input [15:0] label1,
    input [31:0] rsAddr,
    input lblSel,
    input jumpAddr,
    input branch,
    input validJump,
    output [31:0] nextAddr
);

    // Stores the 26-bit and 16-bit sign-extended labels
    wire [31:0] extendLabel0, extendLabel1;
    // Stores output of M1 and M2 respectively.
    wire [31:0] label_jump_addr, final_jump_addr;
    // Stores output of AND1
    wire isJump;

    assign extendLabel0 = {{6{label0[25]}}, label0};
    assign extendLabel1 = {{16{label1[15]}}, label1};

    assign isJump = branch & validJump;

    mux_32b_2_1 label_jump_sel (.a0(extendLabel0), .a1(extendLabel1), .sel(lblSel), .out(label_jump_addr));
    mux_32b_2_1 choose_jump_1 (.a0(Label), .a1(rsAddr), .sel(jumpAddr), .out(final_jump_addr));
    mux_32b_2_1 choose_jump_2 (.a0(nextPC), .a1(final_jump_addr), .sel(isJump), .out(nextAddr));
    
endmodule