module Q38_A_Four_Bit_Counter(
    output reg [3:0] Count,
    input [3:0] I,
    input clk,rstn,Load,Up,Down
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Count <= 4'd0;
        else if (Load) Count <= I;
        else if (Up) Count <= Count + 4'd1;
        else if (Down) Count <= Count - 4'd1;
        else Count <= Count;
    end
endmodule

module Q38_B_Four_Bit_Counter(
    output reg [3:0] Count,
    input [3:0] I,
    input [1:0] Selection_Mode,
    input clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Count <= 4'd0;
        else
            case (Selection_Mode)
                2'b00: Count <= Count;
                2'b01: Count <= Count + 4'd1;
                2'b10: Count <= Count - 4'b1;
                2'b11: Count <= I;
                default: Count <= Count;
            endcase
    end
endmodule

module Q38_TB;
    wire [3:0] Count_A,Count_B;
    reg [3:0] I;
    reg [1:0] Selection_Mode;
    reg clk,rstn,Load,Up,Down;
    Q38_A_Four_Bit_Counter Model_A (Count_A,I,clk,rstn,Load,Up,Down);
    Q38_B_Four_Bit_Counter Model_B (Count_B,I,Selection_Mode,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #240 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #80 rstn = 1;
        #220 rstn = 0;
        #230 rstn = 1;
        #0 I = 4'b1010;
        #0 {Load,Up,Down,Selection_Mode} = 5'b00000;
        #10 {Load,Up,Down,Selection_Mode} = 5'b00101;
        #20 {Load,Up,Down,Selection_Mode} = 5'b01010;
        #30 {Load,Up,Down,Selection_Mode} = 5'b01111;
        #40 {Load,Up,Down,Selection_Mode} = 5'b10000;
        #50 {Load,Up,Down,Selection_Mode} = 5'b10101;
        #60 {Load,Up,Down,Selection_Mode} = 5'b11010;
        #70 {Load,Up,Down,Selection_Mode} = 5'b11111;
        #80 {Load,Up,Down,Selection_Mode} = 5'b00000;
        #90 {Load,Up,Down,Selection_Mode} = 5'b10011;
        #110 {Load,Up,Down,Selection_Mode} = 5'b11011;
        #120 {Load,Up,Down,Selection_Mode} = 5'b11111;
        #130 {Load,Up,Down,Selection_Mode} = 5'b10111;
        #140 {Load,Up,Down,Selection_Mode} = 5'b00110;
        #180 {Load,Up,Down,Selection_Mode} = 5'b01001;
        #200 {Load,Up,Down,Selection_Mode} = 5'b01101;
    join
    initial begin
        $dumpfile("6.38.vcd");
        $dumpvars(0,Q38_TB);
    end
endmodule 