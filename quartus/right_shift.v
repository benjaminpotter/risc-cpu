module right_shift(
	input [31:0] data_in,
	input [4:0] shift_amount, //max shift amount is 5 bits for 32 bit values
	output [31:0] data_out
);

	assign data_out = data_in >> shift_amount;

endmodule 