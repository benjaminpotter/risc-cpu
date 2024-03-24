module arith_right_shift(
	input signed [31:0] data_in,
	input [31:0] shift_amount, //max shift amount is 5 bits for 32 bit values
	output signed [31:0] data_out
);

	assign data_out = data_in >>> shift_amount[4:0];

endmodule 