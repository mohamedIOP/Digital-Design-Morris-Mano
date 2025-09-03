module Q39 (S,C,A,B);
output S,C;
input A,B;

xor (S,A,B);
and (C,A,B);

endmodule