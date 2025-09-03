module Q36_TFF(
    output reg Q,
    input T,clk,rstn
);
    always @(posedge clk,negedge rstn) begin
        if (!rstn) Q <= 0;
        else if (T)
            Q <= ~Q;
        else
            Q <= Q;
    end
endmodule

module Q36_P5_8(
    output A,A_BAR,B,
    input clk,rstn
);
    assign A_BAR = ~A;
    wire A_BAR_OR_B,A_OR_B;
    or  (A_BAR_OR_B,A_BAR,B),
        (A_OR_B,A,B);
    Q36_TFF M0 (A,A_OR_B,clk,rstn);
    Q36_TFF M1 (B,A_BAR_OR_B,clk,rstn);
endmodule
`timescale 1ps/1ps
module Q36_P5_8_TB;
    wire A,A_BAR,B;
    reg clk,rstn;
    Q36_P5_8 M0 (A,A_BAR,B,clk,rstn);
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
        rstn = 0;
        #10 rstn = 1;
    join
    initial begin
        $dumpfile("5.36.vcd");
        $dumpvars(0,Q36_P5_8_TB);
    end
endmodule