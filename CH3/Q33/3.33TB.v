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

module tb_Q33 ();
reg x, y;
wire F;
Q33 M0 (F, x, y);
// Dumpfile and dumpvars for waveform generation

initial begin

$dumpfile("tb_Q33.vcd");  // Specify dump file name

$dumpvars(0, tb_Q33);  // Dump all signals in the testbench

end
initial #200 $finish;
initial fork
x = 0;
y = 0;
#20 y = 1;
join
endmodule