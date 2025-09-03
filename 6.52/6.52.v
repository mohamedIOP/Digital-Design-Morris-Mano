module Q52_Shift_Register_Structural (
    output [3:0] A,
    input [1:0] S,
    input [3:0] I,
    input MSB_in,LSB_in,
    input clk,rstn
);
    wire [3:0] y;
    Q52_4_X_1_MUX Stage_Three_Mux (y[3],S,{I[3],A[2],MSB_in,A[3]});
    Q52_4_X_1_MUX Stage_Two_Mux (y[2],S,{I[2],A[1],A[3],A[2]});
    Q52_4_X_1_MUX Stage_One_Mux (y[1],S,{I[1],A[0],A[2],A[1]});
    Q52_4_X_1_MUX Stage_Zero_Mux (y[0],S,{I[0],LSB_in,A[1],A[0]});

    Q52_DFF Stage_Three_DFF (A[3],y[3],clk,rstn);
    Q52_DFF Stage_Two_DFF (A[2],y[2],clk,rstn);
    Q52_DFF Stage_One_DFF (A[1],y[1],clk,rstn);
    Q52_DFF Stage_Zero_DFF (A[0],y[0],clk,rstn);
endmodule

module Q52_4_X_1_MUX (
    output Y,
    input [1:0] S,
    input [3:0] I
);
    assign Y = S[1] ? (S[0] ? (I[3]) : (I[2])) : (S[0] ? (I[1]) : (I[0]));
endmodule 

module Q52_DFF (
    output reg Q,
    input D,clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Q <= 0;
        else Q <= D;
    end
endmodule 


module Q52_Shift_Register_Structural_TB;
    wire [3:0] A;
    reg [1:0] S;
    reg [3:0] I;
    reg MSB_in,LSB_in,
        clk,rstn;
    Q52_Shift_Register_Structural Model_Structural (A,S,I,MSB_in,LSB_in,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #180 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #40 rstn = 1;
        #90 rstn = 0;
        #100 rstn = 1;
        #150 rstn = 0;
        #160 rstn = 1;
        #0 I = 4'b1010;
        #170 I = 4'b0011;
        #0 S = 2'b00;
        #10 S = 2'b01;
        #20 S = 2'b10;
        #30 S = 2'b11;
        #40 S = 2'b00;
        #50 S = 2'b01;
        #100 S = 2'b10;
        #160 S = 2'b11;
        #0 {MSB_in,LSB_in} = 2'b11;
        #50 {MSB_in,LSB_in} = 2'b10;
        #100 {MSB_in,LSB_in} = 2'b00;
        #110 {MSB_in,LSB_in} = 2'b01;
    join
    initial begin
        $dumpfile("6.52.vcd");
        $dumpvars(0,Q52_Shift_Register_Structural_TB);
    end
endmodule 