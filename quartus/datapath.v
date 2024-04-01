//`include "register.v"
//`include "alu.v"
//`include "bus.v"

module datapath(
	input wire clock, clear,

	// control register signals
	input wire pci, pco,
	input wire iri, iro,

	input wire [31:0] pc, pc_immediate,
	input wire [31:0] ir, 

	// memory register signals
	input wire mari, maro,
	input wire mdri, mdro,
	
		// memory and mdr signals
	input wire mem_read,
	input wire mem_write,
	
	// inport and outport signals
	input wire opi, ipi, ipo,
	input wire [31:0] input_unit,
	//input wire [31:0] output_unit,

	// 64 bit register signals
	input wire hii, hio,
	input wire loi, loo,
	
	// alu register signals
	input wire ryi, ryo,
	input wire rzhi, rzli, rzho, rzlo, rzo,
	
	// c sign extended signal
	input wire csigno,
	
	// select and encode and register file signals
	input wire gra, grb, grc, rin, rout, baout
	
);

wire [31:0] busi_pc, busi_ir;
wire [31:0] memi_mar, busi_mdr; 
wire [31:0] busi_hi, busi_lo;
wire [31:0] busi_rz_hi, busi_rz_lo;
wire [31:0] busi_r0, busi_r1, busi_r2, busi_r3, busi_r4, busi_r5, busi_r6, busi_r7, busi_r8, busi_r9, busi_r10, busi_r11, busi_r12, busi_r13, busi_r14, busi_r15;
wire [31:0] busi_ip;
wire [31:0] busi_c_sign;
wire [15:0] R_IN, R_OUT;

wire [31:0] buso;

wire [4:0] op_select;
wire [31:0] alua;
wire [31:0] alub;
wire [63:0] aluo;

wire [31:0] ram_data_out;

wire [31:0] md_mux_out;

// control registers
register rpc(clear, clock, pci, pc_immediate, busi_pc);
register rir(clear, clock, iri, buso, busi_ir);

// memory registers
register mar(clear, clock, mari, buso, memi_mar); 
register mdr(clear, clock, mdri, md_mux_out, busi_mdr);

// select and encode logic
select_encode_logic sel(busi_ir, gra, grb, grc, rin, rout, baout, R_IN, R_OUT, busi_c_sign); //c sign extend going on bus

// MDR mux
wire [31:0] md_mux_buso;
assign md_mux_buso = buso;

mdMux md_mux(
	.buso(md_mux_buso),
	.mem_data_in(ram_data_out),
	.select(mem_read),
	.md_mux_out(md_mux_out)
);

// // 64 bit register

reg [31:0] hi_in = 32'h0000000F;
//reg [31:0] lo_in = 32'h0000000F;
register hi(clear, clock, hii, hi_in, busi_hi);
register lo(clear, clock, loi, lo_in, busi_lo);

// alu registers
register ry(clear, clock, ryi, buso, alua);
register rz_hi(clear, clock, rzhi, aluo[63:32], busi_rz_hi);
register rz_lo(clear, clock, rzli, aluo[31:0], busi_rz_lo);

// input and output ports
wire [31:0] output_unit;
register outport(clear, clock, opi, buso, output_unit);
register inport(clear, clock, ipi, input_unit, busi_ip);

// register file
// set r0 to all zeroes
reg [31:0] r0_in = 32'b0;
register r0(clear, clock, baout, r0_in, busi_r0);

//reg [31:0] r2_in = 32'h00000002;
//reg [31:0] r3_in = 32'h0F0F0F0F;

register r1(clear, clock, R_IN[1], buso, busi_r1);
register r2(clear, clock, R_IN[2], r2_in, busi_r2);
register r3(clear, clock, R_IN[3], r3_in, busi_r3);
register r4(clear, clock, R_IN[4], buso, busi_r4);
register r5(clear, clock, R_IN[5], buso, busi_r5);
register r6(clear, clock, R_IN[6], buso, busi_r6);
register r7(clear, clock, R_IN[7], buso, busi_r7);
register r8(clear, clock, R_IN[8], buso, busi_r8);
register r9(clear, clock, R_IN[9], buso, busi_r9);
register r10(clear, clock, R_IN[10], buso, busi_r10);
register r11(clear, clock, R_IN[11], buso, busi_r11);
register r12(clear, clock, R_IN[12], buso, busi_r12);
register r13(clear, clock, R_IN[13], buso, busi_r13);
register r14(clear, clock, R_IN[14], buso, busi_r14);
register r15(clear, clock, R_IN[15], buso, busi_r15);


// bus
bus b(
	.busi_pc(busi_pc),
	.busi_ir(busi_ir),
	.busi_r0(busi_r0),
	.busi_r1(busi_r1),
	.busi_r2(busi_r2),
	.busi_r3(busi_r3),
	.busi_r4(busi_r4),
	.busi_r5(busi_r5),
	.busi_r6(busi_r6),
	.busi_r7(busi_r7),
	.busi_r8(busi_r8),
	.busi_r9(busi_r9),
	.busi_r10(busi_r10),
	.busi_r11(busi_r11),
	.busi_r12(busi_r12),
	.busi_r13(busi_r13),
	.busi_r14(busi_r14),
	.busi_r15(busi_r15),
	.busi_mdr(busi_mdr),
	.busi_hi(busi_hi),
	.busi_lo(busi_lo),
	.busi_rz_hi(busi_rz_hi),
	.busi_rz_lo(busi_rz_lo),
	.busi_ip(busi_ip),
	.busi_c_sign(busi_c_sign),

	.pco(pco),
	.iro(iro),
	.mdro(mdro),
	.hio(hio),
	.loo(loo),
	.rzho(rzho),
	.rzlo(rzlo),
	.ipo(ipo),
	
	.r0o(R_OUT[0]),
	.r1o(R_OUT[1]),
	.r2o(R_OUT[2]),
	.r3o(R_OUT[3]),
	.r4o(R_OUT[4]),
	.r5o(R_OUT[5]),
	.r6o(R_OUT[6]),
	.r7o(R_OUT[7]),
	.r8o(R_OUT[8]),
	.r9o(R_OUT[9]),
	.r10o(R_OUT[10]),
	.r11o(R_OUT[11]),
	.r12o(R_OUT[12]),
	.r13o(R_OUT[13]),
	.r14o(R_OUT[14]),
	.r15o(R_OUT[15]),
	.csigno(csigno),
	
	.buso(buso)
);

assign op_select = busi_ir[31:27];
assign alub = buso;

alu ALU(op_select, alua, alub, aluo);

ram memory(
	.read(mem_read),
	.write(mem_write),
	.data_in(busi_mdr),
	.data_out(ram_data_out),
	.address(memi_mar[8:0])
);

endmodule