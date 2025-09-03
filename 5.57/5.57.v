module Q57_Three_Bit_Counter(
    input x_in,clk,rstn
);
    reg [2:0] state,next_state;
    parameter [2:0] S0 = 3'b000,S1 = 3'b010,S2 = 3'b100,S3 = 3'b110;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) state <= S0;
        else state <= next_state;
    end
    always @(state,x_in) begin
        if(x_in)
            if(state == S3) next_state = S0;
            else next_state = state + 3'b010;
        else next_state = state;
    end
endmodule
`timescale 1ps/1ps
module Q57_Three_Bit_Counter_TB;
    reg x_in,clk,rstn;
    Q57_Three_Bit_Counter M0 (x_in,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #100 $finish;
    end
    initial fork
        #0 {rstn,x_in} = 2'b00;
        #10 x_in = 1;
        #20 {rstn,x_in} = 2'b10;
        #30 x_in = 1;
        #40 rstn = 0;
        #50 rstn = 1;
    join
    initial begin
        $dumpfile("5.57.vcd");
        $dumpvars(0,Q57_Three_Bit_Counter_TB);
    end
endmodule //5.57