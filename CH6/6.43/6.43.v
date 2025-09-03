module Q43_MUX (
    output Y,
    input I1,I0,S
);
    assign Y = (S) ? I1 : I0;
endmodule

module Q43_DFF (
    output reg Q,
    input D,clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if (!rstn) Q <= 0;
        else Q <= D; 
    end
endmodule

module Q43_Structural_Stage (
    output Q,
    input D_in,Data,Shift_Control,Load,clk,rstn
);
    wire Mux_One_Output,D;
    Q43_MUX First_Mux (Mux_One_Output,D_in,Q,Shift_Control);
    Q43_MUX Second_Mux (D,Data,Mux_One_Output,Load);
    Q43_DFF DFF_Stage (Q,D,clk,rstn);
endmodule 

module Q43_Final_Structure (
    output [3:0] A,B,
    input [3:0] Data_A,Data_B,
    input Shift_Control,Load,clk,rstn
);
    Q43_Structural_Stage A_Three (A[3],A[0],Data_A[3],Shift_Control,Load,clk,rstn);
    Q43_Structural_Stage A_Two (A[2],A[3],Data_A[2],Shift_Control,Load,clk,rstn);
    Q43_Structural_Stage A_One (A[1],A[2],Data_A[1],Shift_Control,Load,clk,rstn);
    Q43_Structural_Stage A_Zero (A[0],A[1],Data_A[0],Shift_Control,Load,clk,rstn);


    Q43_Structural_Stage B_Three (B[3],A[0],Data_B[3],Shift_Control,Load,clk,rstn);
    Q43_Structural_Stage B_Two (B[2],B[3],Data_B[2],Shift_Control,Load,clk,rstn);
    Q43_Structural_Stage B_One (B[1],B[2],Data_B[1],Shift_Control,Load,clk,rstn);
    Q43_Structural_Stage B_Zero (B[0],B[1],Data_B[0],Shift_Control,Load,clk,rstn);
endmodule 

module Q43_TB;
    wire [3:0] A,B;
    reg [3:0] Data_A,Data_B;
    reg Shift_Control,Load,clk,rstn;
    Q43_Final_Structure Structural_Model (A,B,Data_A,Data_B,Shift_Control,Load,clk,rstn);
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
        #40 rstn = 1;
        #120 rstn = 0;
        #130 rstn = 1;
        #0 Data_A = 4'b1011;
        #0 Data_B = 4'b0010;
        #0 {Load,Shift_Control} = 2'b00;
        #10 {Load,Shift_Control} = 2'b01;
        #20 {Load,Shift_Control} = 2'b10;
        #30 {Load,Shift_Control} = 2'b11;
        #50 {Load,Shift_Control} = 2'b10;
        #60 {Load,Shift_Control} = 2'b00;
        #80 {Load,Shift_Control} = 2'b01;
        #140 {Load,Shift_Control} = 2'b10;
        #150 {Load,Shift_Control} = 2'b01;
    join
    initial begin
        $dumpfile("6.43.vcd");
        $dumpvars(0,Q43_TB);
    end
endmodule