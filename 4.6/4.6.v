module Q6 (F,X,Y,Z);
input X,Y,Z;
output F;

assign F = (X && Y) || (X && Z) || (Y && Z);
endmodule