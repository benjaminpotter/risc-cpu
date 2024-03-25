
module control(
    input clock, reset, 
    input [31:0] ir,

    // control signals required
    input pci, pco,
    input mari, maro
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

            end 
            fetch0_state: begin
                pco <= 1;
               
                
            end
        endcase
    end

endmodule
