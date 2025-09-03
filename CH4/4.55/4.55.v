module BCD_ADDER(
    input [3:0] Addend,Augend,
    input Carry_In,
    output reg Carr_Out,
    output reg [3:0] S
);
    wire [4:0] Binary_Sum = Addend + Augend + Carry_In;
    always @(Addend,Augend,Carry_In) begin
        if (Binary_Sum > 9) {Carr_Out, S} = Binary_Sum + 6;
        else {Carr_Out, S} = Binary_Sum;
    end
endmodule

module Nine_Complementer(
    input [3:0] BCD,
    output reg [3:0] BCD_Nine_Complemented
);
    always @(BCD) begin
        case (BCD)
            4'b0000 : BCD_Nine_Complemented = 4'b1001;
            4'b0001 : BCD_Nine_Complemented = 4'b1000;
            4'b0010 : BCD_Nine_Complemented = 4'b0111;
            4'b0011 : BCD_Nine_Complemented = 4'b0110;
            4'b0100 : BCD_Nine_Complemented = 4'b0101;
            4'b0101 : BCD_Nine_Complemented = 4'b0100;
            4'b0110 : BCD_Nine_Complemented = 4'b0011;
            4'b0111 : BCD_Nine_Complemented = 4'b0010;
            4'b1000 : BCD_Nine_Complemented = 4'b0001;
            4'b1001 : BCD_Nine_Complemented = 4'b0000;
            default : BCD_Nine_Complemented = 4'bxxxx;
        endcase
    end
endmodule

module Q55_BCD_Adder_Subtractor(
    input [3:0] A,B,
    input Mode,
    output [3:0] S,
    output C
);
    wire [3:0] B_Nine_Complement;
    Nine_Complementer M0 (B,B_Nine_Complement);
    wire [3:0] Quadruple_MUX = (Mode) ? (B_Nine_Complement) : (B);
    BCD_ADDER M1 (A,Quadruple_MUX,Mode,C,S);
endmodule