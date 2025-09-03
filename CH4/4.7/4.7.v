module Q7 (W,X,Y,Z,A,B,C,D);
output W,X,Y,Z;
input A,B,C,D;
wire w1,w2,w3;
assign w1 = A ^ B;
assign w2 = w1 ^ C;
assign w3 = w2 ^ D;
assign W = A;
assign X = w1;
assign Y = w2;
assign Z = w3;

endmodule