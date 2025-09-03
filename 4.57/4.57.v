`timescale 1ps/1ps
module Q57_4_Bit_Priority_Encoder(
    input  [3:0] D,
    output reg       X,
    output reg       Y,
    output reg       V
);
    always @D begin
        casex (D)
            4'b???1 : {X,Y,V} = 3'b001;
            4'b??10 : {X,Y,V} = 3'b011; 
            4'b?100 : {X,Y,V} = 3'b101; 
            4'b1000 : {X,Y,V} = 3'b111;  
            default : {X,Y,V} = 3'bxx0;  
        endcase
    end
endmodule

module Q57_4_Bit_Priority_Encoder_TB;
    reg [3:0] D;
    wire X,Y,V;
    Q57_4_Bit_Priority_Encoder M0 (D,X,Y,V);
    initial begin
        #800 $finish;
    end
    initial begin
        D = 4'b0;
        repeat(15) #50 D = D + 4'b0001;    
    end
    initial begin
        $dumpfile("4.57.vcd");
        $dumpvars(0,Q57_4_Bit_Priority_Encoder_TB);
    end
endmodule