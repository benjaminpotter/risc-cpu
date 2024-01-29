`include "adder.v"
`include "neg.v"
`include "left_shift.v"

module alu (
    input wire [3:0] op_select,
    input wire [31:0] a,
    input wire [31:0] b,
    output wire [63:0] result
);

    reg [63:0] out;

    wire [31:0] add_out;
    wire [31:0] sub_out;
    wire [31:0] shl_out;
    wire [31:0] neg_out;

    adder add(a, b, add_out);
    
    left_shift shl(a, b[4:0], shl_out);
    
    neg negator(b, neg_out);
    adder sub(a, neg_out, sub_out);



    always @(op_select) begin
        if(op_select == 2)
            out <= add_out;
        else if (op_select == 3)
            out <= sub_out;
        else if (op_select == 6)
            out <= neg_out;
        else if (op_select == 10)
            out <= shl_out;
        else
            out <= 0;
    end

    assign result = out;

endmodule