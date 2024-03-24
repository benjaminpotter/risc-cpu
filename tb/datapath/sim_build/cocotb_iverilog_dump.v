module cocotb_iverilog_dump();
initial begin
    $dumpfile("sim_build/datapath.fst");
    $dumpvars(0, datapath);
end
endmodule
