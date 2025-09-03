module Q34_Four_Bit_Shift_Register (
    output SO,
    input SI,clk,rstn
);
    reg [3:0] state;
    assign SO = state[0];
    always @(posedge clk or negedge rstn) begin
        if(!rstn) state <= 4'b0000;
        else state <= {SI,state[3:1]};
    end
endmodule 
`timescale 1ps/1ps
module Q34_Four_Bit_Shift_Register_TB;
    wire SO;
    reg SI,clk,rstn;
    Q34_Four_Bit_Shift_Register M0 (SO,SI,clk,rstn);
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
        #0 {rstn,SI} = 2'b01;
        #10 SI = 0;
        #20 {rstn,SI} = 2'b11;
        #30 SI = 0;
        #40 SI = 1;
        #50 SI = 0;
    join
    initial begin
        $dumpfile("6.34.vcd");
        $dumpvars(0,Q34_Four_Bit_Shift_Register_TB);
    end
endmodule 