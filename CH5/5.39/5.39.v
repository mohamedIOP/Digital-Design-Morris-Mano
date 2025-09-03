module Q39_Behavioural_5_17(
    output reg y_out,
    input x_in,clk,rstn
);
    reg state,next_state;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) state <= 0;
        else state <= next_state;
    end
    always @(state,x_in) begin
        if (state) begin
            next_state = 1;
            y_out = ~x_in;
        end
        else begin
            next_state = x_in;
            y_out = x_in;
        end
    end
endmodule
// TB
module Q39_Behavioural_5_17_TB;
    wire y_out;
    reg x_in,clk,rstn;
    Q39_Behavioural_5_17 M0 (y_out,x_in,clk,rstn);
    initial begin
        #60 $finish;
    end
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial fork
        #0 {rstn,x_in} = 2'b0x;
        #10 {rstn,x_in} = 2'b10;
        #20 x_in = 1;
        #40 x_in = 0;
        #50 rstn = 0;
    join
    initial begin
        $dumpfile("5.39.vcd");
        $dumpvars(0,Q39_Behavioural_5_17_TB);
    end
endmodule 