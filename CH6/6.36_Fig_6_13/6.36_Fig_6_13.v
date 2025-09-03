module Q36_Fig_6_13_Structural (
    output [3:0] A,
    input Up,Down,clk,rstn
);
    wire [3:0] T,Not_A;
    wire Down_and_Not_Up,Not_Up;
    wire [3:0] Up_Level,Down_Level;
    not (Not_Up,Up),
        (Not_A[3],A[3]),
        (Not_A[2],A[2]),
        (Not_A[1],A[1]),
        (Not_A[0],A[0]);
    and (Down_and_Not_Up,Down,Not_Up),
        (Up_Level[1],A[0],Up),
        (Up_Level[2],A[1],Up_Level[1]),
        (Up_Level[3],A[2],Up_Level[2]),
        (Down_Level[1],Not_A[0],Down_and_Not_Up),
        (Down_Level[2],Not_A[1],Down_Level[1]),
        (Down_Level[3],Not_A[2],Down_Level[2]);
    or  (T[0],Up,Down_and_Not_Up),
        (T[1],Up_Level[1],Down_Level[1]),
        (T[2],Up_Level[2],Down_Level[2]),
        (T[3],Up_Level[3],Down_Level[3]);
    Q36_Fig_6_13_structural_TFF Stage_Zero (A[0],T[0],clk,rstn);
    Q36_Fig_6_13_structural_TFF Stage_One (A[1],T[1],clk,rstn);
    Q36_Fig_6_13_structural_TFF Stage_Two (A[2],T[2],clk,rstn);
    Q36_Fig_6_13_structural_TFF Stage_Three (A[3],T[3],clk,rstn);
endmodule 

module Q36_Fig_6_13_structural_TFF(
    output reg Q,
    input T,clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Q <= 0;
        else if(T) Q <= ~Q;
    end
endmodule

module Q36_Fig_6_13_Behavioral(
    output reg [3:0] A,
    input Up,Down,clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) A <= 4'b0;
        else if (Up) A <= A + 4'B0001;
        else if (!Up && Down) A <= A - 4'b0001;
    end
endmodule

module Q36_Fig_6_13_TB;
    wire [3:0] A_Structural,A_Behavioral;
    reg Up,Down,clk,rstn;
    Q36_Fig_6_13_Structural Structural_Model (A_Structural,Up,Down,clk,rstn);
    Q36_Fig_6_13_Behavioral Behavioral_Model (A_Behavioral,Up,Down,clk,rstn);
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
        #0 {rstn,Up,Down} = 3'b000;
        #10 {rstn,Up,Down} = 3'b001;
        #20 {rstn,Up,Down} = 3'b010;
        #30 {rstn,Up,Down} = 3'b011;
        #40 {rstn,Up,Down} = 3'b100;
        #50 {rstn,Up,Down} = 3'b110;
        #80 {rstn,Up,Down} = 3'b101;
        #100 {rstn,Up,Down} = 3'b111;
        #130 {rstn,Up,Down} = 3'b011;
        #150 {rstn,Up,Down} = 3'b110;
    join
    initial begin
        $dumpfile("6.36.vcd");
        $dumpvars(0,Q36_Fig_6_13_TB);
    end
endmodule 