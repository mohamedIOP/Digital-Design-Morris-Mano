module Q41_Johnson_Counter (
    output reg [3:0] Count,
    input clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Count <= 4'b0;
        else
            case (Count)
                4'b0000: Count <= 4'b1000;
                4'b1000: Count <= 4'b1100;
                4'b1100: Count <= 4'b1110;
                4'b1110: Count <= 4'b1111;
                4'b1111: Count <= 4'b0111;
                4'b0111: Count <= 4'b0011;
                4'b0011: Count <= 4'b0001;
                4'b0001: Count <= 4'b0000;
                default : Count <= 4'b0000;
            endcase
    end
endmodule

module Q41_Johnson_Counter_TB;
    wire [3:0] Count;
    reg clk,rstn;
    Q41_Johnson_Counter M0 (Count,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #400 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #10 rstn = 1;
        #250 rstn = 0;
        #260 rstn = 1;
    join
    initial begin
        $dumpfile("6.41.vcd");
        $dumpvars(0,Q41_Johnson_Counter_TB);
    end
endmodule 