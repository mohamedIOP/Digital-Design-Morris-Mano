module Shift_Register_4_beh(
    output reg [3:0] A_par,
    input [3:0] I_par,
    input   S1,S0,
            MSB_in,LSB_in,
            CLK,Clear_b
);
    always @(posedge CLK, negedge Clear_b) begin
        if (Clear_b == 0) A_par <= 4'b0000;
        else
            case ({S1,S0})
                2'b00: A_par <= A_par;
                2'b01: A_par <= {MSB_in,A_par[3:1]};
                2'b10: A_par <= {A_par[2:0],LSB_in};
                2'b11: A_par <= I_par;
            endcase
    end
endmodule

module Q49_Shift_Register_4_beh_TB ;
    wire [3:0] A_par;
    reg [3:0] I_par;
    reg S1,S0,
        MSB_in,LSB_in,
        CLK,Clear_b;
    Shift_Register_4_beh M0 (A_par,I_par,S1,S0,MSB_in,LSB_in,CLK,Clear_b);
    initial begin
        CLK = 0;
        forever begin
            #5 CLK = ~CLK;
        end
    end
    initial begin
        #160 $finish;
    end
    initial fork 
        #0 Clear_b = 0;
        #40 Clear_b = 1;
        #80 Clear_b = 0;
        #90 Clear_b = 1;
        #0 {MSB_in,LSB_in} = 2'b11;
        #40 {MSB_in,LSB_in} = 2'b10;
        #90 {MSB_in,LSB_in} = 2'b01;
        #140 {MSB_in,LSB_in} = 2'b11;
        #0 {S1,S0} = 2'b00;
        #10 {S1,S0} = 2'b01;
        #20 {S1,S0} = 2'b10;
        #30 {S1,S0} = 2'b11;
        #40 {S1,S0} = 2'b01;
        #90 {S1,S0} = 2'b10;
        #130 {S1,S0} = 2'b00;
        #140 {S1,S0} = 2'b11;
        #0 I_par = 4'b1010;
        #150 I_par = 4'b1111;
    join
    initial begin
        $dumpfile("6.49.vcd");
        $dumpvars(0,Q49_Shift_Register_4_beh_TB);
    end
endmodule  
