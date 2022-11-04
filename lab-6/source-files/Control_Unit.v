`timescale 1ns / 1ps
////////////////////////////////////////////////////////
// Assignment 6 - CS31001
// Implementing D Flip Flop
// Team Details - 
// Kushaz Sehgal - 20CS30030
// Jay Kumar Thakur - 20CS30024
////////////////////////////////////////////////////////

module Control_Unit(
    input [5:0]OP_CODE,
    input [5:0]FUNC_CODE,
    output [1:0]RegDst,
    output RegWrite,
    output MemRead,
    output MemWrite,
    output [1:0]MemtoReg,
    output ALUsrc,
    output [4:0]ALUop,
    output ALUsel,
    output Branch,
    output JumpAddr,
    output LblSel
);
    always @(OP_CODE or FUNC_CODE) begin
        case (OP_CODE)
            6'b000000 : begin
                case (FUNC_CODE)
                    6'b000000 : begin   // ADD
                        RegDst = 2'b00;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        MemtoReg = 2'b10;
                        ALUsrc = 1'b0;
                        ALUop = 5'b00001;
                        ALUsel = 1'b0;
                        Branch = 1'b0;
                        JumpAddr = 1'b0; // Don't Care
                        LblSel = 1'b0; // Don't Care
                    end
                    6'b000001 : begin   // COMP
                        RegDst = 2'b00;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        MemtoReg = 2'b10;
                        ALUsrc = 1'b0;
                        ALUop = 5'b00101;
                        ALUsel = 1'b1;
                        Branch = 1'b0;
                        JumpAddr = 1'b0; // Don't Care
                        LblSel = 1'b0; // Don't Care
                    end
                    6'b00010 : begin    // DIFF
                        RegDst = 2'b00;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        MemtoReg = 2'b10;
                        ALUsrc = 1'b0;
                        ALUop = 5'b00111;
                        ALUsel = 1'b0;
                        Branch = 1'b0;
                        JumpAddr = 1'b0; // Don't Care
                        LblSel = 1'b0; // Don't Care
                    end
                    default : begin
                        RegDst = 2'b00;
                        RegWrite = 1'b0;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        MemtoReg = 2'b00;
                        ALUsrc = 1'b0;
                        ALUop = 5'b00000;
                        ALUsel = 1'b0;
                        Branch = 1'b0;
                        JumpAddr = 1'b0; // Don't Care
                        LblSel = 1'b0; // Don't Care
                    end
                endcase
            end
            6'b000001 : begin
                case(FUNC_CODE)
                    6'b000000 : begin   // XOR
                        RegDst = 2'b00;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        MemtoReg = 2'b10;
                        ALUsrc = 1'b0;
                        ALUop = 5'b00010;
                        ALUsel = 1'b0;
                        Branch = 1'b0;
                        JumpAddr = 1'b0; // Don't Care
                        LblSel = 1'b0; // Don't Care
                    end
                    6'b000001 : begin // AND
                        RegDst = 2'b00;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        MemtoReg = 2'b10;
                        ALUsrc = 1'b0;
                        ALUop = 5'b00011;
                        ALUsel = 1'b0;
                        Branch = 1'b0;
                        JumpAddr = 1'b0; // Don't Care
                        LblSel = 1'b0; // Don't Care
                    end
                    default : begin
                        RegDst = 2'b00;
                        RegWrite = 1'b0;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        MemtoReg = 2'b00;
                        ALUsrc = 1'b0;
                        ALUop = 5'b00000;
                        ALUsel = 1'b0;
                        Branch = 1'b0;
                        JumpAddr = 1'b0; // Don't Care
                        LblSel = 1'b0;// Don't Care
                    end
                endcase
            end
            6'b000010 : begin
                case(FUNC_CODE)
                    6'b000000 : begin   //SHLL
                        RegDst = 2'b00;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        MemtoReg = 2'b10;
                        ALUsrc = 1'b1;
                        ALUop = 5'b10000;
                        ALUsel = 1'b0;
                        Branch = 1'b0;
                        JumpAddr = 1'b0; // Don't Care
                        LblSel = 1'b0;// Don't Care
                    end
                    6'b000001 : begin   //SHRL
                        RegDst = 2'b00;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        MemtoReg = 2'b10;
                        ALUsrc = 1'b1;
                        ALUop = 5'b10010;
                        ALUsel = 1'b0;
                        Branch = 1'b0;
                        JumpAddr = 1'b0; // Don't Care
                        LblSel = 1'b0; // Don't Care
                    end
                    6'b000010 : begin // SHLLV
                        RegDst = 2'b00;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        MemtoReg = 2'b10;
                        ALUsrc = 1'b0;
                        ALUop = 5'b10000;
                        ALUsel = 1'b0;
                        Branch = 1'b0;
                        JumpAddr = 1'b0; // Don't Care
                        LblSel = 1'b0; // Don't Care
                    end
                    6'b000011 : begin // SHRLV
                        RegDst = 2'b00;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        MemtoReg = 2'b10;
                        ALUsrc = 1'b0;
                        ALUop = 5'b10010;
                        ALUsel = 1'b0;
                        Branch = 1'b0;
                        JumpAddr = 1'b0; // Don't Care
                        LblSel = 1'b0; // Don't Care
                    end
                    6'b000100 : begin // SHRA
                        RegDst = 2'b00;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        MemtoReg = 2'b10;
                        ALUsrc = 1'b1;
                        ALUop = 5'b10011;
                        ALUsel = 1'b0;
                        Branch = 1'b0;
                        JumpAddr = 1'b0; // Don't Care
                        LblSel = 1'b0; // Don't Care
                    end
                    6'b000101 : begin // SHRAV
                        RegDst = 2'b00;
                        RegWrite = 1'b1;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        MemtoReg = 2'b10;
                        ALUsrc = 1'b0;
                        ALUop = 5'b10011;
                        ALUsel = 1'b0;
                        Branch = 1'b0;
                        JumpAddr = 1'b0; // Don't Care
                        LblSel = 1'b0; // Don't Care
                    end
                    default : begin 
                        RegDst = 2'b00;
                        RegWrite = 1'b0;
                        MemRead = 1'b0;
                        MemWrite = 1'b0;
                        MemtoReg = 2'b00;
                        ALUsrc = 1'b0;
                        ALUop = 5'b00000;
                        ALUsel = 1'b0;
                        Branch = 1'b0;
                        JumpAddr = 1'b0; // Don't Care
                        LblSel = 1'b0; // Don't Care
                    end
                endcase
            end
            6'b000011 : begin // ADDI
                RegDst = 2'b00;
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b10;
                ALUsrc = 1'b1;
                ALUop = 5'b00001;
                ALUsel = 1'b0;
                Branch = 1'b0;
                JumpAddr = 1'b0; // Don't Care
                LblSel = 1'b0; // Don't Care
            end
            6'b000100 : begin // COMPI
                RegDst = 2'b00;
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b10;
                ALUsrc = 1'b1;
                ALUop = 5'b00101;
                ALUsel = 1'b1;
                Branch = 1'b0;
                JumpAddr = 1'b0; // Don't Care
                LblSel = 1'b0; // Don't Care
            end
            6'b000101 : begin // LW
                RegDst = 2'b01;
                RegWrite = 1'b1;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                MemtoReg = 2'b01;
                ALUsrc = 1'b1;
                ALUop = 5'b01001;
                ALUsel = 1'b0;
                Branch = 1'b0;
                JumpAddr = 1'b0; // Don't Care
                LblSel = 1'b0; // Don't Care
            end
            6'b000110 : begin // SW
                RegDst = 2'b00; // Don't Care
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b1;
                MemtoReg = 2'b00; // Don't Care
                ALUsrc = 1'b1;
                ALUop = 5'b01001;
                ALUsel = 1'b0;
                Branch = 1'b0;
                JumpAddr = 1'b0; // Don't Care
                LblSel = 1'b0;// Don't Care
            end
            6'b000111 : begin // B
                RegDst = 2'b00; // Don't Care
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00; // Don't Care
                ALUsrc = 1'b0;    // Don't Care
                ALUop = 5'b00000;
                ALUsel = 1'b0;   // Don't Care
                Branch = 1'b1;
                JumpAddr = 1'b0; 
                LblSel = 1'b0; 
            end
            6'b001000 : begin // BL
                RegDst = 2'b10; 
                RegWrite = 1'b1;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00; 
                ALUsrc = 1'b0;    // Don't Care
                ALUop = 5'b00000;
                ALUsel = 1'b0;   // Don't Care
                Branch = 1'b1;
                JumpAddr = 1'b0; 
                LblSel = 1'b0; 
            end
            6'b001001 : begin // BCY
                RegDst = 2'b00; // Don't Care 
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00; // Don't Care
                ALUsrc = 1'b0;    // Don't Care
                ALUop = 5'b00000;
                ALUsel = 1'b0;   // Don't Care
                Branch = 1'b1;
                JumpAddr = 1'b0; 
                LblSel = 1'b0; 
            end
            6'b001010 : begin // BNCY
                RegDst = 2'b00; // Don't Care 
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00; // Don't Care
                ALUsrc = 1'b0;    // Don't Care
                ALUop = 5'b00000;
                ALUsel = 1'b0;   // Don't Care
                Branch = 1'b1;
                JumpAddr = 1'b0; 
                LblSel = 1'b0; 
            end
            6'b001011 : begin // BLTZ
                RegDst = 2'b00;// Don't Care 
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00; // Don't Care
                ALUsrc = 1'b0;    // Don't Care
                ALUop = 5'b00000;
                ALUsel = 1'b0;   
                Branch = 1'b1;
                JumpAddr = 1'b0; 
                LblSel = 1'b1;
            end
            6'b001100 : begin // BZ
                RegDst = 2'b00; // Don't Care 
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00; // Don't Care
                ALUsrc = 1'b0;    // Don't Care
                ALUop = 5'b00000;
                ALUsel = 1'b0;   
                Branch = 1'b1;
                JumpAddr = 1'b0; 
                LblSel = 1'b1;
            end
            6'b001101 : begin // BNZ
                RegDst = 2'b00; // Don't Care 
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00; // Don't Care
                ALUsrc = 1'b0;    // Don't Care
                ALUop = 5'b00000;
                ALUsel = 1'b0;   
                Branch = 1'b1;
                JumpAddr = 1'b0; 
                LblSel = 1'b1;
            end
            6'b001110 : begin // BR
                RegDst = 2'b00; // Don't Care 
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00; // Don't Care
                ALUsrc = 1'b0;    // Don't Care
                ALUop = 5'b00000;
                ALUsel = 1'b0;   // Don't Care 
                Branch = 1'b1;   
                JumpAddr = 1'b1;
                LblSel = 1'b0;   // Don't Care
            end
            default : begin 
                RegDst = 2'b00;  
                RegWrite = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00; 
                ALUsrc = 1'b0;    
                ALUop = 5'b00000;
                ALUsel = 1'b0;    
                Branch = 1'b0;  
                JumpAddr = 1'b0;
                LblSel = 1'b0 ;  
            end
        endcase
    end

endmodule

