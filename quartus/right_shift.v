module right_shift(
	input [31:0] data_in,
	input [31:0] shift_amount,
	output [31:0] data_out
);

	assign data_out = data_in >> shift_amount[4:0]; //max shift amount is 5 bits for 32 bit values

endmodule 