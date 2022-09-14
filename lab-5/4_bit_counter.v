module 4_bit_counter(input clk,input reset)

    wire out_from_D[3:0];
    wire out_from_add_by_1[3:0];

    DFlipFlop D_1(out_from_add_by_1[0],clk,out_from_D[0]);
    DFlipFlop D_2(out_from_add_by_1[1],clk,out_from_D[1]);
    DFlipFlop D_3(out_from_add_by_1[2],clk,out_from_D[2]);
    DFlipFlop D_4(out_from_add_by_1[3],clk,out_from_D[3]);

    add_by_1(out_from_D,reset,out_from_add_by_1);
    
endmodule