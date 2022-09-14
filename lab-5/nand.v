module nand(o, i1, i2)
    input i1, i2;
    output o;
    wire w;
    and (w, i1, i2);
    not (o, w);
endmodule