module DFlipFlop(d, clk, Q)
    input   d, clk;
    output  Q;
    wire Qbar;
    wire    dbar, x, y;
    not     not1(dbar, d);
    nand    nand1(x, d, clk);
    nand    nand2(y,dbar, clk);
    nand    nand3(Q, x, Q_bar);
    nand    nand4(Q_bar,y,Q);
endmodule