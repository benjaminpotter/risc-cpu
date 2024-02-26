module rotate_left(
	input [31:0] data_in,
	input [31:0] rotate_amount,
	output [31:0] data_out
);

assign data_out = (data_in << rotate_amount[4:0]) | (data_in >> (32 - rotate_amount[4:0])); //max rotate amount is 5 bits for 32 bit values

endmodule 