module Q64_Octal_To_Binary(
    output reg X,Y,Z,V,
    input [0:7] D
);
    always @(D) begin
        casex (D)
            8'b0000_0000 : {X,Y,Z,V} = 4'bxxx0;  
            8'b1000_0000 : {X,Y,Z,V} = 4'b0001;  
            8'b?100_0000 : {X,Y,Z,V} = 4'b0011;  
            8'b??10_0000 : {X,Y,Z,V} = 4'b0101;  
            8'b???1_0000 : {X,Y,Z,V} = 4'b0111;  
            8'b????_1000 : {X,Y,Z,V} = 4'b1001;  
            8'b????_?100 : {X,Y,Z,V} = 4'b1011;  
            8'b????_??10 : {X,Y,Z,V} = 4'b1101;  
            8'b????_???1 : {X,Y,Z,V} = 4'b1111;  
        endcase
    end
endmodule

module Q64_Octal_To_Binary_TB;
    wire X,Y,Z,V;
    reg [0:7] D;
    Q64_Octal_To_Binary M0 (X,Y,Z,V,D);
    initial #1000 $finish;
    initial begin
        D = 8'h00;
        #100 D = 8'h01;
        repeat(7) #100 D = D << 1;
    end
    initial begin
        $dumpfile("4.64.vcd");
        $dumpvars(0,Q64_Octal_To_Binary_TB);
    end
endmodule