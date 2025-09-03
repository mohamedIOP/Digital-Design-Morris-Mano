`timescale 1ns/1ps

module Q33 (F,X,Y);

output F;
input X,Y;
wire w1,w2,w3,w4;

not #(3) (w2,X);
not #(3) (w1,Y);
and #(6) (w3,X,w1);
and #(6) (w4,Y,w2);
or #(8) (F,w3,w4);

endmodule