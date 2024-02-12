module or_module (
    input wire [31:0] a,
    input wire [31:0] b,
    output reg [31:0] or_result
);

	integer i; 

	always @* begin
		 for (i = 0; i < 32; i = i + 1) begin 
			  if (a[i] == 1 || b[i] == 1) begin 
					or_result[i] = 1;
			  end
			  else begin
					or_result[i] = 0;
			  end
		 end
	end

endmodule