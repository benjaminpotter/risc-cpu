`timescale 1ns/1ps
//`include "datapath.v"

module datapath_ror_tb();
	reg clock, clear;

	// control register signals
	reg pci, pco;
	reg iri, iro;

	reg [31:0] pc, pc_immediate;
	reg [31:0] ir, ir_immediate;

	reg mari, maro;
	reg mdri, mdro;
	reg [31:0] mar_immediate, mdr_immediate;

	reg ryi, ryo;

	reg r0i, r0o;
	reg r1i, r1o;

	parameter 	Default = 4'b0000, 
				Reg_load1a = 4'b0001, 
				Reg_load1b = 4'b0010, 
				Reg_load2a = 4'b0011,
				Reg_load2b = 4'b0100, 
				Reg_load3a = 4'b0101, 
				Reg_load3b = 4'b0110, 
				T0 = 4'b0111,
				T1 = 4'b1000, 
				T2 = 4'b1001, 
				T3 = 4'b1010, 
				T4 = 4'b1011, 
				T5 = 4'b1100;

	reg [3:0] Present_state = Default;

	datapath DUT(
		.clock(clock), .clear(clear),

		.pci(pci),
		.pco(pco),

		.iri(iri),
		.iro(iro),

		.pc(pc),
		.pc_immediate(pc_immediate),

		.ir(ir),
		.ir_immediate(ir_immediate),

		.mari(mari), .maro(maro),
		.mdri(mdri), .mdro(mdro),

		.mar_immediate(mar_immediate),
		.mdr_immediate(mdr_immediate),

		.ryi(ryi),
		.ryo(ryo),

		.r0i(r0i), .r0o(r0o),
		.r1i(r1i), .r1o(r1o)
	);

	// add test logic here
	initial
	begin
		//$dumpfile("datapath.vcd");
		//$dumpvars;
		clock = 0;
		forever #10 clock = ~ clock;
	end

	always @(posedge clock) // finite state machine; if clock rising-edge
	begin
		case (Present_state)
		Default : Present_state = Reg_load1a;
		Reg_load1a : Present_state = Reg_load1b;
		Reg_load1b : Present_state = Reg_load2a;
		Reg_load2a : Present_state = Reg_load2b;
		Reg_load2b : Present_state = Reg_load3a;
		Reg_load3a : Present_state = Reg_load3b;
		Reg_load3b : Present_state = T0;
		T0 : Present_state = T1;
		T1 : Present_state = T2;
		T2 : Present_state = T3;
		T3 : Present_state = T4;
		T4 : Present_state = T5;

		endcase
	end

	always @(Present_state) // do the required job in each state
	begin
	case (Present_state) // assert the required signals in each clock cycle
	Default: begin
		// PCout <= 0; Zlowout <= 0; MDRout <= 0; // initialize the signals
		// R2out <= 0; R3out <= 0; MARin <= 0; Zin <= 0;
		// PCin <=0; MDRin <= 0; IRin <= 0; Yin <= 0;
		// IncPC <= 0; Read <= 0; AND <= 0;
		// R1in <= 0; R2in <= 0; R3in <= 0; Mdatain <= 32'h00000000;

		pci <= 0;
		pco <= 0;
		
		iri <= 0;
		iro <= 0;

		mari <= 0;
		mdri <= 0;

		maro <= 0;
		mdro <= 0;


		pc <= 0;
		pc_immediate <= 0;

		ir <= 0;
		ir_immediate <= 0;

		mar_immediate <= 0;
		mdr_immediate <= 0;

		ryi <= 0;
		ryo <= 0;

		r0i <= 0;
		r0o <= 0;

		r1i <= 0;
		r1o <= 0;
	end
	Reg_load1a: begin
		// Mdatain <= 32'h00000012;
		// Read = 0; MDRin = 0; // the first zero is there for completeness
		// #10 Read <= 1; MDRin <= 1;
		// #15 Read <= 0; MDRin <= 0;

		mdr_immediate <= 32'h0000_0003; // value to be rotated
		#10 mdri <= 1;
		#10 mdri <= 0;

	end
	Reg_load1b: begin
		// #10 MDRout <= 1; R2in <= 1;
		// #15 MDRout <= 0; R2in <= 0; // initialize R2 with the value $12

		#10 mdro <= 1; r0i <= 1;
		#10 mdro <= 0; r0i <= 0;
		

	end
	Reg_load2a: begin
		// Mdatain <= 32'h00000014;
		// #10 Read <= 1; MDRin <= 1;
		// #15 Read <= 0; MDRin <= 0;

		mdr_immediate <= 32'h0000_0002; // rotate amount
		#10 mdri <= 1;
		#10 mdri <= 0;

	end
	Reg_load2b: begin
		// #10 MDRout <= 1; R3in <= 1;
		// #15 MDRout <= 0; R3in <= 0; // initialize R3 with the value $14

		#10 mdro <= 1; r1i <= 1;
		#10 mdro <= 0; r1i <= 0;

	end
	Reg_load3a: begin
		// Mdatain <= 32'h00000018;
		// #10 Read <= 1; MDRin <= 1;
		// #15 Read <= 0; MDRin <= 0;

	end
	Reg_load3b: begin
		// #10 MDRout <= 1; R1in <= 1;
		// #15 MDRout <= 0; R1in <= 0; // initialize R1 with the value $18
		

	end
	T0: begin // see if you need to de-assert these signals
		// PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
		

		mdr_immediate <= {5'b01000, 27'b0};
		#10 mdri <= 1; 
	    #10 mdri <= 0;	
		
	end
	T1: begin
		// Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
		// Mdatain <= 32'h28918000; // opcode for “and R1, R2, R3”
		
		#10 mdro <= 1; iri <= 1;
		#10 mdro <= 0; iri <= 0;
	end
	T2: begin
		// MDRout <= 1; IRin <= 1;
		#10 r0o <= 1; ryi <= 1;
		#10 r0o <= 0; ryi <= 0;
		
		
	end
	T3: begin
		// R2out <= 1; Yin <= 1;
		
		#10 r1o <= 1; 
		#10 r1o <= 0;
	end
	T4: begin
		// R3out <= 1; AND <= 1; Zin <= 1;
	end
	T5: begin
		// Zlowout <= 1; R1in <= 1;

		//$finish;
	end
	endcase
	end
endmodule
