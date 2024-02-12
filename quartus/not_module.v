module not_module(input wire [31:0] num_binary, output reg [31:0] not_binary);

	always @(*) begin
		not_binary = ~num_binary;		
	end

endmodule