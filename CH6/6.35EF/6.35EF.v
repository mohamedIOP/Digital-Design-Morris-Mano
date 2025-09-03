module Q35_E_Structural_P_6_7 (
    output [3:0] A,
    input [3:0] I,
    input [1:0] S,
    input clk,rstn
);
    Q35_E_Structural_P_6_7_Stage Stage_Zero (A[0],I[0],S[0],S[1],clk,rstn);
    Q35_E_Structural_P_6_7_Stage Stage_One (A[1],I[1],S[0],S[1],clk,rstn);
    Q35_E_Structural_P_6_7_Stage Stage_Two (A[2],I[2],S[0],S[1],clk,rstn);
    Q35_E_Structural_P_6_7_Stage Stage_Three (A[3],I[3],S[0],S[1],clk,rstn);
endmodule
module Q35_E_Structural_P_6_7_Stage (
    output A,
    input I,S0,S1,clk,rstn
);
    wire not_A,D;
    not (not_A,A);
    Q35_E_Structural_P_6_7_4_X_1_MUX MUX (D,A,1'b0,not_A,I,S0,S1);
    Q35_E_Structural_P_6_7_DFF DFF (A,D,clk,rstn);
endmodule
module Q35_E_Structural_P_6_7_DFF (
    output reg Q,
    input D,clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Q <= 0;
        else Q <= D;
    end
endmodule

module Q35_E_Structural_P_6_7_4_X_1_MUX (
    output Y,
    input I0,I1,I2,I3,S0,S1
);
    assign Y = S1 ? (S0 ? (I3) : (I2)) : (S0 ? (I1) : (I0));
endmodule 

module Q35_F_Behavioral_P_6_7 (
    output reg [3:0] A,
    input [3:0] I,
    input [1:0] S,
    input clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) A <= 4'b0000;
        else 
        case (S)
            2'b00: A <= A;
            2'b01: A <= 4'b0000;
            2'b10: A <= ~A;
            2'b11: A <= I;
        endcase
    end
endmodule 
`timescale 1ps/1ps
module Q35_EF_TB;
    wire [3:0] A_Structural,A_Behavioral;
    reg [3:0] I;
    reg [1:0] S;
    reg clk,rstn;
    Q35_E_Structural_P_6_7 Structural_Model (A_Structural,I,S,clk,rstn);
    Q35_F_Behavioral_P_6_7 Behavioral_Model (A_Behavioral,I,S,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #80 $finish;
    end
    initial fork 
        rstn = 0;S = 2'b00;I = 4'b1010;
        #10 S = 2'b01;
        #20 S = 2'b10;
        #30 S = 2'b11;
        #40 {rstn,S} = 3'b100;
        #50 S = 2'b10;
        #60 S = 2'b01;
        #70 S = 2'b11;
    join
    initial begin
        $dumpfile("6.35EF.vcd");
        $dumpvars(0,Q35_EF_TB);
    end
endmodule 