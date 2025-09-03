module Q46_Behavioral_Model_Ring_Counter(
    output reg [5:0] T,
    input clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) T <= 6'b100000;
        else if (T == 6'b000001) T <= 6'b100000;
        else T <= T >> 1; 
    end
endmodule

module Q46_Behavioral_Model_Ring_Counter_TB;
    wire [5:0] T;
    reg clk,rstn;
    Q46_Behavioral_Model_Ring_Counter Model_Behavioral (T,clk,rstn);
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
        #0 rstn = 0;
        #10 rstn = 1;
        #100 rstn = 0;
        #110 rstn = 1;
    join
    initial begin
        $dumpfile("6.46.vcd");
        $dumpvars(0,Q46_Behavioral_Model_Ring_Counter_TB);
    end
endmodule 