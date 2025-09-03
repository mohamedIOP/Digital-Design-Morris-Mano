`timescale 1ps/1ps
module Q27_Mealy_Machine_Zero_Detector (
    output reg Y,
    input X,clk,rstn
);
    reg [1:0] state;
    parameter S0 = 2'b00,S1 = 2'b01,S2 = 2'b10,S3 = 2'b11;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            state <= S0;
        end
        else begin
            case (state)
                S0: if(X) begin state <= S1;Y <= 0; end
                    else begin state <= S0;Y <= 0; end
                S1: if(X) begin state <= S3;Y <= 0; end
                    else begin state <= S0;Y <= 1; end
                S2: if(X) begin state <= S2;Y <= 0; end
                    else begin state <= S0;Y <= 1; end
                S3: if(X) begin state <= S2;Y <= 0; end
                    else begin state <= S3;Y <= 1; end
            endcase
        end
    end
endmodule

module Q27_Mealy_Machine_Zero_Detector_TB;
    wire Y;
    reg X,clk,rstn;
    Q27_Mealy_Machine_Zero_Detector M0 (Y,X,clk,rstn);
    initial begin
        #200 $finish;
    end
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial fork 
        rstn = 0;
        #2 rstn = 1;
        #87 rstn = 0;
        #89 rstn = 1;
        #10 X = 1;
        #30 X = 0;
        #40 X = 1;
        #50 X = 0;
        #52 X = 1;
        #54 X = 0;
        #70 X = 1;
        #80 X = 1;
        #70 X = 0;
        #90 X = 1;
        #100 X = 0;
        #120 X = 1;
        #160 X = 0;
        #170 X = 1;
    join
endmodule