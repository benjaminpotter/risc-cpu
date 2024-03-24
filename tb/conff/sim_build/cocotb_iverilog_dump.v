module cocotb_iverilog_dump();
initial begin
    $dumpfile("sim_build/conff.fst");
    $dumpvars(0, conff);
end
endmodule
