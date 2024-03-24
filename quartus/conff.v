
module conff(
    input wire clock,
    input wire [31:0] bus,
    input wire [31:0] ir,
    input wire con_in,
    output wire con
);

    integer i;
    reg not_zero;
    reg negative;
    reg con_state;

    always @(posedge clock)
    begin
        not_zero = 0;        
        for(i = 0; i < 30; i = i + 1) begin
           not_zero = not_zero | bus[i]; 
        end 

        negative = bus[31]; 

		if (ir[20:19] == 0) 
            con_state = ~not_zero; 
        else if (ir[20:19] == 1) 
            con_state = not_zero; 
        else if (ir[20:19] == 2) 
            con_state = ~negative; 
        else if (ir[20:19] == 3) 
            con_state = negative; 
    end

    assign con = con_state & con_in;

endmodule
