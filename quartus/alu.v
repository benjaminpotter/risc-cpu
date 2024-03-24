//`include "adder.v"
//`include "neg.v"
//`include "left_shift.v"
//`include "not_module.v"
//`include "or_module.v"
//`include "and_module.v"
//`include "right_shift.v"
//`include "arith_right_shift.v"
//`include "rotate_right.v"
//`include "rotate_left.v"
//`include "booth_mul.v"
//`include "division.v"


module alu (
    input wire [4:0] op_select,
    input wire [31:0] a,
    input wire [31:0] b,
	 output wire [63:0] result
);

    reg [63:0] out;
    wire [31:0] add_out;
    wire [31:0] sub_out;
	 wire [31:0] shr_out;
	 wire [31:0] shra_out;
    wire [31:0] shl_out;
	 wire [31:0] ror_out;
	 wire [31:0] rol_out;
	 wire [31:0] and_out;
	 wire [31:0] or_out;
	 wire [63:0] mul_out;
	 wire [31:0] quo_out;
	 wire [31:0] rem_out;
	 wire [31:0] neg_out;
	 wire [31:0] not_out;

	 // instantiate all operation modules
    adder add(a, b, add_out);
	 adder sub(a, neg_out, sub_out);
	 
	 right_shift shr(a, b[4:0], shr_out);
    left_shift shl(a, b[4:0], shl_out);
	 arith_right_shift shra(a, b[4:0], shra_out);
	 rotate_right ror(a, b[4:0], ror_out);
	 rotate_left rol(a, b[4:0], rol_out);
	 
	 not_module NOT(b, not_out);	 
	 and_module AND(a, b, and_out);
	 or_module OR(a, b, or_out);	 
    neg negator(b, neg_out);
	 
	 booth_mul mul(a, b, mul_out);
	 division div(a, b, quo_out, rem_out);
	 

    always @(*) begin
		out[63:32] = 32'b0;
		// output operation output based on op_select
		case(op_select)
			5'b00011: out [31:0] = add_out;
			5'b00100: out[31:0] = sub_out;
			5'b00101: out[31:0] = shr_out;
			5'b00110: out[31:0] = shra_out;
			5'b00111: out[31:0] = shl_out;
			5'b01000: out[31:0] = ror_out;
			5'b01001: out[31:0] = rol_out;
			5'b01010: out[31:0] = and_out;
			5'b01011: out[31:0] = or_out;
			5'b01111: out[63:0] = mul_out;
			5'b10000: begin
				out[31:0] = quo_out;
				out[63:32] = rem_out;
				end
			5'b10001: out[31:0] = neg_out;
			5'b10010: out[31:0] = not_out;
			default: out[31:0] = 0;
		endcase 
	 end
    assign result = out;

endmodule