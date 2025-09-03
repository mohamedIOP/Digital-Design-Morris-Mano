`timescale 1ps/1ps
module Q26_JKFF(
    output reg Q,
    input J,K,clk,rstn,pstn
);
    always @(posedge clk,negedge rstn,negedge pstn) begin
        if (!rstn && !pstn) Q <= Q;
        else if (!rstn) Q <= 0;
        else if (!pstn) Q <= 1;
        else begin
            if (J && K) Q <= !Q;
            else if (J) Q <= 1;
            else if (K) Q <= 0;
            else Q <= Q;
        end
    end
endmodule

module Q26_JKFF_TB;
    wire Q;
    reg J,K,clk,rstn,pstn;
    Q26_JKFF M0 (.Q(Q),.J(J),.K(K),.clk(clk),.rstn(rstn),.pstn(pstn));
    initial begin
        #100 $finish;
    end
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial fork 
        #0 pstn = 0;#0 rstn = 1;#0 J = 0;#0 K = 0;
        #11 pstn = 1;#11 rstn = 0;#11 J = 0;#11 K = 0;
        #21 pstn = 0;#21 rstn = 0;#21 J = 0;#21 K = 0;
        #31 pstn = 1;#31 rstn = 1;#31 J = 0;#31 K = 0;
        #41 pstn = 1;#41 rstn = 1;#41 J = 1;#41 K = 0;
        #51 pstn = 1;#51 rstn = 1;#51 J = 0;#51 K = 1;
        #61 pstn = 1;#61 rstn = 1;#61 J = 1;#61 K = 1;
    join
    initial begin
        $dumpfile("5.26.vcd");
        $dumpvars(0,Q26_JKFF_TB);
    end
endmodule