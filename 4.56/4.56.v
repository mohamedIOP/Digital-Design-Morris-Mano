module Q56_4_Bit_Comparator(
    input [3:0] A,B,
    output Equal
);
        assign Equal = (A == B);
endmodule