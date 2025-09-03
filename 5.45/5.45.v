// write && verify behavioral

module Q45_Fig_5_27_Sequence_Detector(
    output reg y_out,
    input x_in,clk,rstn
);
    reg [1:0] state,next_state;
    parameter S0 = 2'b00,S1 = 2'b01,S2 = 2'b10,S3 = 2'b11;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) state <= S0;
        else state <= next_state;
    end
    always @(state,x_in) begin
        case (state)
            S0:  if(x_in) next_state = S1; else next_state = S0;
            S1:  if(x_in) next_state = S2; else next_state = S0;
            S2:  if(x_in) next_state = S3; else next_state = S0;
            S3:  if(x_in) next_state = S3; else next_state = S0;
        endcase
    end
    always @(state) begin
        if (state == S3) 
            y_out = 1; 
        else 
            y_out = 0;
    end
endmodule
`timescale 1ps/1ps
module Q45_Fig_5_27_Sequence_Detector_TB;
    wire y_out;
    reg x_in,clk,rstn;
    Q45_Fig_5_27_Sequence_Detector M0 (y_out,x_in,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #140 $finish; 
    end
    initial fork 
        #0 {rstn,x_in} = 2'b00;
        #10 x_in = 1;
        #20 {rstn,x_in} = 2'b10;
        #30 x_in = 1;
        #70 x_in = 0;
        #90 x_in = 1;
        #100 x_in = 0;
        #110 x_in = 1;
        #130 x_in = 0;
    join
    initial begin
        $dumpfile("5.45.vcd");
        $dumpvars(0,Q45_Fig_5_27_Sequence_Detector_TB);
    end
endmodule 