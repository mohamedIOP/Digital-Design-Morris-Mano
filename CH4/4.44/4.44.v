`timescale 1ps/1ps
module Q44 (
    output reg [7:0] Y,
    input [7:0] A,B,
    input [2:0] Sel
);
    always @(Sel,A,B) begin
        case(Sel)
            3'b000: Y = 8'b0;
            3'b001: Y = A & B;
            3'b010: Y = A | B;
            3'b011: Y = A ^ B;
            3'b100: Y = ~A;
            3'b101: Y = A - B;
            3'b110: Y = A + B;
            3'b111: Y = 8'hFF;
        endcase
    end
endmodule

module Q44TB;
    reg [7:0] A,B;
    reg [2:0] Sel;
    wire [7:0] Y;
    Q44 M (Y,A,B,Sel);
    initial #200 $finish;

    initial begin
        A = 8'h0F;B = 8'h11;Sel = 3'b000;
        repeat(7) #10 Sel = Sel + 3'b001;
    end
    initial begin

    $dumpfile("4.44.vcd");  // Specify dump file name

    $dumpvars(0, Q44TB);  // Dump all signals in the testbench

    end
    initial begin
        $display("T:000, A:76543210, B:76543210, Sel:210, Y:76543210");
        $monitor("T:%0d, A:%b, B:%b, Sel:%b, Y:%b",$time,A,B,Sel,Y);
    end
endmodule