`timescale 1ps/1ps
module Q25_4_X_1_DFF (
    output reg Q,
    input D1,D2,D3,D4,S0,S1,clk,rstn,pstn
);
    wire D;
    assign D = S1 ? (S0 ? (D4) : (D3)) : (S0 ? (D2) : (D1));
    always @(posedge clk ,negedge rstn,negedge pstn) begin
        if(!rstn && !pstn) Q <= Q;
        else if (!rstn) Q <= 1'b0;
        else if (!pstn) Q <= 1'b1;
        else Q <= D;
    end
endmodule

module Q25_4_X_1_DFF_TB;
    wire Q;
    reg D1,D2,D3,D4,S0,S1,clk,rstn,pstn;
    Q25_4_X_1_DFF M0 (Q,D1,D2,D3,D4,S0,S1,clk,rstn,pstn);
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
        #0 pstn <= 0;#0 rstn <= 1;#0 {S1,S0} <= 2'b00;#0 {D4,D3,D2,D1} <= 4'b0000;
        #11 pstn <= 1;#11 rstn <= 1;#11 {S1,S0} <= 2'b00;#11 {D4,D3,D2,D1} <= 4'b0001;
        #21 pstn <= 1;#21 rstn <= 1;#21 {S1,S0} <= 2'b01;#21 {D4,D3,D2,D1} <= 4'b1101;
        #31 pstn <= 1;#31 rstn <= 1;#31 {S1,S0} <= 2'b10;#31 {D4,D3,D2,D1} <= 4'b0100;
        #41 pstn <= 1;#41 rstn <= 1;#41 {S1,S0} <= 2'b11;#41 {D4,D3,D2,D1} <= 4'b0111;
        #51 pstn <= 1;#51 rstn <= 1;#51 {S1,S0} <= 2'b00;#51 {D4,D3,D2,D1} <= 4'b1110;
        #61 pstn <= 1;#61 rstn <= 1;#61 {S1,S0} <= 2'b01;#61 {D4,D3,D2,D1} <= 4'b0010;
        #71 pstn <= 1;#71 rstn <= 1;#71 {S1,S0} <= 2'b10;#71 {D4,D3,D2,D1} <= 4'b1011;
        #81 pstn <= 1;#81 rstn <= 1;#81 {S1,S0} <= 2'b11;#81 {D4,D3,D2,D1} <= 4'b0111;
    join
    initial begin
        $dumpfile("5.25.vcd");
        $dumpvars(0,Q25_4_X_1_DFF_TB);
    end
endmodule