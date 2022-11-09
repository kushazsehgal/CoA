always @(*) begin
        if (ALUop == 6'b00000) begin 
            result = input1;
        end
        else if (ALUop == 6'b00001) begin 
            result = add_output;
            carry = carry_buffer;
        end
        else if (ALUop == 6'b00101) begin
            result = add_output;
        end
        else if (ALUop == 6'b00010) begin
            result = xor_output;
        end
        else if (ALUop == 6'b00011) begin
            result = and_output;
			end
        else if (ALUop == 6'b00111) begin
            result = diff_output;
			end
        else if (ALUop == 6'b01001) begin
            result = add_output;
        end
        else if (ALUop[4:2] == 3'b100) begin
            result = shift_output;
        end
    end

    always @(result) begin
        if (!result) begin
            zero = 1'b1;
        end
        else begin
            zero = 1'b00000;
        end
        sign = result[31];
    end