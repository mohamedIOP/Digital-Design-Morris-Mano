module Q38_A(
    output reg A,B,
    input x_in,clk,rstn
);
    reg [1:0] next_state;
    parameter [1:0] S0 = 2'b00,S1 = 2'b01,S2 = 2'b10,S3 = 2'b11;
    // setting current state
    always @(posedge clk or negedge rstn) begin
        if (!rstn) {A,B} <= S0;
        else {A,B} <= next_state;
    end
    // Operatting Next_State
    always @({A,B},x_in) begin
        if (x_in)
            case ({A,B})
                S0: next_state = S1;
                S1: next_state = S3;
                S2: next_state = S0;
                S3: next_state = S2;
            endcase
        else next_state = {A,B};
    end
endmodule

module Q38_B(
    output reg A,B,
    input x_in,clk,rstn
);
    reg [1:0] next_state;
    parameter [1:0] S0 = 2'b00,S1 = 2'b01,S2 = 2'b10,S3 = 2'b11;
    // setting current state
    always @(posedge clk or negedge rstn) begin
        if (!rstn) {A,B} <= S0;
        else {A,B} <= next_state;
    end
    // Operatting Next_State
    always @({A,B},x_in) begin
        if (x_in)
            case ({A,B})
                S0: next_state = S3;
                S1: next_state = S2;
                S2: next_state = S0;
                S3: next_state = S1;
            endcase
        else next_state = {A,B};
    end
endmodule
`timescale 1ps/1ps
module Q38_TB;
    wire A_A,B_A,A_B,B_B;
    reg x_in,clk,rstn;
    Q38_A M0 (A_A,B_A,x_in,clk,rstn);
    Q38_B M1 (A_B,B_B,x_in,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #100 $finish;
    end
    initial fork 
        #0 {rstn,x_in} = 2'b0x;
        #10 {rstn,x_in} = 2'b10;
        #20 x_in = 1;
        #30 x_in = 0;
        #40 x_in = 1;
        #50 x_in = 0;
        #60 x_in = 1;
        #70 x_in = 0;
        #80 x_in = 1;
    join
    initial begin
        $dumpfile("5.38.vcd");
        $dumpvars(0,Q38_TB);
    end
endmodule