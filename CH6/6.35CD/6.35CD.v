module Q35_C_Structural_P_6_6(
    output [3:0] A,
    input shift,load,serial_input,clk,rstn,
    input [3:0] I
);
    Q35_C_Structural_P_6_6_stage Stage_Zero (A[0],shift,load,serial_input,clk,rstn,I[0]);
    Q35_C_Structural_P_6_6_stage Stage_One (A[1],shift,load,A[0],clk,rstn,I[1]);
    Q35_C_Structural_P_6_6_stage Stage_Two (A[2],shift,load,A[1],clk,rstn,I[2]);
    Q35_C_Structural_P_6_6_stage Stage_Three (A[3],shift,load,A[2],clk,rstn,I[3]);
endmodule

module Q35_C_Structural_P_6_6_DFF (
    output reg Q,
    input D,clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Q <= 0;
        else Q <= D;
    end
endmodule

module Q35_C_Structural_P_6_6_stage (
    output A,
    input shift,load,serial_input,clk,rstn,I
);
    wire    not_shift,not_load,
            shift_and_serial_input,
            load_and_not_shift_and_I,
            not_shift_and_not_load_A,
            D;
    not (not_shift,shift),
        (not_load,load);
    and (shift_and_serial_input,shift,serial_input),
        (load_and_not_shift_and_I,load,not_shift,I),
        (not_shift_and_not_load_A,not_shift,not_load,A);
    or (D,shift_and_serial_input,load_and_not_shift_and_I,not_shift_and_not_load_A);
    Q35_C_Structural_P_6_6_DFF Stage_FF (A,D,clk,rstn);
endmodule 

module Q35_C_Behavioral_P_6_6 (
    output reg [3:0] A,
    input shift,load,serial_input,clk,rstn,
    input [3:0] I
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) A <= 4'B0;
        else if (shift) A <= {A[2:0],serial_input};
        else if (load) A <= I;
    end
endmodule

module Q35_C_TB;
    wire [3:0] A_Structural,A_Behavioral;
    reg shift,load,serial_input,clk,rstn;
    reg [3:0] I;
    Q35_C_Structural_P_6_6 Structural_Model (A_Structural,shift,load,serial_input,clk,rstn,I);
    Q35_C_Behavioral_P_6_6 Behavioral_Model (A_Behavioral,shift,load,serial_input,clk,rstn,I);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #120 $finish;
    end
    initial fork 
        #0 {rstn,shift,load,serial_input,I} = 8'b00011010;
        #10 shift = 1;
        #20 {shift,load} = 2'b01;
        #30 {rstn,load} = 2'b10;
        #40 load = 1;
        #50 {shift,load} = 2'b10;
        #90 rstn = 0;
        #100 {rstn,load} = 2'b11;
        #110 shift = 0;
    join
    initial begin
        $dumpfile("6.35CD.vcd");
        $dumpvars(0,Q35_C_TB);
    end
endmodule 