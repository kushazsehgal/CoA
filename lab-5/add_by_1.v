module add_by_1(input in[3:0],input reset,output out[3:0])
    wire P[3:0]
    wire C[3:1]

    assign out[0] = in[0] ^ 4'b1;
    assign C[1] =  in[0]; //Same as in[0] & 4'b1
    assign out[1] = in[1] ^ C[1];
    assign C[2] = in[1] & C[1];
    assign out[2] = in[2] ^ C[2];
    assign C[3] = in[2] & C[2];
    assign out[3] = in[1] ^ C[3];

    assign out[0] = out[0] & (~reset);
    assign out[1] = out[1] & (~reset);
    assign out[2] = out[2] & (~reset);
    assign out[3] = out[3] & (~reset);

endmodule
