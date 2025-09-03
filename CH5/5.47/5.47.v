module Q47_Sequence(
    input Run,clk,rstn
);
    reg [3:0] state,next_state;
    parameter [3:0]
                S0 = 4'b0000, 
                S2 = 4'b0010, 
                S4 = 4'b0100, 
                S6 = 4'b0110, 
                S8 = 4'b1000, 
                S10 = 4'b1010, 
                S12 = 4'b1100, 
                S14 = 4'b1110;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            state <= S0;
        end
        else state <= next_state;
    end
    always @(state,Run) begin
        if (!Run) next_state = state;
        else if (state == S14)
            next_state = S0;
        else next_state = state + 4'b0010;
    end
endmodule

module Q47_Sequence_TB;
    reg Run,clk,rstn;
    Q47_Sequence M0 (Run,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #190 $finish;
    end
    initial fork 
        #0 {rstn,Run} = 2'b00;
        #10 Run = 1;
        #20 {rstn,Run} = 2'b10;
        #30 Run = 1;
        #60 Run = 0;
        #70 Run = 1;
        #130 Run = 0;
        #150 Run = 1;
        #170 rstn = 0;
        #180 Run = 0;
    join
    initial begin
        $dumpfile("5.47.vcd");
        $dumpvars(0,Q47_Sequence_TB);
    end
endmodule 