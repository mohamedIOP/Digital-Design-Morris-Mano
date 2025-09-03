module Q46(
    output reg y_out,
    input x_in,clk,rstn
);
    reg [2:0] state,next_state;
    parameter   [2:0] 
                S0 = 3'b000,
                S1 = 3'b001,
                S2 = 3'b010,
                S3 = 3'b011,
                S4 = 3'b100,
                S5 = 3'b101;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) state <= S0;
        else state <= next_state;
    end
    always @(state,x_in,rstn) begin
        if (!rstn) 
            next_state = S0;
        else
            if (state == S0) begin
                if (x_in) 
                    next_state = S1;
                else
                    next_state = S0;
            end
            else if (state == S5)
                next_state = S0;
            else
                next_state = state + 3'b001;
    end
    always @(state) begin
        case (state)
            S0,S4,S5: y_out = 0;
            S1,S2,S3: y_out = 1;
        endcase
    end
endmodule
`timescale 1ps/1ps
module Q46_TB;
    wire y_out;
    reg x_in,clk,rstn;
    Q46 M0 (y_out,x_in,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #220 $finish;
    end
    initial fork 
        #0 {rstn,x_in} = 2'b00;
        #10 x_in = 1;
        #20 {rstn,x_in} = 2'b10;
        #30 x_in = 1;
        #50 x_in = 0;
        #70 x_in = 1;
        #80 x_in = 0;
        #100 x_in = 1;
        #190 rstn = 0;
        #200 rstn = 1;
        #210 {rstn,x_in} = 2'b00;
    join
    initial begin
        $dumpfile("5.46.vcd");
        $dumpvars(0,Q46_TB);
    end
endmodule 