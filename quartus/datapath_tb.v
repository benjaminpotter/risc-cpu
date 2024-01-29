`timescale 1ns/1ps
`include "datapath.v"

module datapath_tb();
	reg clock, clear;
	reg [15:0] register_select;
	reg [31:0] register_set;
	reg [3:0] op_select;

	datapath DP(
		clock, clear,
		op_select,
		register_select,
		register_set
	);
				
	initial begin 
		$dumpfile("datapath_tb.vcd");
		$dumpvars(0, datapath_tb);

		clock = 0; 
		#10

		register_select = 16'b0000000000000001;
		register_set = 5;
		#10
		clock = 1;
		#10
		clock = 0;
		#10

		register_select = 16'b0000000000000010;
		register_set = 1;
		#10
		clock = 1;
		#10
		clock = 0;
		#10

		op_select = 4'b0011;
		#10
		clock = 1;
		#10
		clock = 0;
		#10

		$display("sim complete");
		$finish;
	end
endmodule
