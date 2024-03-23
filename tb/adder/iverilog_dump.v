module iverilog_dump();
initial begin
    $dumpfile("adder.fst");
    $dumpvars(0, adder);
end
endmodule
