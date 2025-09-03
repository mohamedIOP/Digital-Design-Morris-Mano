module Q31_Four_Bit_Register(
    output reg [3:0] A,
    input [3:0] I,
    input clk,rstn 
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) A <= 4'b0000;
        else
            A <= I;
    end
endmodule

module Q31_Four_Bit_Register_TB;
    wire [3:0] A;
    reg [3:0] I;
    reg clk,rstn;
    Q31_Four_Bit_Register M0 (A,I,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #60 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #10 I = 4'b1010;
        #20 rstn = 1;
        #30 I = 4'b1100;
        #40 rstn = 0;
        #50 rstn = 1;
    join
    initial begin
        $dumpfile("6.31.vcd");
        $dumpvars(0,Q31_Four_Bit_Register_TB);
    end
endmodule