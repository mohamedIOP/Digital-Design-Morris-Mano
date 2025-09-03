module Q31C(F,A,B,C,D);
output F;
input A,B,C,D;
assign F = ((A && (!B)) || ((!A) && B)) && (C || (!D));
endmodule