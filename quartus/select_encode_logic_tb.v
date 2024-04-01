module select_encode_logic_tb;

    reg [31:0] ir_out;
    reg gra, grb, grc, rin, rout, baout;

    wire [15:0] R_IN, R_OUT;
    wire [31:0] C_sign_extended;

    select_encode_logic uut (
        .ir_out(ir_out),
        .gra(gra),
        .grb(grb),
        .grc(grc),
        .rin(rin),
        .rout(rout),
        .baout(baout),
        .R_IN(R_IN),
        .R_OUT(R_OUT),
        .C_sign_extended(C_sign_extended)
    );


    initial begin
       
        ir_out <= 32'b00011000100100011000000000000000;
        gra <= 1;
        grb <= 1;
        grc <= 0;
        rin <= 1;
        rout <= 0;
        baout <= 0;

      
        #100;

        $finish;
    end

endmodule