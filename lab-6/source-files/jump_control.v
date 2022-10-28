`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Decodes 32 bit instruction into separate fields
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

// The jump control block for determining if a jump is valid or not depending on flags from the ALU
module jump_control (
    input [5:0] opcode,
    input sign,
    input carry,
    input zero,
    output reg validJump
);
    
    always @(*) begin
        case (opcode)
            6'b001011 : begin           // bltz
                if (sign && !zero)
                    validJump = 1;
                else 
                    validJump = 0;
            end
            6'b001100 : begin           // bz
                if (!sign && zero)
                    validJump = 1;
                else 
                    validJump = 0;
            end
            6'b001101 : begin           // bnz
                if (!zero)
                    validJump = 1;
                else 
                    validJump = 0;
            end
            6'b001110 : begin           // br
                    validJump = 1;
                end
            6'b000111 : begin           // b
                    validJump = 1;
                end
            6'b001000 : begin           // bl
                    validJump = 1;
                end
            6'b001001 : begin           // bcy
                if (carry)
                    validJump = 1;
                else 
                    validJump = 0;
            end
            6'b001010 : begin           // bncy
                if (!carry)
                    validJump = 1;
                else 
                    validJump = 0;
            end
            default : validJump = 0;
        endcase
    end

endmodule