module Q57_Four_Bit_Up_Down_Binary_Counter(
    output [3:0] A,
    input Up,Down,clk,rstn
);
    wire Down_and_Not_Up,Not_Up;
    wire [3:0] T;
    wire [2:0] Anding_Stage_Up,Anding_Stage_Down;
    wire [3:0] Not_A;
    not (Not_Up,Up),
        (Not_A[3],A[3]),
        (Not_A[2],A[2]),
        (Not_A[1],A[1]),
        (Not_A[0],A[0]);
    and (Down_and_Not_Up,Down,Not_Up),
        (Anding_Stage_Up[0],A[0],Up),
        (Anding_Stage_Up[1],A[1],Anding_Stage_Up[0]),
        (Anding_Stage_Up[2],A[2],Anding_Stage_Up[1]),
        (Anding_Stage_Down[0],Not_A[0],Down_and_Not_Up),
        (Anding_Stage_Down[1],Not_A[1],Anding_Stage_Down[0]),
        (Anding_Stage_Down[2],Not_A[2],Anding_Stage_Down[1]);
    or  (T[0],Up,Down_and_Not_Up),
        (T[1],Anding_Stage_Down[0],Anding_Stage_Up[0]),
        (T[2],Anding_Stage_Down[1],Anding_Stage_Up[1]),
        (T[3],Anding_Stage_Down[2],Anding_Stage_Up[2]);
    Q57_Four_Bit_Up_Down_Binary_Counter_TFF Stage_Zero (A[0],T[0],clk,rstn);
    Q57_Four_Bit_Up_Down_Binary_Counter_TFF Stage_One (A[1],T[1],clk,rstn);
    Q57_Four_Bit_Up_Down_Binary_Counter_TFF Stage_Two (A[2],T[2],clk,rstn);
    Q57_Four_Bit_Up_Down_Binary_Counter_TFF Stage_Three (A[3],T[3],clk,rstn);
endmodule

module Q57_Four_Bit_Up_Down_Binary_Counter_TFF (
    output reg Q,
    input T,clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Q <= 0;
        else if (T) Q <= ~Q;
        else Q <= Q;
    end
endmodule

module Q57_Four_Bit_Up_Down_Binary_Counter_TB;
    wire [3:0] A;
    reg Up,Down,clk,rstn;
    Q57_Four_Bit_Up_Down_Binary_Counter Structural_Model (A,Up,Down,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #340 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #40 rstn = 1;
        #290 rstn = 0;
        #300 rstn = 1;
        #0 {Up,Down} = 2'b00;
        #10 {Up,Down} = 2'b01;
        #20 {Up,Down} = 2'b10;
        #30 {Up,Down} = 2'b11;
        #40 {Up,Down} = 2'b00;
        #50 {Up,Down} = 2'b10;
        #240 {Up,Down} = 2'b01;
        #260 {Up,Down} = 2'b11;
    join
    initial begin
        $dumpfile("6.57.vcd");
        $dumpvars(0,Q57_Four_Bit_Up_Down_Binary_Counter_TB);
    end
endmodule