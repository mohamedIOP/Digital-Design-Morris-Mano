module Q40_Behavioral_5_18(
    input E,F,clk,rstn
);
    reg [1:0] state,next_state;
    parameter [1:0] S0 = 2'b00,S1 = 2'b01,S2 = 2'b10,S3 = 2'b11;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) state <= S0;
        else state <= next_state;
    end
    always @(state,E,F) begin
        if (E)
            if(F)
                case (state)
                    S0: next_state = S1;
                    S1: next_state = S2;
                    S2: next_state = S3;
                    S3: next_state = S0;
                endcase
            else
                case (state)
                    S0: next_state = S3;
                    S1: next_state = S0;
                    S2: next_state = S1;
                    S3: next_state = S2;
                endcase
        else next_state = state;
    end
endmodule
`timescale 1ps/1ps
module Q40_Behavioral_5_18_TB;
    reg E,F,clk,rstn;
    Q40_Behavioral_5_18 M0 (E,F,clk,rstn);
    initial begin
        #130 $finish;
    end
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial fork 
        #0 {rstn,E,F} = 3'b0xx;
        #10 rstn = 1;
        #20 {E,F} = 2'b00;
        #30 {E,F} = 2'b01;
        #40 {E,F} = 2'b10;
        #80 {E,F} = 2'b11;
    join
    initial begin
        $dumpfile("5.40.vcd");
        $dumpvars(0,Q40_Behavioral_5_18_TB);
    end
endmodule 