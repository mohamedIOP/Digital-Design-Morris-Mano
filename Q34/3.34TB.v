module Q34(Out_1,Out_2,Out_3,A,B,C,D);
input A,B,C,D;
output Out_1,Out_2,Out_3;

assign Out_1 = (A || !B) && (!C) && (C || D);
assign Out_2 = ((!C && D) || (B && C && D) || (C && !D)) && (!A || B);
assign Out_3 = (((A && B) || C) && D) || (!B && C);

endmodule

`timescale 1ns/1ps

module tb_Q34;
  // 1) Declare inputs as regs, outputs as wires
  reg  A, B, C, D;
  wire Out_1, Out_2, Out_3;

  // 2) Instantiate the Unit Under Test
  Q34 uut (
    .Out_1(Out_1),
    .Out_2(Out_2),
    .Out_3(Out_3),
    .A(A),
    .B(B),
    .C(C),
    .D(D)
  );

  // 3) VCD dump for GTKWave
  initial begin
    $dumpfile("tb_Q34.vcd");
    $dumpvars(0, tb_Q34);
  end

  // 4) Drive all input combinations and display results
  integer i;
  initial begin
    $display("\nTime | A B C D | Out_1 Out_2 Out_3");
    for (i = 0; i < 16; i = i + 1) begin
      {A, B, C, D} = i;      // MSB→LSB = A,B,C,D
      #10;                   // wait 10ns between vectors
      $display("%4dns | %b %b %b %b |   %b     %b      %b",
               $time, A, B, C, D, Out_1, Out_2, Out_3);
    end
    #10 $finish;             // end simulation
  end
endmodule
