
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
            
            // branch
            br3: begin
                #10 gra <= 1; rout <= 1; con_in <= 1;
                #10 gra <= 0; rout <= 0; con_in <= 0;
            end
            br4: begin
                #10 pco <= 1; ryi <= 1;
                #10 pco <= 0; ryi <= 0;
            end
            br5: begin
                #10 csigno <= 1; op_select <= 5'b00011; rzi <= 1;
                #10 csigno <= 0; op_select <= 5'b00011; rzi <= 0;
            end
        endcase
    end

endmodule
