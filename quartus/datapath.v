`include "register.v"
`include "alu.v"
`include "bus.v"

module datapath(
	input wire clock, clear,
	input wire [3:0] op_select,
	input wire [15:0] register_select,
	input wire [31:0] register_in
);

wire [31:0] ra_data, rb_data;
wire [63:0] rz_data_in, rz_data_out;

// register file
register ra(clear, clock, register_select[0], register_in, ra_data);
register rb(clear, clock, register_select[1], register_in, rb_data);

register rz_lo(clear, clock, register_select[2], rz_data_in[31:0], rz_data_out[31:0]);
register rz_hi(clear, clock, register_select[2], rz_data_in[63:32], rz_data_out[63:32]);

// alu
alu ALU(op_select, ra_data, rb_data, rz_data_in);


endmodule