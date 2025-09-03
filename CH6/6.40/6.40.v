module Q40_Ring_Counter(
    output reg [7:0] Count,
    input clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Count <= 8'b10000000;
        else if (Count == 8'b00000001) Count <= 8'b10000000;
        else Count <= Count >> 1;
    end
endmodule

module Q40_Ring_Counter_TB;
    wire [7:0] Count;
    reg  clk,rstn;
    Q40_Ring_Counter M0 (Count,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #150 $finish;
    end
    initial begin
        #0 rstn = 0;
        #10 rstn = 1;
        #110 rstn = 0;
        #120 rstn = 1;
    end
    initial begin
        $dumpfile("6.40.vcd");
        $dumpvars(0,Q40_Ring_Counter_TB);
    end
endmodule 