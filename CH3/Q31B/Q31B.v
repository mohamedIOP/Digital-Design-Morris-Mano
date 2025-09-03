module Q31B(F,A,B,C,D);
output F;
input A,B,C,D;
assign F = !(!((!(!(C && D)) || !(!B)) && A)) || !(!(B && (!C)));
endmodule