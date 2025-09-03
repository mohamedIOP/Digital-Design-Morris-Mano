module Q47_Non_Equivalence (
    output reg P_odd,
    input D_in,clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) P_odd <= 0;
        else if (P_odd == D_in) P_odd <= 0;
        else P_odd <= 1;
    end
endmodule

module Q47_Non_Equivalence_TB;
    wire P_odd;
    reg D_in,clk,rstn;
    Q47_Non_Equivalence Model_Q47 (P_odd,D_in,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #90 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #10 rstn = 1;
        #60 rstn = 0;
        #70 rstn = 1;
        #10 D_in = 0;
        #20 D_in = 1;
        #30 D_in = 0;
        #40 D_in = 1;
        #60 D_in = 0;
        #80 D_in = 1;
    join
    initial begin
        $dumpfile("6.47.vcd");
        $dumpvars(0,Q47_Non_Equivalence_TB);
    end
endmodule