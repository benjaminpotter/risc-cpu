module mdMux(
	input wire [31:0] buso,
	input wire [31:0] mem_data_in,
	input wire select,
	output wire [31:0] md_mux_out
);

	assign md_mux_out = select ? mem_data_in : buso;

endmodule 