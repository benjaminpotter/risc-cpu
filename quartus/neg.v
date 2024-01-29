module neg (input wire [31:0] num_binary, output wire [31:0] neg_binary);

	assign neg_binary = (~num_binary)+1;

endmodule