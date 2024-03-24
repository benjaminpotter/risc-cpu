
module bus (

	// mux 
	input wire [31:0] busi_pc, 
	input wire [31:0] busi_ir,
	input wire [31:0] busi_r0,
	input wire [31:0] busi_r1,
	input wire [31:0] busi_r2,
	input wire [31:0] busi_r3,
	input wire [31:0] busi_r4,
	input wire [31:0] busi_r5,
	input wire [31:0] busi_r6,
	input wire [31:0] busi_r7,
	input wire [31:0] busi_r8,
	input wire [31:0] busi_r9,
	input wire [31:0] busi_r10,
	input wire [31:0] busi_r11,
	input wire [31:0] busi_r12,
	input wire [31:0] busi_r13,
	input wire [31:0] busi_r14,
	input wire [31:0] busi_r15,
	input wire [31:0] busi_mdr,
	input wire [31:0] busi_hi,
	input wire [31:0] busi_lo,
	input wire [31:0] busi_rz_hi,
	input wire [31:0] busi_rz_lo,
	input wire [31:0] busi_ip,
	input wire [31:0] busi_c_sign,

	// encoder
	input wire pco, iro,
	input wire mdro, 
	input wire hio, loo, rzho, rzlo,
	input wire ipo,
	input wire r0o,
	input wire r1o,
	input wire r2o,
	input wire r3o,
	input wire r4o,
	input wire r5o,
	input wire r6o,
	input wire r7o,
	input wire r8o,
	input wire r9o,
	input wire r10o,
	input wire r11o,
	input wire r12o,
	input wire r13o,
	input wire r14o,
	input wire r15o,
	input wire csigno,

	// output
	output wire [31:0] buso
);

	reg [31:0] q;

	always @ (*) begin
		if(pco) q = busi_pc;
		if(iro) q = busi_ir;

		if(mdro) q = busi_mdr;
		
		if(hio) q = busi_hi;
		if(loo) q = busi_lo;
		
		if(rzho) q = busi_rz_hi;
		if(rzlo) q = busi_rz_lo;
		
		if(ipo) q = busi_ip;

		if(r0o) q = busi_r0;
		if(r1o) q = busi_r1;
		if(r2o) q = busi_r2;
		if(r3o) q = busi_r3;
		if(r4o) q = busi_r4;
		if(r5o) q = busi_r5;
		if(r6o) q = busi_r6;
		if(r7o) q = busi_r7;
		if(r8o) q = busi_r8;
		if(r9o) q = busi_r9;
		if(r10o) q = busi_r10;
		if(r11o) q = busi_r11;
		if(r12o) q = busi_r12;
		if(r13o) q = busi_r13;
		if(r14o) q = busi_r14;
		if(r15o) q = busi_r15;
		
		if(csigno) q = busi_c_sign;
	end

	assign buso = q;

endmodule
