module `include "counter.v"
`default_nettype none

module tb_counter;
reg clk;
reg reset;
reg out;
structural_counter 
(
    .reset (reset),
    .clk (clk),
    .out (out)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;


initial begin
    #1 reset<=1'bx;clk<=1'bx;
    #(CLK_PERIOD*3) reset<=1;
    #(CLK_PERIOD*3) reset<=0;clk<=0;
    repeat(5) @(posedge clk);
    reset<=1;
    @(posedge clk);
    repeat(2) @(posedge clk);
    $finish(2);
end

endmodule
