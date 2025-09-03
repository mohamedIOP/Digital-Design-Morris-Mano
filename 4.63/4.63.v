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

module Q63_4_x_16_Decoder(
    output [15:0] D,
    input [3:0] A,
    input E
);
    wire 
        A3_Dash_A2_Dash,
        A3_Dash_A2,
        A3_A2_Dash,
        A3_A2;
    Two_x_Four_Decoder M0 ({A3_A2,A3_A2_Dash,A3_Dash_A2,A3_Dash_A2_Dash},A[3],A[2],E);
    Two_x_Four_Decoder M1 (D[3:0],A[1],A[0],A3_Dash_A2_Dash);
    Two_x_Four_Decoder M2 (D[7:4],A[1],A[0],A3_Dash_A2);
    Two_x_Four_Decoder M3 (D[11:8],A[1],A[0],A3_A2_Dash);
    Two_x_Four_Decoder M4 (D[15:12],A[1],A[0],A3_A2);
endmodule

module Q63_4_x_16_Decoder_TB;
    wire [15:0] D;
    reg [3:0] A;
    reg E;
    Q63_4_x_16_Decoder M0 (D,A,E);
    initial #1600 $finish;
    initial begin
        {E,A} = 5'b00000;
        repeat(31) #50 {E,A} = {E,A} + 5'b00001;
    end
    initial begin
        $dumpfile("4.63.vcd");
        $dumpvars(0,Q63_4_x_16_Decoder_TB);
    end
endmodule