`timescale 1ns/100ps
module Q6 (F,X,Y,Z);
input X,Y,Z;
output F;

assign F = (X && Y) || (X && Z) || (Y && Z);
endmodule

module Q6TB ;
reg X,Y,Z;
wire F;

Q6 M0(F,X,Y,Z);
// Dumpfile and dumpvars for waveform generation

initial begin

$dumpfile("4.6TB.vcd");  // Specify dump file name

$dumpvars(0, Q6TB);  // Dump all signals in the testbench

end


// Apply various test cases
initial begin
    X = 1'b0; Y = 1'b0; Z = 1'b0;
    #4 X = 1'b0; Y = 1'b0; Z = 1'b1;
    #4 X = 1'b0; Y = 1'b1; Z = 1'b0;
    #4 X = 1'b0; Y = 1'b1; Z = 1'b1;
    #4 X = 1'b1; Y = 1'b0; Z = 1'b0;
    #4 X = 1'b1; Y = 1'b0; Z = 1'b1;
    #4 X = 1'b1; Y = 1'b1; Z = 1'b0;
    #4 X = 1'b1; Y = 1'b1; Z = 1'b1;
end
endmodule