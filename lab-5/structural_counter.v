module counter(input clk,input reset,output reg[3:0] out)
    always @ (posedge clk)
    begin
        if(reset == 0)
            out <= 0
        else out <= out + 1
    end

endmodule