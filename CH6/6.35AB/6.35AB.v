module Q35_A_Structural_P_6_2 (
    output [3:0] A,
    input [3:0] I,
    input load,clk,clr
);
    wire [3:0] D;
    Q35_A_Structural_P_6_2_MUX_2_X_1 Stage_Zero_Mux (D[0],I[0],A[0],load);
    Q35_A_Structural_P_6_2_MUX_2_X_1 Stage_One_Mux (D[1],I[1],A[1],load);
    Q35_A_Structural_P_6_2_MUX_2_X_1 Stage_Two_Mux (D[2],I[2],A[2],load);
    Q35_A_Structural_P_6_2_MUX_2_X_1 Stage_Three_Mux (D[3],I[3],A[3],load);
    Q35_A_Structural_P_6_2_DFF Stage_Zero_DFF (A[0],D[0],clk,clr);
    Q35_A_Structural_P_6_2_DFF Stage_One_DFF (A[1],D[1],clk,clr);
    Q35_A_Structural_P_6_2_DFF Stage_Two_DFF (A[2],D[2],clk,clr);
    Q35_A_Structural_P_6_2_DFF Stage_Three_DFF (A[3],D[3],clk,clr);
endmodule

module Q35_A_Structural_P_6_2_DFF(
    output reg Q,
    input D,clk,clr
);
    always @(posedge clk) begin
        if(clr) Q <= 0;
        else Q <= D;
    end
endmodule 

module Q35_A_Structural_P_6_2_MUX_2_X_1 (
    output y,
    input I1,I0,select
);
    assign y = select ? I1 : I0;
endmodule

module Q35_B_Behavioral_P_6_2 (
    output reg [3:0] A,
    input [3:0] I,
    input load,clk,clr
);
    always @(posedge clk) begin
        if(clr) A <= 4'b0000;
        else if (load) A <= I; 
    end
endmodule 

module Q35_A_B_TB;
    wire [3:0] A_Structural,A_Behavioral;
    reg [3:0] I;
    reg load,clk,clr;
    Q35_A_Structural_P_6_2 Structural_Model (A_Structural,I,load,clk,clr);
    Q35_B_Behavioral_P_6_2 Behavioral_Model (A_Behavioral,I,load,clk,clr);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #70 $finish;
    end
    initial fork
        #0 {clr,load,I} = 6'b101010;
        #10 load = 1;
        #20 {clr,load} = 2'b00;
        #30 load = 1;
        #40 clr = 1;
        #50 {clr,load,I} = 6'b000101;
        #60 load = 1;
    join
    initial begin
        $dumpfile("6.35AB.vcd");
        $dumpvars(0,Q35_A_B_TB);
    end
endmodule