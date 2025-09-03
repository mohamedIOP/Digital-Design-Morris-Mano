module FA(
    input X,Y,Z,
    output S,C
);
    wire X_XOR_Y,X_AND_Y,Z_AND_XXORY;
    xor (X_XOR_Y,X,Y);
    and (X_AND_Y,X,Y);
    xor (S,X_XOR_Y,Z);
    and (Z_AND_XXORY,X_XOR_Y,Z);
    or (C,Z_AND_XXORY,X_AND_Y);
endmodule

module Four_Bit_Adder(
    input [3:0] A,B,
    input Carry_In,
    output [3:0] S,
    output Carry_Out
);
    wire C1,C2,C3;
    FA M0 (A[0],B[0],Carry_In,S[0],C1);
    FA M1 (A[1],B[1],C1,S[1],C2);
    FA M2 (A[2],B[2],C2,S[2],C3);
    FA M3 (A[3],B[3],C3,S[3],Carry_Out);
endmodule

module BCD_Adder(
    input [3:0] A,B,
    input Carry_In,
    output [3:0] S,
    output Carry_Out
);
    wire [3:0] Z;
    wire Z8_AND_Z4,Z8_AND_Z2,K;
    Four_Bit_Adder M0 (A,B,Carry_In,Z,K);
    and (Z8_AND_Z4,Z[3],Z[2]);
    and (Z8_AND_Z2,Z[3],Z[1]);
    or (Carry_Out,K,Z8_AND_Z2,Z8_AND_Z4);
    wire [3:0] fixer;
    assign fixer = {1'b0,Carry_Out,Carry_Out,1'b0};
    wire secondCarry;
    Four_Bit_Adder M1 (Z,fixer,1'b0,S,secondCarry);
endmodule