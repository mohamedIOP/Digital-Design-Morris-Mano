module Q50_A_Counter(
    output reg [2:0] Count,
    input clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Count <= 3'b0;
        else if (Count == 3'b110) Count <= 3'b0;
        else Count <= Count + 3'b001;
    end
endmodule

module Q50_B_Counter (
    output reg [2:0] Count,
    input clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Count <= 3'b0;
        else 
            case (Count)
                3'b0,3'b001: Count <= Count + 3'b001;
                3'b010,3'b100: Count <= Count + 3'b010;
                3'b110: Count <= 3'b0;
                default : Count <= 3'b0;
            endcase
    end
endmodule 

module Q50_Counter_TB;
    wire [2:0] Count_A,Count_B;
    reg clk,rstn;
    Q50_A_Counter Counter_A (Count_A,clk,rstn);
    Q50_B_Counter Counter_B (Count_B,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #160 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #10 rstn = 1;
        #120 rstn = 0;
        #130 rstn = 1;
    join
    initial begin
        $dumpfile("6.50.vcd");
        $dumpvars(0,Q50_Counter_TB);
    end
endmodule 