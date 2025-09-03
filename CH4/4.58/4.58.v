module Q58_Shift_Arithmetic_Right(
    input [31:0] X,
    output [31:0] Y
);
    assign Y[31:29] = X[2:0];
    assign Y[28:0] = X[31:3];
endmodule

module Q58_Shift_Logical_Right(
    input [31:0] X,
    output [31:0] Y
);
    assign Y = {3'b000,X[31:3]};
endmodule