module Q42_DFF(
    output reg Q,
    input D,clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if (!rstn) Q <= 0;
        else Q <= D;
    end
endmodule

module Q42_Fig_5_29(
    output A,B,
    output Y,
    input x,clk,rstn
);
    wire B_Bar,A_and_X,B_and_X,B_Bar_and_X,D_A,D_B;
    not (B_Bar,B);
    and (Y,A,B),(A_and_X,A,x),(B_and_X,B,x),(B_Bar_and_X,B_Bar,x);
    or (D_A,A_and_X,B_and_X),(D_B,A_and_X,B_Bar_and_X);
    Q42_DFF M0 (A,D_A,clk,rstn);
    Q42_DFF M1 (B,D_B,clk,rstn);
endmodule

module Q42_Fig_5_29_TB;
    wire A,B,Y;
    reg x,clk,rstn;
    Q42_Fig_5_29 MM0 (A,B,Y,x,clk,rstn);
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
        #0 {rstn,x} = 2'b00;
        #10 rstn = 1;
        #20 x = 1;
        #70 x = 0;
    join
    initial begin
        $dumpfile("5.42.vcd");
        $dumpvars(0,Q42_Fig_5_29_TB);
    end
endmodule