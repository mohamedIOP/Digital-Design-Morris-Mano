module Q61_4_Bit_Even_Parity_Checker(
    output C,
    input X,Y,Z,P
    );
    assign C = X ^ Y ^ Z ^ P;
endmodule

module Q61_4_Bit_Even_Parity_Checker_TB;
    wire C;
    reg X,Y,Z,P;
    Q61_4_Bit_Even_Parity_Checker M0 (C,X,Y,Z,P);
    initial #800 $finish;
    initial begin
        {X,Y,Z,P} = 4'b0000;
        repeat(15) #50 {X,Y,Z,P} = {X,Y,Z,P} + 4'b0001;
    end
    initial begin
        $dumpfile("4.61.vcd");
        $dumpvars(0,Q61_4_Bit_Even_Parity_Checker_TB);
    end
endmodule