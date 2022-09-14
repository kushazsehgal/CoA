`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:53:13 09/14/2022
// Design Name:   behavioural_counter
// Module Name:   C:/Users/Jay Kumar Thakur/BinCounterBehavioural/behavioural_counter_testbench.v
// Project Name:  BinCounterBehavioural
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: behavioural_counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module behavioural_counter_testbench;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [3:0] out;

	// Instantiate the Unit Under Test (UUT)
	behavioural_counter uut (
		.clk(clk), 
		.rst(rst), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#50;
		rst = 1;
		#5
		rst = 0;
		
		#300
		rst = 1;
		#5
		rst = 0;
		

	end
	always #10 clk = ~clk;
      
endmodule

