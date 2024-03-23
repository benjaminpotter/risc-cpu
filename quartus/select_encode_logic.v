module select_encode_logic(input [31:0] ir_out,
                           input gra, grb, grc, rin, rout, baout, 
                           output [15:0] R_IN, R_OUT,
									output reg [31:0] C_sign_extended
);

	wire [3:0] ra = ir_out[26:23];
	wire [3:0] rb = ir_out[22:19];
	wire [3:0] rc = ir_out[18:15];
	
	reg [3:0] gra_l;
	reg [3:0] grb_l;
	reg [3:0] grc_l;
	
	wire [3:0] w1;
	wire [3:0] w2;
	wire [3:0] w3;
	wire [3:0] dec_in;
	wire [15:0] dec_out;
	reg [15:0] out_select;
	reg [15:0] rin_l;
	
	always @* begin
		C_sign_extended [18:0] = ir_out[18:0];
      if (ir_out[18] == 0) C_sign_extended[31:19] = 13'b0000000000000;
      if (ir_out[18] == 1) C_sign_extended[31:19] = 13'b1111111111111;
		
		if (gra == 1) gra_l = 4'b1111;
		if (grb == 1) grb_l = 4'b1111;
		if (grc == 1) grc_l = 4'b1111;
			
		if (gra == 0) gra_l = 4'b0000;
		if (grb == 0) grb_l = 4'b0000;
		if (grc == 0) grc_l = 4'b0000;
		
		if ((rout | baout) == 1) out_select = 16'b11111111;
		if (rin == 1)  rin_l = 16'b11111111;
		
		if ((rout | baout) == 0) out_select = 16'b00000000;
		if (rin == )  rin_l = 16'b00000000;
		
   end
	
	assign w1 = gra_l & ra;
	assign w2 = grb_l & rb;
	assign w3 = grc_l & rc;
	assign dec_in = w1 | w2 | w3;
    
   decoder d1(dec_in, dec_out);
    
   assign R_IN = rin_l & dec_out;
   assign R_OUT = out_select & dec_out;

	
endmodule