module Q55_BCD_Ripple_Counter(
    output [3:0] Q, 
    input Count,rstn
);
    wire Q1_and_Q2,Not_Q3;
    and (Q1_and_Q2,Q[1],Q[2]);
    not (Not_Q3,Q[3]);
    Q55_BCD_Ripple_Counter_JKFF JKFF_Q0 (Q[0],1'b1,1'b1,Count,rstn);
    Q55_BCD_Ripple_Counter_JKFF JKFF_Q1 (Q[1],Not_Q3,1'b1,Q[0],rstn);
    Q55_BCD_Ripple_Counter_JKFF JKFF_Q2 (Q[2],1'b1,1'b1,Q[1],rstn);
    Q55_BCD_Ripple_Counter_JKFF JKFF_Q3 (Q[3],Q1_and_Q2,1'b1,Q[0],rstn);
endmodule

module Q55_BCD_Ripple_Counter_JKFF (
    output reg Q,
    input J,K,clk,rstn
);
    always @(negedge clk or negedge rstn) begin
        if(!rstn) Q <= 0;
        else
            case ({J,K})
                2'b00: Q <= #5 Q;
                2'b01: Q <= #5 0;
                2'b10: Q <= #5 1;
                2'b11: Q <= #5 !Q;
                default : Q <= #5 0;
            endcase
    end
endmodule 

module Q55_BCD_Ripple_Counter_TB;
    wire [3:0] Q;
    reg Count,rstn;
    Q55_BCD_Ripple_Counter M0 (Q,Count,rstn);
    initial begin
        Count = 1;
        forever begin
            #50 Count = ~Count;
        end
    end
    initial begin
        #1700 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #100 rstn = 1;
        #1300 rstn = 0;
        #1400 rstn = 1;
    join
    initial begin
        $dumpfile("6.55.vcd");
        $dumpvars(0,Q55_BCD_Ripple_Counter_TB);
    end
endmodule