module decoder(input [3:0] code, output reg [15:0] data);

	always@(code)begin
		if (code == 0) data <= 16'b0000000000000001; else
		if (code == 1) data <= 16'b0000000000000010; else
		if (code == 2) data <= 16'b0000000000000100; else
		if (code == 3) data <= 16'b0000000000001000; else
		if (code == 4) data <= 16'b0000000000010000; else
		if (code == 5) data <= 16'b0000000000100000; else
		if (code == 6) data <= 16'b0000000001000000; else
		if (code == 7) data <= 16'b0000000010000000; else
		if (code == 8) data <= 16'b0000000100000000; else
		if (code == 9) data <= 16'b0000001000000000; else
		if (code == 10) data <= 16'b0000010000000000; else
		if (code == 11) data <= 16'b0000100000000000; else
		if (code == 12) data <= 16'b0001000000000000; else
		if (code == 13) data <= 16'b0010000000000000; else
		if (code == 14) data <= 16'b0100000000000000; else
		if (code == 15) data <= 16'b1000000000000000; else
		                data <= 16'bx;
	end

endmodule 