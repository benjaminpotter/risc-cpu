module division(
    input [31:0] Q_input,
    input [31:0] M_input,
//	 input [31:0] Q,
//	 input [31:0] M,
    output reg [31:0] Quo,
    output reg [31:0] R
);

	reg [32:0] extended_M;
	reg [64:0] A;
	reg [31:0] Q;
	reg [31:0] M;
	integer i;
	integer q_neg;
	integer m_neg;
//
//	initial begin
//		if ((Q_input[31] == 1) && (M_input[31] == 0)) begin
//			Q = (~Q_input)+1;
//			M = M_input;
//			q_neg = 1;
//			m_neg = 0;
//		end
//		if ((Q_input[31] == 0) && (M_input[31] == 1)) begin
//			M = (~M_input)+1;
//			Q = Q_input;
//			m_neg = 1;
//			q_neg = 0;
//		end
//		if ((Q_input[31] == 1) && (M_input[31] == 1)) begin
//			M = (~M_input)+1;
//			Q = (~Q_input)+1;
//			q_neg = 1;
//			m_neg = 1;
//		end
//		if ((Q_input[31] == 0) && (M_input[31] == 0)) begin
//			M = M_input;
//			Q = Q_input;
//			q_neg = 0;
//			m_neg = 0;
//		end
//	end

	always @(*) begin
	
		if ((Q_input[31] == 1) && (M_input[31] == 0)) begin
			Q = (~Q_input)+1;
			M = M_input;
			q_neg = 1;
			m_neg = 0;
		end
		if ((Q_input[31] == 0) && (M_input[31] == 1)) begin
			M = (~M_input)+1;
			Q = Q_input;
			m_neg = 1;
			q_neg = 0;
		end
		if ((Q_input[31] == 1) && (M_input[31] == 1)) begin
			M = (~M_input)+1;
			Q = (~Q_input)+1;
			q_neg = 1;
			m_neg = 1;
		end
		if ((Q_input[31] == 0) && (M_input[31] == 0)) begin
			M = M_input;
			Q = Q_input;
			q_neg = 0;
			m_neg = 0;
		end
		
		A[64:32] = 33'b0;
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
		R = A[63:32];
		
		if ((q_neg == 1) && (m_neg == 0)) begin
			Quo = (~Quo)+1;
		end
		if ((q_neg == 0) && (m_neg == 1)) begin
			Quo = (~Quo)+1;
		end
	end



endmodule
