module ram(
	input clock,
	// control signals
	input wire read,
	input wire write,
	
	// data in and out
	input wire [31:0] data_in,
	output wire [31:0] data_out,
	
	// address
	input wire [8:0] address
);
	
	reg [31:0] memory [0:511];
	
	initial begin
		$readmemh("C:/Users/sagef/Documents/Engineering/ELEC 374/RISC-CPU/quartus/mem.txt", memory);
	end
	
	always@(write) begin
		if (write)
			memory[address] = data_in;
	end
	
	assign data_out = memory[address];
	
endmodule 