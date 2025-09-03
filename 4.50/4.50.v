// from solution manual he have handled after 9 codes


`timescale 1ps/1ps
module Q50A(
    input [3:0] X,
    output reg [3:0] Y
);
    always @(X) begin
        case (X)
            4'b0000 : Y = 4'b0000;
            4'b0111 : Y = 4'b0001;
            4'b0110 : Y = 4'b0010;
            4'b0101 : Y = 4'b0011;
            4'b0100 : Y = 4'b0100;
            4'b1011 : Y = 4'b0101;
            4'b1010 : Y = 4'b0110;
            4'b1001 : Y = 4'b0111;
            4'b1000 : Y = 4'b1000;
            4'b1111 : Y = 4'b1001;
            default Y = 4'bzzzz;
        endcase
    end
endmodule

module Q50B(
    input [3:0] X,
    output reg [3:0] Y
);
    always @(X) begin
        case (X)
            4'b0000 : Y = 4'b0000;
            4'b0111 : Y = 4'b0001;
            4'b0110 : Y = 4'b0011;
            4'b0101 : Y = 4'b0010;
            4'b0100 : Y = 4'b0110;
            4'b1011 : Y = 4'b0111;
            4'b1010 : Y = 4'b0101;
            4'b1001 : Y = 4'b0100;
            4'b1000 : Y = 4'b1100;
            4'b1111 : Y = 4'b1101;
            default Y = 4'bzzzz;
        endcase
    end
endmodule

module Q50TB;
    reg [3:0] X;
    wire [3:0] Fa,Fb;
    Q50A M0 (X,Fa);
    Q50B M1 (X,Fb);
    initial #800 $finish;
    initial begin
        X = 4'b0000;
        repeat (15) #50 X = X + 4'b0001;
    end
    initial begin
        $dumpfile("4.50TB.vcd");
        $dumpvars(0,Q50TB);
    end
endmodule