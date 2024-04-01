module decoder_tb;


	 reg [3:0] code;
	 wire [15:0] data;

	 decoder dec(
	 .code(code),
	 .data(data)
    );


    initial begin
       
        code <= 4'b0100;

      
        #100;
        $finish;
    end

endmodule