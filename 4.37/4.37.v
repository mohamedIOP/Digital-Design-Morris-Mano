module fullAdder(output S,C,input X,Y,Z);
    wire w1,w2,w3;
    xor (w1,X,Y);
    and (w2,X,Y),(w3,w1,Z);
    xor (S,w1,Z);
    or (C,w3,w2);
endmodule

module Q37(output [3:0] S,output C,input [3:0] A, B,input M);
    wire w0,w1,w2,w3,c1,c2,c3;
    xor (w0,B[0],M),(w1,B[1],M),(w2,B[2],M),(w3,B[3],M);
    fullAdder FA0 (S[0],c1,A[0],w0,M);
    fullAdder FA1 (S[1],c2,A[1],w1,c1);
    fullAdder FA2 (S[2],c3,A[2],w2,c2);
    fullAdder FA3 (S[3],C,A[3],w3,c3);
endmodule