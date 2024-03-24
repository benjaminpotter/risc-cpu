module iverilog_dump();
initial begin
    $dumpfile("conff.fst");
    $dumpvars(0, conff);
end
endmodule
