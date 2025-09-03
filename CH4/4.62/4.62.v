`timescale 1ps/1ps
module Two_x_Four_Decoder(
    output [3:0] D,
    input X,Y,E
);
    wire Not_X,Not_Y;
    not (Not_X,X);
    not (Not_Y,Y);
    and (D[0],Not_X,Not_Y,E);
    and (D[1],Not_X,Y,E);
    and (D[2],X,Not_Y,E);
    and (D[3],X,Y,E);
endmodule

module Three_x_Eight_Decoder(
    output [7:0] D,
    input X,Y,Z,E
);
    wire Not_X,Not_Y,Not_Z;
    not (Not_X,X),
        (Not_Y,Y),
        (Not_Z,Z);
    and (D[0],Not_X,Not_Y,Not_Z,E),
        (D[1],Not_X,Not_Y,Z,E),
        (D[2],Not_X,Y,Not_Z,E),
        (D[3],Not_X,Y,Z,E),
        (D[4],X,Not_Y,Not_Z,E),
        (D[5],X,Not_Y,Z,E),
        (D[6],X,Y,Not_Z,E),
        (D[7],X,Y,Z,E);
endmodule

module Q62_5_x_32_Decoder(
    output [31:0] D,
    input [4:0] A,
    input E
);
    wire 
        A4_Dash_A3_Dash,
        A4_Dash_A3,
        A4_A3_Dash,
        A4_A3;
    Two_x_Four_Decoder M0 ({A4_A3,A4_A3_Dash,A4_Dash_A3,A4_Dash_A3_Dash},A[4],A[3],E);
    Three_x_Eight_Decoder M1 (D[7:0],A[2],A[1],A[0],A4_Dash_A3_Dash);
    Three_x_Eight_Decoder M2 (D[15:8],A[2],A[1],A[0],A4_Dash_A3);
    Three_x_Eight_Decoder M3 (D[23:16],A[2],A[1],A[0],A4_A3_Dash);
    Three_x_Eight_Decoder M4 (D[31:24],A[2],A[1],A[0],A4_A3);
endmodule

module Q62_5_x_32_Decoder_TB;
    wire [31:0] D;
    reg [4:0] A;
    reg E;
    Q62_5_x_32_Decoder M0 (D,A,E);
    initial #3200 $finish;
    initial begin
        {E,A} = 6'b000000;
        repeat(63) #50 {E,A} = {E,A} + 6'b000001;
    end
    initial begin
        $dumpfile("4.62.vcd");
        $dumpvars(0,Q62_5_x_32_Decoder_TB);
    end
endmodule