module Q47(
    input A,B,C,D,
    output Fa,Fb
);
    assign 
            Fa = A ? (B ? (1'b1) : (C && D)) : (B ? (!C && !D) : (D)),
            Fb = A ? (B ? (D) : (C || !D)) : (B ? (D) : (C ^ D));
endmodule

module Q47TB;
    reg A,B,C,D;
    wire Fa,Fb;
    Q47 M0 (A,B,C,D,Fa,Fb);
    initial #800 $finish;
    initial begin
        $dumpfile("4.47.vcd");
        $dumpvars(0, Q47TB);
    end
    initial begin
        A = 0;B = 0;C = 0;D = 0;
        repeat (15) #50 {A,B,C,D} = {A,B,C,D} + 4'b0001;
    end
    initial begin
        $display("A:B:C:D:Fa:Fb");
        $monitor("%b:%b:%b:%b:%b:%b",A,B,C,D,Fa,Fb);
    end
endmodule