module Q52A(
    input [3:0] A,
    output [3:0] Y,
    output Carry
);
    assign {Carry,Y} = A + 4'b0001;
endmodule

module Q52B(
    input [3:0] A,
    output [3:0] Y,
    output Borrow
);
    assign {Borrow,Y} = A - 4'b0001;
endmodule

module Q52TB;
    reg [3:0] A;
    wire [3:0] Ya,Yb;
    wire Carry,Borrow;
    Q52A M0 (A,Ya,Carry);
    Q52B M1 (A,Yb,Borrow);
    initial #800 $finish;
    initial begin
        A = 4'b0000;
        repeat(15) #50 A = A + 4'b0001;
    end
    initial begin
        $dumpfile("4.52.vcd");
        $dumpvars(0,Q52TB);
    end
endmodule