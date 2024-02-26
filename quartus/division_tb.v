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

        Q = 32'hFFFF_FFF9; M = 32'h0000_0002;
        #100

        $finish;
    end
endmodule