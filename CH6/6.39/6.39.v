module Q39_Fig_6_16_Behavioral (
    output reg [2:0] Count,
    input clk,rstn
);
    parameter   [2:0] 
                S0 = 3'b000, 
                S1 = 3'b001, 
                S2 = 3'b010, 
                S3 = 3'b011, 
                S4 = 3'b100, 
                S5 = 3'b101, 
                S6 = 3'b110, 
                S7 = 3'b111; 
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Count <= 3'b000;
        else
            case (Count)
                S0,S1,S5,S4: Count <= Count + 3'b001;
                S2,S3: Count <= S4;
                S6,S7: Count <= S0;
            endcase
    end
endmodule

module Q39_Fig_6_16_Structural (
    output A,B,C,
    input clk,rstn
);
    wire Not_B;
    not (Not_B,B);
    Q39_Fig_6_16_Structural_JKFF JKFF_A (A,B,B,clk,rstn);
    Q39_Fig_6_16_Structural_JKFF JKFF_B (B,C,1'b1,clk,rstn);
    Q39_Fig_6_16_Structural_JKFF JKFF_C (C,Not_B,1'b1,clk,rstn);
endmodule 

module Q39_Fig_6_16_Structural_JKFF (
    output reg Q,
    input J,K,clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Q <= 0;
        else
            case ({J,K})
                2'b00: Q <= Q;
                2'b01: Q <= 0;
                2'b10: Q <= 1;
                2'b11: Q <= ~Q;
            endcase
    end
endmodule 

module Q39_Fig_6_16_TB;
    wire A_Structural,B_Structural,C_Structural;
    wire [2:0] Count;
    reg clk,rstn;
    Q39_Fig_6_16_Behavioral Behavioral_Model (Count,clk,rstn);
    Q39_Fig_6_16_Structural Structural_Model (A_Structural,B_Structural,C_Structural,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #130 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #10 rstn = 1;
        #80 rstn = 0;
        #90 rstn = 1;
    join
    initial begin
        $dumpfile("6.39.vcd");
        $dumpvars(0,Q39_Fig_6_16_TB);
    end
endmodule