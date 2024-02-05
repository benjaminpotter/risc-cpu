`include "register.v"
`include "alu.v"
`include "bus.v"

module datapath(
	input wire clock, clear,
	input wire [3:0] op_select,
	input wire [15:0] register_select,
	input wire [31:0] register_in
);

wire pc_enable, ir_enable;
wire [31:0] pc_data, ir_data;

wire [31:0] ra_data, rb_data;

wire mar_enable, mdr_enable;
wire [31:0] mar_data, mdr_data;

wire input_port_enable, output_port_enable;
wire [31:0] input_port_data, output_port_data;

wire [63:0] rz_data_in, rz_data_out;

// control
register pc(clear, clock, pc_enable, register_in, pc_data);
register ir(clear, clock, ir_enable, register_in, ir_data);

// register file
register ra(clear, clock, register_select[0], register_in, ra_data);
register rb(clear, clock, register_select[1], register_in, rb_data);

// memory interface
register mar(clear, clock, mar_enable, register_in, mar_data);
register mdr(clear, clock, mdr_enable, register_in, mdr_data);

// io interface
register input_port(clear, clock, input_port_enable, register_in, input_port_data);
register output_port(clear, clock, output_port_enable, register_in, output_port_data);

register rz_lo(clear, clock, register_select[2], rz_data_in[31:0], rz_data_out[31:0]);
register rz_hi(clear, clock, register_select[2], rz_data_in[63:32], rz_data_out[63:32]);

// alu
alu ALU(op_select, ra_data, rb_data, rz_data_in);


endmodule