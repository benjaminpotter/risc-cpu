module rotate_right(
	input [31:0] data_in,
	input [4:0] rotate_amount, //max rotate amount is 5 bits for 32 bit values
	output [31:0] data_out
);

	assign data_out = (data_in >> rotate_amount) | (data_in << (32 - rotate_amount));

endmodule 