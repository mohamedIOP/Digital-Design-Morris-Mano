`timescale 1ps/1ps
module Q46A (
    input A,B,C,D,
    output F
);
    assign F = A ? (B ? (C ? (!D) : 1'b0) : (!D)) : (B ? (C ? (1'b0) : (D)) : (!D));
endmodule

module Q46B (
    input A,B,C,D,
    output F
);
    assign F = A ? (B ? (1'b1) : (C ? (!D) : (1'b1))) : (B ? (C ? (D) : (1'b1)) : (C ? (D) : (1'b1)));
endmodule

module Q46TB;
    reg A,B,C,D;
    wire Fa,Fb;
    Q46A M0 (A,B,C,D,Fa);
    Q46B M1 (A,B,C,D,Fb);
    initial #800 $finish;
    initial begin
        A = 0;B = 0;C = 0;D = 0;
        repeat(15) #50 {A,B,C,D} = {A,B,C,D} + 4'b0001;
    end
    initial begin

    $dumpfile("4.46.vcd");  // Specify dump file name

    $dumpvars(0, Q46TB);  // Dump all signals in the testbench

    end
    initial begin
        $display("A:B:C:D:Fa:Fb");
        $monitor("%b:%b:%b:%b:%b:%b",A,B,C,D,Fa,Fb);
    end
endmodule