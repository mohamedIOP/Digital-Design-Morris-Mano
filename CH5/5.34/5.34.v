module Q34_SR_Latch_E(
    output Q,
    input S,R,En
);
    wire Q_bar,S_Nand_En,R_Nand_En;
    nand    (S_Nand_En,S,En),
            (R_Nand_En,R,En),
            (Q,S_Nand_En,Q_bar),
            (Q_bar,Q,R_Nand_En);
endmodule

module Q34_SR_Latch_E_TB;
    wire Q;
    reg S,R,En;
    Q34_SR_Latch_E M0 (Q,S,R,En);
    initial begin
        #80 $finish;
    end
    initial fork 
        #0 {S,R,En} = 3'b101;
        #10 {S,R,En} = 3'b001;
        #20 {S,R,En} = 3'b011;
        #30 {S,R,En} = 3'b001;
        #40 {S,R,En} = 3'b100;
        #50 {S,R,En} = 3'b000;
        #60 {S,R,En} = 3'b010;
        #70 {S,R,En} = 3'b000;
    join
    initial begin
        $dumpfile("5.34.vcd");
        $dumpvars(0,Q34_SR_Latch_E_TB);
    end
endmodule