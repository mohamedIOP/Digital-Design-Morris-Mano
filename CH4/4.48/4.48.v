module Q48(
    output tri [7:0] Y,
    input [7:0] A,B,
    input [2:0] Sel,
    input En
);
    reg [7:0] YBefore;
    assign Y = En ? YBefore : 8'bz;
    always @(A,B,Sel) begin
        case (Sel)
            3'b000 : YBefore = 8'b0;
            3'b001 : YBefore = A & B;
            3'b010 : YBefore = A | B;
            3'b011 : YBefore = A ^ B;
            3'b100 : YBefore = ~A;
            3'b101 : YBefore = A - B;
            3'b110 : YBefore = A + B;
            3'b111 : YBefore = 8'hFF;
        endcase
    end
endmodule

