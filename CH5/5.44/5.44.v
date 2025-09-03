module Q44_DFF(
    output reg Q,
    input D,clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if (!rstn) Q <= 0;
        else Q <= D;
    end
endmodule

module Q44_DFF_TB;
    wire Q;
    reg D,clk,rstn;
    Q44_DFF M0 (Q,D,clk,rstn);
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
        #0 rstn = 0;
        #20 rstn = 1;
        #30 D = 0;
        #40 D = 1;
        #50 D = 0;
        #70 rstn = 0;
        #80 D = 1;
        #90 D = 0;
    join
    initial begin
        $dumpfile("5.44.vcd");
        $dumpvars(0,Q44_DFF_TB);
    end
endmodule //5.44