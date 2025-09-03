module Q49_Moore_FSM (
    output reg y_out,
    input x_in,clk,rstn
);
    reg [1:0] state,next_state;
    parameter a = 2'd0,b = 2'd1,c = 2'd2,d = 2'd3;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) state <= a;
        else state <= next_state;
    end
    always @(state,x_in) begin
        case (state)
            a: if(x_in) next_state = c; else next_state = b; 
            b: if(x_in) next_state = d; else next_state = c; 
            c: if(x_in) next_state = d; else next_state = b; 
            d: if(x_in) next_state = a; else next_state = c; 
        endcase
    end
    always @(state) begin
        if (state == a || state == d) y_out = 0;
        else y_out = 1;
    end
endmodule 
`timescale 1ps/1ps
module Q49_Moore_FSM_TB;
    wire y_out;
    reg x_in,clk,rstn;
    Q49_Moore_FSM M0 (y_out,x_in,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #400 $finish;
    end
    initial fork
        #0 {rstn,x_in} = 2'b00;
        #10 {rstn,x_in} = 2'b01;
        #20 {rstn,x_in} = 2'b10;
        #100 rstn = 0;
        #110 {rstn,x_in} = 2'b11;
        #200 rstn = 0;
        #210 {rstn,x_in} = 2'b10;
        #220 x_in = 1;
        #300 rstn = 0;
        #310 {rstn,x_in} = 2'b11;
        #330 x_in = 0;
    join
    initial begin
        $dumpfile("5.49.vcd");
        $dumpvars(0,Q49_Moore_FSM_TB);
    end
endmodule