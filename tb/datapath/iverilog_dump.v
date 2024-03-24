module iverilog_dump();
initial begin
    $dumpfile("datapath.fst");
    $dumpvars(0, datapath);
end
endmodule
