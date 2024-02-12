module booth_mul(
	input signed [31:0] M,
	input signed [31:0] Q,
	output signed [63:0] P);
	
	wire signed [31:0] neg_M;
	reg [2:0] bit_groups [15:0]; // holds the multiplier's bit pairs (& bit on right), there are 16 bit triples for a 32 bit multiplier
	reg signed [63:0] partial_products [15:0]; // holds the 16 partial products
	reg signed [63:0] product; //holds the 64 bit product
	integer i;

	assign neg_M = ~M + 1; // negative multiplicand
	
	always@(M or Q or neg_M)
	begin
		bit_groups[0] = {Q[1], Q[0], 1'b0}; // first bit group has implied 0 in right bit
		
		// save all the bit groups of the multiplier
		for(i=1; i<16; i=i+1)
		begin
			bit_groups[i] = {Q[2*i+1], Q[2*i], Q[2*i-1]};
		end
		
		// calculate partial products based on the bit groups
		for(i=0; i<16; i=i+1)
		begin
			case(bit_groups[i])
				3'b001, 3'b010: partial_products[i] = {{32{M[31]}}, M};  	     // * +1, set to M w/ sign extension
				3'b011: partial_products[i] = {{32{M[31]}}, M<<1};               // * +2, right shift M w/ sign extension
				3'b100: partial_products[i] = {{32{neg_M[31]}}, neg_M[31:0]<<1}; // * -2, right shift -M w/ sign extension
				3'b101, 3'b110: partial_products[i] = {{32{neg_M[31]}}, neg_M};  // * -1, set to -M w/ sign extension
				default: partial_products[i] = 0;                                // * 0
			endcase
			
			partial_products[i] = partial_products[i] << (2*i); // shift the partial product for addition later
		end
		
		// sum the partial products
		product = partial_products[0];
		for(i=1; i<16; i=i+1)
		begin
			product = product + partial_products[i];
		end
	end
	
	assign P = product;
	
endmodule 