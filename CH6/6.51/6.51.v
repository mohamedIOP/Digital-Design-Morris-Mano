module Q51_Sequence_Detector (
    output reg [3:0] A,
    output Y,
    input SI,clk,rstn
);
    assign Y = A[3] && A[2] && A[1];
    always @(posedge clk or negedge rstn) begin
        if(!rstn) A <= 4'b0;
        else A <= {SI,A[3:1]};
    end
endmodule 

module Q51_Sequence_Detector_TB;
    wire [3:0] A;
    wire Y;
    reg SI,clk,rstn;
    Q51_Sequence_Detector M0 (A,Y,SI,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #150 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #20 rstn = 1;
        #90 rstn = 0;
        #100 rstn = 1;
        #0 SI = 0;
        #10 SI = 1;
        #20 SI = 0;
        #30 SI = 1;
        #80 SI = 0;
        #100 SI = 1;
        #140 SI = 0;
    join
    initial begin
        $dumpfile("6.51_Sequence_Detector");
        $dumpvars(0,Q51_Sequence_Detector_TB);
    end
endmodule 