`include "register.v"
`include "alu.v"
`include "bus.v"

module datapath(
	input wire clock, clear,

	// control register signals
	input wire pci, pco,
	input wire iri, iro,

	input wire [31:0] pc, pc_immediate,
	input wire [31:0] ir, ir_immediate,

	// memory register signals
	input wire mari, maro,
	input wire mdri, mdro,

	input wire [31:0] mar_immediate,
	input wire [31:0] mdr_immediate,

	// 64 bit register signals
	input wire hii, hio,
	input wire loi, loo,

	// register file signals
	input wire r0i, r0o,
	input wire r1i, r1o

);

wire [31:0] busi_pc, busi_ir;
wire [31:0] busi_mar, busi_mdr;
wire [31:0] busi_r0, busi_r1;

wire [31:0] buso;

// control registers
register rpc(clear, clock, pci, pc_immediate, busi_pc);
register rir(clear, clock, iri, ir_immediate, busi_ir);

// memory registers
register mar(clear, clock, mari, mar_immediate, busi_mar);
register mdr(clear, clock, mdri, mdr_immediate, busi_mdr);

// // 64 bit register
// register hi();
// register lo();

// // register file
register r0(clear, clock, r0i, buso, busi_r0);
register r1(clear, clock, r1i, buso, busi_r1);

// bus
bus b(
	.busi_pc(busi_pc),
	.busi_ir(busi_ir),
	.busi_r0(busi_r0),
	.busi_mar(busi_mar),
	.busi_mdr(busi_mdr),

	.pco(pco),
	.iro(iro),
	.maro(maro),
	.mdro(mdro),
	
	.r0o(r0o),

	.buso(buso)
);

input wire [4:0] op_select = buso[31:27];

alu ALU(op_select, a, b, result); //fill in last 3 parameters after




endmodule