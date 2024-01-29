
module bus (
	
	// data into bus
	input [31:0] ra, input [31:0] rb, input [31:0] rz,
	
	// select which thing gets the bus
	input ra_out, rb_out, rz_out,

	output wire [31:0] bus
);

	reg [31:0] q;

	always @ (*) begin
		if(ra_out) q = ra;
		if(rb_out) q = rb;
		if(rz_out) q = rz;
	end

	assign BusMuxOut = q;

endmodule
