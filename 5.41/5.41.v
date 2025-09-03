module Q41_Behavioral_5_19(
    output reg y_out,
    input x_in,clk,rstn
);
    reg [2:0] state,next_state;
    parameter [2:0]
                S0 = 3'b000,
                S1 = 3'b001,
                S2 = 3'b010,
                S3 = 3'b011,
                S4 = 3'b100;
    // Change Current State
    always @(posedge clk or negedge rstn) begin
        if(!rstn) state <= S0;
        else state <= next_state;
    end
    // Next State
    always @(state,x_in) begin
        case (state)
            S0: 
                if(x_in) next_state = S4;
                else next_state = S3;
            S1: 
                if(x_in) next_state = S4;
                else next_state = S1;
            S2: 
                if(x_in) next_state = S0;
                else next_state = S2;
            S3: 
                if(x_in) next_state = S1;
                else next_state = S2;
            S4: 
                if(x_in) next_state = S3;
                else next_state = S2;
            default: next_state = S0;
        endcase
    end
    // Output
    always @(state,x_in) begin
        if(state == S4) y_out = 0;
        else y_out = x_in;
    end
endmodule

`timescale 1ps/1ps
module Q41_Behavioral_5_19_TB;
    wire y_out;
    reg x_in,clk,rstn;
    Q41_Behavioral_5_19 M0 (y_out,x_in,clk,rstn);
    initial begin
        #100 $finish;
    end
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial fork 
        #0 {rstn,x_in} = 2'b0x;
        #10 {rstn,x_in} = 2'b10;
        #40 x_in = 1;
        #60 x_in = 0;
        #70 x_in = 1;
    join
    initial begin
        $dumpfile("5.41.vcd");
        $dumpvars(0,Q41_Behavioral_5_19_TB);
    end
endmodule 