module Q40 (
    input [3:0] A,B,
    input M,
    output [4:0] S,
    output C
);
    assign S = (M) ? (A - B) : (A + B);
    assign C = S[4];
endmodule