`timescale 1ps/1ps
module Q49(
    input A,B,C,D,
    output F1,F2
);
    wire T1,T2,T3,T4;
    wire Not_B,Not_A,Not_D;
    not (Not_A,A),
        (Not_B,B),
        (Not_D,D);
    and (T1,Not_B,C),
        (T2,Not_A,B);
    or  (T3,A,T1),
        (F2,T2,Not_D);
    xor (T4,T2,D);
    or  (F1,T3,T4);
endmodule

module Q49TB;
    reg A,B,C,D;
    wire F1,F2;
    Q49 M0 (A,B,C,D,F1,F2);
    initial #800 $finish;
    initial begin
        $dumpfile("4.49.vcd");
        $dumpvars(0,Q49TB);
    end
    initial begin
        A = 0;B = 0;C = 0;D = 0;
        repeat (15) #50 {A,B,C,D} = {A,B,C,D} + 4'b0001;
    end
endmodule