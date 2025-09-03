`timescale 1ps/1ps
module Q51(
    input A,B,C,D,
    output reg a,b,c,d,e,f,g
);
        always @(A,B,C,D) begin
            a = ((!A) && C) || ((!A) && B && D) || ((!B) && (!C) && (!D)) || (A && (!B) && (!C));
            b = ((!A) && (!B)) || ((!A) && (!C) && (!D)) || ((!A) && C && D) || (A && !B && !C);
            c = (!A && B) || (!A && D) || (!B && !C && !D) || (A && !B && !C);
            d = (!A && C && !D) || (!A && !B && C) || (!B && !C && !D) || (A && !B && !C) || (!A && B && !C && D);
            e = (!A && C && !D) || (!B && !C && !D);
            f = (A && !B && !C) || (!A && !C && !D) || (!A && B && !C) || (!A && B && !D);
            g = (!A && C && !D) || (!A && !B && C) || (!A && B && !C) || (A && !B && !C);
        end
endmodule

module Q51TB;
    reg A,B,C,D;
    wire a,b,c,d,e,f,g;
    Q51 M0 (A,B,C,D,a,b,c,d,e,f,g);
    initial #800 $finish;
    initial begin
        {A,B,C,D} = 4'b0000;
        repeat(15) #50 {A,B,C,D} = {A,B,C,D} + 4'b0001;
    end
    initial begin
        $dumpfile("4.51.vcd");
        $dumpvars(0,Q51TB);
    end
endmodule