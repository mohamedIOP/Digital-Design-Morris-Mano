module Q7 (W,X,Y,Z,A,B,C,D);
output W,X,Y,Z;
input A,B,C,D;
wire w1,w2,w3;
assign w1 = A ^ B;
assign w2 = w1 ^ C;
assign w3 = w2 ^ D;
assign W = A;
assign X = w1;
assign Y = w2;
assign Z = w3;

endmodule

module Q7TB;
reg A,B,C,D;
wire W,X,Y,Z;

Q7 M0 (W,X,Y,Z,A,B,C,D);

initial begin
    $dumpfile("4.7TB.vcd");
    $dumpvars(0, Q7TB);
end

initial begin
    A = 1'b0;B = 1'b0; C = 1'b0; D = 1'b0;
    #4 A = 1'b0;B = 1'b0; C = 1'b0; D = 1'b1;
    #4 A = 1'b0;B = 1'b0; C = 1'b1; D = 1'b0;
    #4 A = 1'b0;B = 1'b0; C = 1'b1; D = 1'b1;
    #4 A = 1'b0;B = 1'b1; C = 1'b0; D = 1'b0;
    #4 A = 1'b0;B = 1'b1; C = 1'b0; D = 1'b1;
    #4 A = 1'b0;B = 1'b1; C = 1'b1; D = 1'b0;
    #4 A = 1'b0;B = 1'b1; C = 1'b1; D = 1'b1;
    #4 A = 1'b1;B = 1'b0; C = 1'b0; D = 1'b0;
    #4 A = 1'b1;B = 1'b0; C = 1'b0; D = 1'b1;
    #4 A = 1'b1;B = 1'b0; C = 1'b1; D = 1'b0;
    #4 A = 1'b1;B = 1'b0; C = 1'b1; D = 1'b1;
    #4 A = 1'b1;B = 1'b1; C = 1'b0; D = 1'b0;
    #4 A = 1'b1;B = 1'b1; C = 1'b0; D = 1'b1;
    #4 A = 1'b1;B = 1'b1; C = 1'b1; D = 1'b0;
    #4 A = 1'b1;B = 1'b1; C = 1'b1; D = 1'b1;
end
endmodule