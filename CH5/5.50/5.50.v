module Q50_Moore_Machine (
    output reg y_out,
    input x_in,clk,rstn
);
    reg flag;
    reg [1:0] state,next_state;
    parameter [1:0] s_a = 2'd0,s_b = 2'd1,s_c = 2'd2;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            flag <= 0;
            state <= s_a;
        end
        else state <= next_state;
    end
    always @(state,x_in,flag) begin
        case (state)
            s_a:    if (rstn && x_in && flag)
                        next_state = s_b; 
                    else next_state = s_a;
            s_b:    if(x_in) next_state = s_c;
                    else     next_state = s_b;
            s_c:    if (x_in) next_state = s_a;
                    else next_state = s_c;
        endcase
    end
    always @(posedge clk) begin
        case (state)
            s_a: if (rstn && x_in && !flag) flag = 1;
            s_c: if(x_in) flag = 0;
        endcase
    end
    always @(state) begin
        if(state == s_a) y_out = 0;
        else y_out = 1;
    end
endmodule 
`timescale 1ps/1ps
module Q50_Moore_Machine_TB;
    wire y_out;
    reg x_in,clk,rstn;
    Q50_Moore_Machine M0 (y_out,x_in,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #180 $finish;
    end
    initial fork 
        #0 {rstn,x_in} = 2'b00;
        #10 x_in = 1;
        #20 {rstn,x_in} = 2'b10;
        #30 x_in = 1;
        #50 x_in = 0;
        #60 x_in = 1;
        #70 x_in = 0;
        #80 x_in = 1;
        #90 x_in = 0;
        #100 x_in = 1;
        #110 x_in = 0;
        #120 x_in = 1;
        #130 rstn = 0;
        #140 rstn = 1;
    join
    initial begin
        $dumpfile("5.50.vcd");
        $dumpvars(0,Q50_Moore_Machine_TB);
    end
endmodule