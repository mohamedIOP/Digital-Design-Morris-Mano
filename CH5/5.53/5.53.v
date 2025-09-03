module Q53_Mealy(
    output reg y_out,
    input x_in,clk,rstn
);
    reg [1:0] state,next_state;
    parameter   [1:0] 
                S0 = 2'b00,
                S1 = 2'b01,
                S2 = 2'b10,
                S3 = 2'b11;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) state <= S0;
        else state <= next_state;
    end
    always @(state,x_in) begin
        case (state)
            S0: begin y_out = 0;if(x_in) next_state = S1; else next_state = S0; end
            S1: begin y_out = 0;if(x_in) next_state = S2; else next_state = S1; end
            S2: begin y_out = 1;if(x_in) next_state = S3; else next_state = S2; end
            S3: if(x_in) begin next_state = S1;y_out = 0;end else begin next_state = S3;y_out = 1;end 
        endcase
    end
endmodule