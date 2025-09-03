module Q36_Table_6_5_Structural(
    output [3:0] Q,
    output Y,
    input clk,rstn
);
    wire [3:0] T;
    wire Q3_and_Q0,Q1_and_Q0,Q3_Bar_and_Q0,Q2_and_Q1_and_Q0,Q3_Bar;
    not (Q3_Bar,Q[3]);
    and (Q3_and_Q0,Q[3],Q[0]),
        (Q1_and_Q0,Q[1],Q[0]),
        (Q2_and_Q1_and_Q0,Q[2],Q[1],Q[0]),
        (Q3_Bar_and_Q0,Q3_Bar,Q[0]);
    or (T[3],Q3_and_Q0,Q2_and_Q1_and_Q0);
    assign  T[0] = 1,
            T[1] = Q3_Bar_and_Q0,
            T[2] = Q1_and_Q0,
            Y = Q3_and_Q0;
    Q36_Table_6_5_Structural_TFF Stage_Zero (Q[0],T[0],clk,rstn);
    Q36_Table_6_5_Structural_TFF Stage_One (Q[1],T[1],clk,rstn);
    Q36_Table_6_5_Structural_TFF Stage_Two (Q[2],T[2],clk,rstn);
    Q36_Table_6_5_Structural_TFF Stage_Three (Q[3],T[3],clk,rstn);
endmodule

module Q36_Table_6_5_Structural_TFF(
    output reg Q,
    input T,clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Q <= 0;
        else if (T) Q <= !Q;
    end
endmodule

module Q36_Table_6_5_Behavioral (
    output reg [3:0] Q,
    output Y,
    input clk,rstn
);
    parameter [3:0]
                S0 = 4'b0000,
                S1 = 4'b0001,
                S2 = 4'b0010,
                S3 = 4'b0011,
                S4 = 4'b0100,
                S5 = 4'b0101,
                S6 = 4'b0110,
                S7 = 4'b0111,
                S8 = 4'b1000,
                S9 = 4'b1001;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Q <= 4'b0;
        else if(Q == S9) Q <= 4'b0;
        else Q <= Q + 4'b0001;
    end
    assign Y = Q[3] && Q[0];
endmodule 

module Q36_Table_6_5_TB;
    wire [3:0] Q_Structural,Q_Behavioral;
    wire Y_Struchural,Y_Behavioral;
    reg clk,rstn;
    Q36_Table_6_5_Structural Structural_Model (Q_Structural,Y_Struchural,clk,rstn);
    Q36_Table_6_5_Behavioral Behavioral_Model (Q_Behavioral,Y_Behavioral,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #190 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #10 rstn = 1;
        #140 rstn = 0;
        #150 rstn = 1;
    join
    initial begin
        $dumpfile("6.36_Table_6_5.vcd");
        $dumpvars(0,Q36_Table_6_5_TB);
    end
endmodule 