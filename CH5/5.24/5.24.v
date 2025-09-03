module Q24_DFF_Postive_Edge_Present_Reset (
    output reg Q,
    input D,clk,rstn,pstn
);
    always @(posedge clk,negedge rstn,negedge pstn) begin
        if(!rstn && !pstn) Q <= Q;
        else if(!rstn) Q <= 1'b0;
        else if(!pstn) Q <= 1'b1;
        else Q <= D;
    end
endmodule

module Q24_DFF_Postive_Edge_Present_Reset_TB;
    wire Q;
    reg D,clk,rstn,pstn;
    Q24_DFF_Postive_Edge_Present_Reset M0 (Q,D,clk,rstn,pstn);
    initial begin
        #100 $finish;
    end
    initial begin 
        clk = 0; forever #5 clk = ~clk;
    end
    initial fork 
        #0 rstn <= 0;
        #0 pstn <= 1;
        #0 D = 0;
        #10 rstn <= 1;
        #10 pstn <= 0;
        #10 D = 0;
        #20 rstn <= 1;
        #20 pstn <= 1;
        #20 D = 0;
        #40 rstn <= 1;
        #40 pstn <= 1;
        #40 D = 1;
        #50 rstn <= 1;
        #50 pstn <= 1;
        #50 D = 0;
        #60 rstn <= 0;
        #60 pstn <= 0;
        #60 D = 0;
        #70 rstn <= 0;
        #70 pstn <= 0;
        #70 D = 1;
    join
    initial begin
        $dumpfile("5.24.vcd");
        $dumpvars(0,Q24_DFF_Postive_Edge_Present_Reset_TB);
    end
endmodule