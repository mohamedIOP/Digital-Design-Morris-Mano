module Q31E(F,A,B,C,D,E);
output F;
input A,B,C,D,E;

assign F = !(!(A || B)) && !(!(C || D)) && !(!E);
endmodule;