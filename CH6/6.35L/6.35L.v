module Q35_L_Four_Bit_Up_Down_Counter(
    output reg [3:0] A,
    input Up,Down,clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) A <= 4'b0;
        else if(Up && !Down) A <= A + 4'b0001;
        else if(!Up && Down) A <= A - 4'b0001;
    end
endmodule
`timescale 1ps/1ps
module Q35_L_Four_Bit_Up_Down_Counter_TB;
    wire [3:0] A;
    reg Up,Down,clk,rstn;
    Q35_L_Four_Bit_Up_Down_Counter M0 (A,Up,Down,clk,rstn);
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
        #90 {rstn,Up,Down} = 3'b101;
        #110 {rstn,Up,Down} = 3'b111;
        #130 {rstn,Up,Down} = 3'b011;
        #140 {rstn,Up,Down} = 3'b110;
    join
    initial begin
        $dumpfile("6.35L.vcd");
        $dumpvars(0,Q35_L_Four_Bit_Up_Down_Counter_TB);
    end
endmodule 