module Q35_J_Serial_2s_complemeter(
    output SO,
    input SI,clk,rstn
);
    reg [1:0] sum;
    assign SO = sum[0];
    always @(posedge clk or negedge rstn) begin
        if(!rstn) sum <= 2'b10;
        else sum <= sum[1] + !SI;
    end
endmodule

module  Q35_J_Serial_2s_complemeter_TB;
    wire SO;
    reg SI,clk,rstn;
    Q35_J_Serial_2s_complemeter Serial_2s_Complementer (SO,SI,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #110 $finish;
    end
    initial fork 
        {rstn,SI} = 2'b01;
        #10 SI = 0;
        #20 {rstn,SI} = 2'b10;
        #30 SI = 1;
        #40 SI = 0;
        #50 SI = 1;
        #60 rstn = 0;
        #70 {rstn,SI} = 2'b10;
        #80 SI = 1;
        #100 SI = 0;
    join
    initial begin
        $dumpfile("6.35J.vcd");
        $dumpvars(0,Q35_J_Serial_2s_complemeter_TB);
    end
endmodule 