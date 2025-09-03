module Q45_Behavioral (
    output reg [2:0] A,
    input clk,rstn
);
    reg [2:0] next_state;
    parameter   [2:0]
                S0 = 3'd0,
                S1 = 3'd1,
                S3 = 3'd3,
                S7 = 3'd7,
                S6 = 3'd6,
                S4 = 3'd4;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) A <= 3'b0;
        else A <= next_state;
    end
    always @(A) begin
        case (A)
            S0: next_state = S1;
            S1: next_state = S3;
            S3: next_state = S7;
            S7: next_state = S6;
            S6: next_state = S4;
            S4: next_state = S0;
            default: next_state = S0;
        endcase
    end
endmodule 

module Q45_TB;
    wire [2:0] A;
    reg clk,rstn;
    Q45_Behavioral M0 (A,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #150 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #20 rstn = 1;
        #90 rstn = 0;
        #110 rstn = 1;
    join
    initial begin
        $dumpfile("6.45.vcd");
        $dumpvars(0,Q45_TB);
    end
endmodule 