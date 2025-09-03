module Q31A (F,A,B,C,D,E);
output F;
input A,B,C,D,E;
wire w1,w2,w3,w4;

assign w1 = B || C;
assign w2 = w1 && A && C && D;
assign w3 = B && (!C);
assign w4 = D && (!E);
assign F = w2 || w3 || w4;


endmodule
