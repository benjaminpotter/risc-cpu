module division(
    input [31:0] Q,
    input [31:0] M,
    output reg [31:0] Quo,
    output reg [32:0] R
);

	reg [32:0] extended_M;
	reg [64:0] A;
	integer i;
	

	always @(*) begin
		A[64:32] = 33'b0000000000000000000000000000000;
		A[31:0] = Q;
		
		if (M[31] == 1) begin
			extended_M[32] = 1;
			extended_M[31:0] = M[31:0];
		end
		else begin
			extended_M[32] = 0;
			extended_M[31:0] = M[31:0];
		end
		
		for (i = 0; i < 32; i = i + 1) begin
			A = A << 1;
			A[64:32] = A[64:32] - M;
			if (A[64] == 1) begin
				A[0] = 0;
				A[64:32] = A[64:32] + M;
			end
			else begin
				A[0] = 1;
			end
		end
		Quo = A[31:0];
		R = A[64:32];
	end

endmodule
