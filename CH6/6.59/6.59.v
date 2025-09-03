module Q59_Johnson_Counter_Structural(
    output A,B,C,E,
    input clk,rstn
);
    wire Not_E;
    not (Not_E,E);
    Q59_Johnson_Counter_Structural_DFF A_DFF (A,Not_E,clk,rstn);
    Q59_Johnson_Counter_Structural_DFF B_DFF (B,A,clk,rstn);
    Q59_Johnson_Counter_Structural_DFF C_DFF (C,B,clk,rstn);
    Q59_Johnson_Counter_Structural_DFF E_DFF (E,C,clk,rstn);
endmodule 

module Q59_Johnson_Counter_Structural_DFF (
    output reg Q,
    input D,clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Q <= 0;
        else Q <= D;
    end
endmodule

module Q59_Johnson_Counter_Behavioral(
    output reg A,B,C,E,
    input clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) {A,B,C,E} <= 4'b0000;
        else
            case ({A,B,C,E})
                4'b0000: {A,B,C,E} <= 4'B1000;
                4'b1000: {A,B,C,E} <= 4'B1100;
                4'b1100: {A,B,C,E} <= 4'B1110;
                4'b1110: {A,B,C,E} <= 4'B1111;
                4'b1111: {A,B,C,E} <= 4'B0111;
                4'b0111: {A,B,C,E} <= 4'B0011;
                4'b0011: {A,B,C,E} <= 4'B0001;
                4'b0001: {A,B,C,E} <= 4'B0000;
            endcase
    end
endmodule

module Q59_Johnson_Counter_TB;
    wire 
        A_Structural,B_Structural,C_Structural,E_Structural,
        A_Behavioral,B_Behavioral,C_Behavioral,E_Behavioral;
    reg clk,rstn;
    Q59_Johnson_Counter_Structural Structural_Model (A_Structural,B_Structural,C_Structural,E_Structural,clk,rstn);
    Q59_Johnson_Counter_Behavioral Behavioral_Model (A_Behavioral,B_Behavioral,C_Behavioral,E_Behavioral,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #170 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #10 rstn = 1;
        #120 rstn = 0;
        #130 rstn = 1;
    join
    initial begin
        $dumpfile("6.59.vcd");
        $dumpvars(0,Q59_Johnson_Counter_TB);
    end
endmodule 