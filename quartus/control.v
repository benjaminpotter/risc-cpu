`timescale 1ns/10ps

module control(
    input clock, reset, 
    input [31:0] ir,

    // control signals required
    output reg pci, pco,
	 output reg iri, iro,
    output reg mari, maro,
	 output reg mdri, mdro,
	 output reg mem_read, mem_write,
	 output reg opi, ipi, ipo,
	 output reg hii, hio, loi, loo,
	 output reg ryi, ryo,
	 output reg rzhi, rzli, rzho, rzlo, rzo,
	 output reg gra, grb, grc, rin, rout, baout,
	 output reg csigno
);

    parameter   reset_state = 8'b00000000,
                fetch0 = 8'b00000001,
					 fetch1 = 8'b00000010,
					 fetch2 = 8'b00000011,

					 shr3 = 8'b00000100,
					 shr4 = 8'b00000101,
					 shr5 = 8'b00000110,
					 shr6 = 8'b00000111,
					 shr7 = 8'b00001000,
					 
					 shl3 = 8'b00001001,
					 shl4 = 8'b00001010,
					 shl5 = 8'b00001011,
					 shl6 = 8'b00001100,
					 shl7 = 8'b00001101,
					 
					 shra3 = 8'b00001110,
					 shra4 = 8'b00001111,
					 shra5 = 8'b00010000,
					 shra6 = 8'b00010001,
					 shra7 = 8'b00010010,
					 
					 and3 = 8'b000010011,
					 and4 = 8'b000010100,
					 and5 = 8'b000010101,
					 and6 = 8'b000010110,
					 and7 = 8'b000010111,
					 
					 or3 = 8'b00011000,
					 or4 = 8'b00011001,
					 or5 = 8'b00011010,
					 or6 = 8'b00011011,
					 or7 = 8'b00011100,
					 
					 ror3 = 8'b00011101,
					 ror4 = 8'b00011110,
					 ror5 = 8'b00011111,
					 ror6 = 8'b00100000,
					 ror7 = 8'b00100001,
					 
					 rol3 = 8'b00100010,
					 rol4 = 8'b00100011,
					 rol5 = 8'b00100100,
					 rol6 = 8'b00100101,
					 rol7 = 8'b00100110,
					 
					 mul3 = 8'b00100111,
					 mul4 = 8'b00101000,
					 mul5 = 8'b00101001,
					 mul6 = 8'b00101010,
					 mul7 = 8'b00101011,
					 mul8 = 8'b00101100,
					 
					 div3 = 8'b00101101,
					 div4 = 8'b00101110,
					 div5 = 8'b00101111,
					 div6 = 8'b00110000,
					 div7 = 8'b00110001,
					 div8 = 8'b00110010,
					
					 ld3 = 8'b00110011,
					 ld4 = 8'b00110100,
					 ld5 = 8'b00110101,
					 
					 ldi3 = 8'b00110110,
					 ldi4 = 8'b00110111;
					 // ESES not going to add mine yet
    
    reg [3:0] current_state = reset_state;

    always @(posedge clock, posedge reset) begin
        if(reset == 1'b1) current_state = reset_state;
        else case (current_state)
            reset_state:    current_state  = fetch0;
            fetch0:   current_state  = fetch1;
				fetch1:	 current_state = fetch2;
				fetch2:   begin
			                       case(ir[31:27])
										      5'b00101: current_state = shr3;
												5'b00110: current_state = shra3;
												5'b00111: current_state = shl3;
												5'b01000: current_state = ror3;
												5'b01001: current_state = rol3;
												5'b01010: current_state = and3;
												5'b01011: current_state = or3;
												5'b01111: current_state = mul3;
												5'b10000: current_state = div3;
												//5'b01100: current_state = addi3;
												5'b00000: current_state = ld3;
												5'b00001: current_state= ldi3;

										  endcase
								    end
				shr3:           current_state = shr4;
				shr4:           current_state = shr5;
				shr5:           current_state = shr6;
				shr6:           current_state = shr7;
				shr7:           current_state = fetch0;
				
				shl3:           current_state = shl4;
				shl4:           current_state = shl5;
				shl5:           current_state = shl6;
				shl6:           current_state = shl7;
				shl7:           current_state = fetch0;
				
				shra3:          current_state = shra4;
				shra4:          current_state = shra5;
				shra5:          current_state = shra6;
				shra6:          current_state = shra7;
				shra7:          current_state=  fetch0;
				
				ror3:           current_state = ror4;
				ror4:           current_state = ror5;
				ror5:           current_state = ror6;
				ror6:           current_state = ror7;
				ror7:           current_state = fetch0;
				
				rol3:           current_state = rol4;
				rol4:           current_state = rol5;
				rol5:           current_state = rol6;
				rol6:           current_state = rol7;
				rol7:           current_state = fetch0;
				
				mul3:           current_state = mul4;
				mul4:           current_state = mul5;
				mul5:           current_state = mul6;
				mul6:           current_state = mul7;
				mul7:           current_state = mul8;
				mul8:           current_state = fetch0;
				
				div3:           current_state = div4;
				div4:           current_state = div5;
				div5:           current_state = div6;
				div6:           current_state = div7;
				div7:           current_state = div8;
				div8:           current_state = fetch0;
				
				//addi3:           current_state = addi4;
				//addi4:           current_state = addi5;
				//addi5:           current_state = addi6;
				//addi6:           current_state = fetch0;
				
				ld3:           current_state = ld4;
				ld4:           current_state = ld5;
				ld5:           current_state = fetch0;
				
				ldi3:           current_state = ldi4;
				ldi4:           current_state = fetch0;
				

        endcase
    end    

    always @(current_state) begin
        case(current_state)
            reset_state: begin
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
                #10 pco <= 1; mari <= 1;
                #10 pco <= 0; mari <= 0;
            end
				fetch1: begin
				    #10 mem_read <= 1; mdri <= 1;
					 #10 mem_read <= 0; mdri <= 0;
				end
				fetch2: begin
				    #10 mdro <= 1; iri <= 1;
					 #10 mdro <= 0; iri <= 0;
				end
//---------------- BRANCH ----------------------------------------
//            br3: begin
//                #10 gra <= 1; rout <= 1; con_in <= 1;
//                #10 gra <= 0; rout <= 0; con_in <= 0;
//            end
//            br4: begin
//                #10 pco <= 1; ryi <= 1;
//                #10 pco <= 0; ryi <= 0;
//            end
//            br5: begin
//                #10 csigno <= 1; op_select <= 5'b00011; rzi <= 1;
//                #10 csigno <= 0; op_select <= 5'b00011; rzi <= 0;
//            end
//---------------- AND, OR, SHR, SHL, SHRA, ROR, ROL --------------
				and3, or3, shr3, shl3, shra3, ror3, rol3: begin
				    #10 grc <= 1; rin <= 1;
				    #10 grc <= 0; rin <= 0;
				end
				and4, or4, shr4, shl4, shra4, ror4, rol4: begin
				    #10 grc <= 1; rout <= 1; ryi <= 1;
				    #10 grc <= 0; rout <= 0; ryi <= 0;
				end
				and5, or5, shr5, shl5, shra5, ror5, rol5: begin
				    #10 grb <= 1; rin <= 1; 
				    #10 grb <= 0; rin <= 0;
				end
				and6, or6, shr6, shl6, shra6, ror6, rol6: begin
				    #10 grb <= 1; rout <= 1; rzli <= 1;
				    #10 grb <= 0; rout <= 0; rzli <= 0;
				end
				and7, or7, shr7, shl7, shra7, ror7, rol7: begin
				    #10 rzlo <= 1; rin <= 1; gra = 1;
				    #10 rzlo <= 0; rin <= 0; gra = 0;
				end
//--------------------DIV, MUL ------------------------------------
				div3, mul3: begin
				    #10 gra <= 1; rin <= 1;
					 #10 gra <= 0; rin <= 0;
				end
				div4, mul4: begin
				    #10 grb <= 1; rin <= 1;
					 #10 grb <= 0; rin <= 0;
				end
				div5, mul5: begin
				    #10 gra <= 1; rout <= 1; ryi <= 1;
				    #10 gra <= 0; rout <= 0; ryi <= 0;
				end
				div6, mul6: begin
				    #10 grb <= 1; rout <= 1; rzli <= 1; rzhi <= 1; // ESES does this work??
				    #10 grb <= 0; rout <= 0; rzli <= 0; rzhi <= 0;
				end
				div7, mul7: begin
				    #10 rzlo <= 1; loi <= 1;
					 #10 rzlo <= 0; loi <= 0;
				end
				div8, mul8: begin
				    #10 rzho <= 1; hii <= 1;
					 #10 rzho <= 0; hii <= 0;
				end
//-------------------- LOAD ----------------------------------------
				ld3: begin
				    #10 csigno <= 1; mari <= 1;
				    #10 csigno <= 0; mari <= 0;
				end
				ld4: begin
				    #10 mem_read <= 1; mdri <= 1;
		          #10 mem_read <= 0; mdri <= 0;
				end
				ld5: begin
				    #10 mdro <= 1; gra <= 1; rin <= 1;
		          #10 mdro <= 0; gra <= 0; rin <= 0;
				end
////-------------------- LOAD IMM-------------------------------------
				ldi3: begin
				    #10 mdri <= 1; csigno <= 1;
				    #10 mdri <= 0; csigno <= 0;
				end
				ldi4: begin
				    #10 mdro <= 1; gra <= 1; rin <= 1;
				    #10 mdro <= 0; gra <= 0; rin <= 0;
				end
////-------------------- STORE ---------------------------------------
//				st3: begin
//				    #10 gra <= 1; rin <= 1;
//				    #10 gra <= 0; rin <= 0;
//				end
//				st4: begin
//				    #10 gra <= 1; rout <= 1;
//				    #10 gra <= 0; rout <= 0;
//				end
//				st5: begin
//				    #10 mem_read <= 0; mdri <= 1;
//				    #10 mdri <= 0;
//				end
//				st6: begin
//				    #10 csigno <= 1; mari <= 1;
//				    #10 csigno <= 0; mari <= 0;
//				end
//				st7: begin
//				    #10 mem_write <= 1;
//					 #10 mem_write <= 0;
//				end
////-------------------- STORE INDEX ---------------------------------------
//				stind3: begin
//				    #10 grb <= 1; rin <= 1; 
//				    #10 grb <= 0; rin <= 0;
//				end
//				stind4: begin
//				    #10 gra <= 1; rin <= 1; 
//				    #10 gra <= 0; rin <= 0;
//				end
//				stind5: begin
//				    #10 grb <= 1; rout <= 1; ryi <= 1;
//				    #10 grb <= 0; rout <= 0; ryi <= 0;
//				end
//				stind6: begin
//				    #10 csigno <= 1; rzli <= 1;
//				    #10 csigno <= 0; rzli <= 0;
//				end
//				stind7: begin
//				    #10 rzlo <= 1; mari <= 1;
//				    #10 rzlo <= 0; mari <= 0;
//				end
//				stind8: begin
//				    #10 gra <= 1; rout <= 1; mem_read <= 0; mdri <= 1;
//				    #10 gra <= 0; rout <= 0; mdri <= 0;
//				end
//				stind9: begin
//				    #10 mem_write <= 1;
//					 #10 mem_write <= 0;
//				end
				
        endcase
    end

endmodule
