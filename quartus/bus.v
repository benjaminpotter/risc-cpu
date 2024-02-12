
module bus (

	// mux 
	input wire [31:0] busi_pc, 
	input wire [31:0] busi_ir,
	input wire [31:0] busi_r0,

	// encoder
	input wire pco, iro,
	input wire r0o,

	// output
	output wire [31:0] buso
);

	reg [31:0] q;

	always @ (*) begin
		if(pco) q = busi_pc;
		if(iro) q = busi_ir;

		if(r0o) q = busi_r0;
	end

	assign buso = q;

endmodule
