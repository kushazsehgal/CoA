// Sign extend module for shift amount and immediate value
module immediate_sign_extend (
    input [5:0] OP_CODE,
    input [5:0] FUNC_CODE,       
    input [15:0] instr,
    output reg [31:0] extendImm
);
    always @(*) begin
        if (OP_CODE == 6'b000010) begin                  // for shift amount
            extendImm = {{27{1'b0}}, instr[15:11]};
        end else begin                                  // for immediate value
            extendImm = {{16{instr[15]}}, instr};
        end
    end
endmodule