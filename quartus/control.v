<<<<<<< HEAD
`timescale 1ns/10ps

module control_unit (
output reg clear, pci, pco, iri, iro, mari, maro, mdri, mdro, mem_read, mem_write, 
opi, ipi, ipo, hii, hio, loi, loo, 
ryi, ryo, rzhi, rzli, rzho, rzlo, rzo, csigno, gra, grb, grc, rin, rout, baout, 

//ALU modules??? input unit?

input [31:0] IR, 
input clock, reset, stop, conff
);
 
	parameter reset_state = 4'b0000, 
				 fetch0 = 4'b0001, 
				 fetch1 = 4'b0010, 
				 fetch2 = 4'b0011,
				 add3 = 4'b0100, 
				 add4 = 4'b0101, 
				 add5 = 4'b0110, 
				 add6 = 4'b0111;
				 
	reg [3:0] present_state = reset_state; 

	always @(posedge clock, posedge reset)begin

		if (Reset == 1'b1) present_state = reset_state;
		else case (present_state)
		
			reset_state: present_state = fetch0;
			fetch0: present_state = fetch1;
			fetch1: present_state = fetch2;
			fetch2: begin
				case (IR[31:27]) 
					5’b00011: present_state = add3; 
				endcase
			end
			add3: present_state = add4;
			add4: present_state = add5;
			add5: present_state = add6;
			
		endcase
	 end
		 
	always @(present_state)begin
	 case (present_state) 
		reset_state: begin
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

			mem_read <= 0;
			mem_write <= 0;
			
			hii <= 0;
			hio <= 0;
			loi <= 0;
			loo <= 0;

			ryi <= 0;
			ryo <= 0;
			
			rzhi <= 0;
			rzli <= 0;
			rzho <= 0;
			rzlo <= 0;
			rzo <= 0;
			
			csigno <= 0;
			gra <= 0;
			grb <= 0;
			grc <= 0;
			rin <= 0;
			rout <= 0;
			baout <= 0;
		
		end
		fetch0: begin
			#10 baout <= 1; mari <= 1;
			#10 baout <= 0; mari <= 0;	
		end
		fetch1: begin
			mem_read <= 1; mem_write <= 0;
			#10 mdri <= 1;
			#10 mdri <= 0; mem_read <= 0;
		end
		fetch2: begin
			#10 mdro <= 1; iri <= 1;
			#10 mdro <= 0; iri <= 0;
		end
		add3: begin
			#10 grb <= 1; rin <= 1; 
			#10 grb <= 0; rin <= 0; 
		end
		add4: begin
			#10 grb <= 1; rout <= 1; ryi <= 1;
			#10 grb <= 0; rout <= 0; ryi <= 0; 
		end
		add5: begin
			#10 csigno <= 1; rzli <= 1;
			#10 csigno <= 0; rzli <= 0;
		end
		add6: begin
			#10 rzlo <= 1; rin <= 1; gra = 1;
			#10 rzlo <= 0; rin <= 0; gra = 0;
		end
	 endcase
	end
endmodule 
=======

module control(
    input clock, reset, 
    input [31:0] ir,

    // control signals required
    output reg pci, pco,
    output reg mari, maro
);

    parameter   reset_state = 4'b0000,
                fetch0_state = 4'b0001;
    
    reg [3:0] current_state = reset_state;

    always @(posedge clock, reset) begin
        if(reset == 1'b1) current_state = reset_state;
        else case (current_state)
            reset_state:    current_state  = fetch0_state;
            fetch0_state:   current_state  = reset_state;
        endcase 
    end    

    always @(current_state) begin
        case(current_state)
            reset_state: begin
                #10 pco <= 0; mari <= 0;
            end 
            fetch0_state: begin
                #10 pco <= 1; mari <= 1;
                #10 pco <= 0; mari <= 0;
            end
        endcase
    end

endmodule
>>>>>>> 25b3e560d222dc3a24f35c36873cccb4bdf5757f
