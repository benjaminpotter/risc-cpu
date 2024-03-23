module decoder2to4(input [1:0] code, output reg [3:0] data);

	always@(code)begin
		if (code == 0) data <= 4'b0001; else
		if (code == 1) data <= 4'b0010; else
		if (code == 2) data <= 4'b0100; else
		if (code == 3) data <= 4'b1000; else
		               data <= 4'bx;
		
	end

endmodule 