`timescale 1ns/1ps
//`include "datapath.v"

module datapath_store_tb();
	reg clock, clear;

	// control register signals
	reg pci, pco;
	reg iri, iro;

	reg [31:0] pc, pc_immediate;
	reg [31:0] ir, ir_immediate;

	reg mari, maro;
	reg mdri, mdro;
	reg mem_read, mem_write;
	
	reg opi, ipi, ipo;
	reg [31:0] input_unit;

	reg ryi, ryo;
	
	reg csigno;
	reg gra, grb, grc, rin, rout, baout;

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

		.ir(ir), .ir_immediate(ir_immediate),

		.mari(mari), .maro(maro),
		.mdri(mdri), .mdro(mdro),
		
		.opi(opi), .ipi(ipi), .ipo(ipo), .input_unit(input_unit),
		
		.mem_read(mem_read),
		.mem_write(mem_write),
		
		.ryi(ryi),
		.ryo(ryo),
		
		.csigno(csigno),
		
		.gra(gra),
		.grb(grb),
		.grc(grc),
		.rin(rin),
		.rout(rout),
		.baout(baout)
	);

	// add test logic here
	initial
	begin
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
		pci <= 0;
		pco <= 0;
		
		iri <= 0;
		iro <= 0;

		mari <= 0;
		mdri <= 0;

		maro <= 0;
		mdro <= 0;
		
		opi <= 0;
		ipi <= 0;
		ipo <= 0;
		input_unit <= 0;

		pc <= 0;
		pc_immediate <= 0;

		ir <= 0;

		mem_read <= 0;
		mem_write <= 0;

		ryi <= 0;
		ryo <= 0;
		
		csigno <= 0;
		
		gra <= 0;
		grb <= 0;
		grc <= 0;
		rin <= 0;
		rout <= 0;
		baout <= 0;

	end
	Reg_load1a: begin		
		// load address 0 into mar for first instruction
		#10 baout <= 1; mari <= 1;
		#10 baout <= 0; mari <= 0;	
	end
	Reg_load1b: begin
		// read instruction from memory into data register
		mem_read <= 1; mem_write <= 0;
		#10 mdri <= 1;
		#10 mdri <= 0; mem_read <= 0;
	end
	Reg_load2a: begin
		// load instruction from data register into ir
		#10 mdro <= 1; iri <= 1;
		#10 mdro <= 0; iri <= 0;
	end
	Reg_load2b: begin		
		// load hardcoded value into ra (r1)
		#10 gra <= 1; rin <= 1;
		#10 gra <= 0; rin <= 0;	
	end
	Reg_load3a: begin
		// output value of ra (r1) onto bus
		#10 gra <= 1; rout <= 1;
		#10 gra <= 0; rout <= 0;
	end
	Reg_load3b: begin
		// load value from bus into mdr, mem_read is select of mdr mux
		#10 mem_read <= 0; mdri <= 1;
		#10 mdri <= 0;
	end
	T0: begin // see if you need to de-assert these signals
		// load address from ir into mari for store instruction
		#10 csigno <= 1; mari <= 1;
		#10 csigno <= 0; mari <= 0;
	end
	T1: begin
		// write value of mdr into ram
		mem_write <= 1;
	end
	T2: begin
		// deassert write signal
		#10 mem_write <= 0;
	end
	T3: begin
	end
	T4: begin
	end
	T5: begin
	end
	endcase
	end
endmodule
