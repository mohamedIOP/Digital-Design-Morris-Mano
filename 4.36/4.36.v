module Q36 (input [0:3] D,output X,Y,V);
    wire w1,w2;
    not (w1,D[2]);
    and (w2,w1,D[1]);
    or (Y,D[3],w2),(X,D[2],D[3]),(V,X,D[1],D[0]);
endmodule