module Q56_Four_Bit_Synchronous_Binary_Counter_Structural(
    output [3:0] A,
    output To_Next_Stage,
    input Count_enable,clk,rstn
);
    wire [3:0] Anding;
    and (Anding[1],A[0],Count_enable),
        (Anding[2],A[1],Anding[1]),
        (Anding[3],A[2],Anding[2]),
        (To_Next_Stage,A[3],Anding[3]);
    Q56_Four_Bit_Synchronous_Binary_Counter_Structural_JK JK_0 (A[0],Count_enable,Count_enable,clk,rstn);
    Q56_Four_Bit_Synchronous_Binary_Counter_Structural_JK JK_1 (A[1],Anding[1],Anding[1],clk,rstn);
    Q56_Four_Bit_Synchronous_Binary_Counter_Structural_JK JK_2 (A[2],Anding[2],Anding[2],clk,rstn);
    Q56_Four_Bit_Synchronous_Binary_Counter_Structural_JK JK_3 (A[3],Anding[3],Anding[3],clk,rstn);
endmodule

module Q56_Four_Bit_Synchronous_Binary_Counter_Structural_JK (
    output reg Q,
    input J,K,clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Q <= 0;
        else
            case ({J,K})
                2'b00: Q <= Q;
                2'b01: Q <= 0;
                2'b10: Q <= 1;
                2'b11: Q <= ~Q;
                default : Q <= 0;
            endcase
    end
endmodule

module Q56_Four_Bit_Synchronous_Binary_Counter_Structural_TB;
    wire [3:0] A;
    wire To_Next_Stage;
    reg Count_enable,clk,rstn;
    Q56_Four_Bit_Synchronous_Binary_Counter_Structural Structural_Model (A,To_Next_Stage,Count_enable,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #310 $finish;
    end
    initial fork 
        #0 {rstn,Count_enable} = 2'b00;
        #10 {rstn,Count_enable} = 2'b01;
        #20 {rstn,Count_enable} = 2'b11;
        #180 {rstn,Count_enable} = 2'b10;
        #190 {rstn,Count_enable} = 2'b11;
        #250 {rstn,Count_enable} = 2'b01;
        #260 {rstn,Count_enable} = 2'b11;
    join
    initial begin
        $dumpfile("6.56.vcd");
        $dumpvars(0,Q56_Four_Bit_Synchronous_Binary_Counter_Structural_TB);
    end
endmodule 