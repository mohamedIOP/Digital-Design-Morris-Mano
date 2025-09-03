module Q54 (
    output  y_out,
    input x_in_one,x_in_two,clk,rstn
);
    parameter S0 = 0,S1 = 1;
    reg state,next_state;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) state <= S0;
        else state <= next_state;
    end
    always @(state,x_in_one,x_in_two) begin
        case (state)
            S0: if(x_in_one == x_in_two) next_state = S1;else next_state = S0;
            S1: if(x_in_one == x_in_two) next_state = S1;else next_state = S0;
        endcase
    end
    assign y_out = (state == S1);
endmodule