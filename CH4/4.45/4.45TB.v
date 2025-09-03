`timescale 1ps/1ps
module Q45(
    input [3:0] D,
    output reg X,Y,V
);
    always @(D) begin
        if (D > 0) V = 1'b1; 
        else V = 1'b0;
        if (D[3]) begin
            X = 1'b1;Y = 1'b1;
        end
        else if (D[2]) begin
            X = 1'b1;Y = 1'b0;
        end
        else if (D[1]) begin
            X = 1'b0;Y = 1'b1;
        end
        else if (D[0]) begin
            X = 1'b0;Y = 1'b0;
        end
    end
endmodule

module Q45TB;
    reg [3:0] D;
    wire X,Y,V;
    Q45 M (D,X,Y,V);
    initial #800 $finish;
    initial begin
        D = 4'b0000;
        repeat(15) #50 D = D + 4'b0001;
    end
    initial begin

    $dumpfile("4.45.vcd");  // Specify dump file name

    $dumpvars(0, Q45TB);  // Dump all signals in the testbench

    end
    initial begin
        $display("T:D:XYV");
        $monitor("%0d:%b:%b%b%b",$time,D,X,Y,V);
    end
endmodule