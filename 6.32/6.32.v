module Q32_A_Four_Bit_Register_Behavioral(
    output reg [3:0] A,
    input [3:0] I,
    input clk,clear,load
);
    always @(posedge clk,posedge clear) begin
        if(clear) A <= 4'b0000;
        else if (load) A <= I;
    end
endmodule

module Q32_B_Four_Bit_Register_Structural (
    output  [3:0] A,
    input [3:0] I,
    input clk,clear,load
);
    wire D0,D1,D2,D3,load_bar;
    not (load_bar,load);
    Q32_B_2_X_1_Mux Stage_Zero_Mux (D0,A[0],I[0],load);
    Q32_B_2_X_1_Mux Stage_One_Mux (D1,A[1],I[1],load);
    Q32_B_2_X_1_Mux Stage_Two_Mux (D2,A[2],I[2],load);
    Q32_B_2_X_1_Mux Stage_Three_Mux (D3,A[3],I[3],load);
    Q32_B_DFF Stage_Zero_DFF (A[0],D0,clk,clear);
    Q32_B_DFF Stage_One_DFF (A[1],D1,clk,clear);
    Q32_B_DFF Stage_Two_DFF (A[2],D2,clk,clear);
    Q32_B_DFF Stage_Three_DFF (A[3],D3,clk,clear);
endmodule 

module Q32_B_DFF(
    output reg Q,
    input D,clk,clear
);
    always @(posedge clk,posedge clear) begin
        if(clear) Q <= 0;
        else Q <= D;
    end
endmodule

module Q32_B_2_X_1_Mux (
    output y_out,
    input I0,I1,select
);
    assign y_out = (select) ? I1 : I0;
endmodule 

module Q32_TB;
    wire [3:0] A_behavioral,A_structural;
    reg [3:0] I;
    reg clk,clear,load;
    Q32_A_Four_Bit_Register_Behavioral Behavioral_Model (A_behavioral,I,clk,clear,load);
    Q32_B_Four_Bit_Register_Structural Structural_Model (A_structural,I,clk,clear,load);
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
        #0 clear = 1;
        #10 load = 1;
        #20 I = 4'd10;
        #30 {clear,load} = 2'b00;
        #40 load = 1;
        #50 {load,I} = 5'b00000;
        #60 {load,I} = 5'b10101;
        #70 clear = 1;
        #80 clear = 0;
    join
    initial begin
        $dumpfile("6.32.vcd");
        $dumpvars(0,Q32_TB);
    end
endmodule