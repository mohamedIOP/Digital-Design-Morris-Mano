`timescale 1ps/1ps
module Q35_G (
    output reg [3:0] A,
    input count,reset
);
    always @(negedge reset,negedge count) begin
        if (!reset)A <= 4'b0000;
        else A[0] <= #5 ~A[0];
    end
    always @(negedge A[0]) begin
        if(reset) A[1] <= #5 ~A[1];
    end
    always @(negedge A[1]) begin
        if(reset) A[2] <= #5 ~A[2];
    end
    always @(negedge A[2]) begin
        if(reset) A[3] <= #5 ~A[3];
    end
endmodule 
module Q35_G_TB;
    wire [3:0] A;
    reg count,reset;
    Q35_G Model (A,count,reset);
    initial begin
        #2600 $finish;
    end
    initial begin
        $dumpfile("6.35G.vcd");
        $dumpvars(0,Q35_G_TB);
    end
    initial fork
        reset = 0;
        #200 reset = 1;
        #2100 reset = 0;
        #2300 reset = 1;
    join
    initial begin
        count = 0;
        #100 count = 1;
        #150 count  = 0;
        forever begin
            #50 count = ~count;
        end
    end
endmodule