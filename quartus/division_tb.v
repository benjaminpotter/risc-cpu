module division_tb;
    reg [31:0] Q, M;
    wire [31:0] Quo;
    wire [31:0] R;

    division div (
        Q,
        M,
        Quo,
        R
    );

    initial begin

        Q = 32'b00010000000000100000100000110100; M = 32'b00001000010000000010000000000001;
        #100

        $finish;
    end
endmodule