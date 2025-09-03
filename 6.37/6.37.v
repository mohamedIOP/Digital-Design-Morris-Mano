module Q37_A (
    output reg [2:0] A,
    input clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) A <= 3'b000;
        else if (A == 3'd0) A <= 3'd1;
        else if (A == 3'd1) A <= 3'd3;
        else if (A == 3'd3) A <= 3'd7;
        else if (A == 3'd7) A <= 3'd6;
        else if (A == 3'd6) A <= 3'd4;
        else if (A == 3'd4) A <= 3'd0;
        else A <= 3'bxxx;
    end
endmodule

module Q37_B (
    output reg [2:0] A,
    input clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) A <= 3'd0;
        else 
            case (A)
                3'd0: A <= 3'd1;
                3'd1: A <= 3'd3;
                3'd3: A <= 3'd7;
                3'd7: A <= 3'd6;
                3'd6: A <= 3'd4;
                3'd4: A <= 3'd0;
            endcase
    end
endmodule

module Q37_C (
    output reg [2:0] A,
    input clk,rstn
);
    reg [2:0] next_state;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) A <= 3'd0;
        else A <= next_state;
    end
    always @(A) begin
        case (A)
            3'd0: next_state <= 3'd1;
            3'd1: next_state <= 3'd3;
            3'd3: next_state <= 3'd7;
            3'd7: next_state <= 3'd6;
            3'd6: next_state <= 3'd4;
            3'd4: next_state <= 3'd0;
        endcase
    end
endmodule
`timescale 1ns/1ps
module Q37_TB;
    wire [2:0] A_IF_ELSE_A,A_CASE_B,A_FSM_C;
    reg clk,rstn;
    Q37_A Model_A (A_IF_ELSE_A,clk,rstn);
    Q37_B Model_B (A_CASE_B,clk,rstn);
    Q37_C Model_C (A_FSM_C,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #130 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #10 rstn = 1;
        #90 rstn = 0;
        #100 rstn = 1;
    join
    initial begin
        $dumpfile("6.37.vcd");
        $dumpvars(0,Q37_TB);
    end
endmodule 