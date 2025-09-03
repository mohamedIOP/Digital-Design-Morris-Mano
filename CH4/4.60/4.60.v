`timescale 1ps/1ps
module Q60_4_Bit_Even_Parity_Checker(
    input X,Y,Z,P,
    output C
);
    wire w1,w2;
    xor (w1,X,Y);
    xor (w2,Z,P);
    xor (C,w1,w2);
endmodule

module Q60_4_Bit_Even_Parity_Checker_TB;
    reg X,Y,Z,P;
    wire C;
    Q60_4_Bit_Even_Parity_Checker M0 (X,Y,Z,P,C);
    initial #800 $finish;
    initial begin
        {X,Y,Z,P} = 4'b0000;
        repeat(15) #50 {X,Y,Z,P} = {X,Y,Z,P} + 4'b0001;
    end
    initial begin
        $dumpfile("4.60.vcd");
        $dumpvars(0,Q60_4_Bit_Even_Parity_Checker_TB);
    end
endmodule