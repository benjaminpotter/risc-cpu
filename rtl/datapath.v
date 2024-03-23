//`include "register.v"
//`include "alu.v"
//`include "bus.v"

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

	// alu register signals
	input wire ryi, ryo,
	input wire rzi, rzo,

	// register file signals
	input wire r0i, r0o,
	input wire r1i, r1o

);

wire [31:0] busi_pc, busi_ir;
wire [31:0] busi_mar, busi_mdr;
wire [31:0] busi_rz_hi, busi_rz_lo;
wire [31:0] busi_r0, busi_r1;

wire [31:0] buso;

wire [4:0] op_select;
wire [31:0] alua;
wire [31:0] alub;
wire [63:0] aluo;

// control registers
register rpc(clear, clock, pci, pc_immediate, busi_pc);
register rir(clear, clock, iri, buso, busi_ir);

// memory registers
register mar(clear, clock, mari, mar_immediate, busi_mar);
register mdr(clear, clock, mdri, mdr_immediate, busi_mdr);

// // 64 bit register
// register hi();
// register lo();

// alu registers
register ry(clear, clock, ryi, buso, alua);
register rz_hi(clear, clock, rzi, aluo[63:32], busi_rz_hi);
register rz_lo(clear, clock, rzi, aluo[31:0], busi_rz_lo);

// // register file
register r0(clear, clock, r0i, buso, busi_r0);
register r1(clear, clock, r1i, buso, busi_r1);

// bus
bus b(
	.busi_pc(busi_pc),
	.busi_ir(busi_ir),
	.busi_r0(busi_r0),
	.busi_r1(busi_r1),
	.busi_mar(busi_mar),
	.busi_mdr(busi_mdr),

	.pco(pco),
	.iro(iro),
	.maro(maro),
	.mdro(mdro),
	
	.r0o(r0o),
	.r1o(r1o),

	.buso(buso)
);

assign op_select = busi_ir[31:27]; //hardcode opcode here
assign alub = buso;

alu ALU(op_select, alua, alub, aluo); //fill in last 3 parameters after




endmodule