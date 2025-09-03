module Q28_Fig_5_17_A_Behavioral_Model (
    output F,
    input X,Y,clk,rstn
);
    reg state;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) state <= 0;
        else
            case ({X,Y})
                2'b00: if (state) state <= 1;
                        else state <= 0;
                2'b01: if (state) state <= 0;
                        else state <= 1;
                2'b10: if (state) state <= 0;
                        else state <= 1;
                2'b11: if (state) state <= 1;
                        else state <= 0;
            endcase
    end
    assign F = state;
endmodule

module Q28_DFF (
    output reg Q,
    input D,clk,rstn
);
    always @(posedge clk or negedge rstn) begin
        if(!rstn) Q <= 0;
        else Q <= D;
    end
endmodule

module Q28_Fig_5_17_B_Structural_Model(
    output F,
    input X,Y,clk,rstn
);
    wire X_XOR_Y,D;
    assign X_XOR_Y = X ^ Y;
    assign D = (X_XOR_Y) ^ F;
    Q28_DFF M0 (F,D,clk,rstn);
endmodule

module Q28_TB;
    wire F_Structural,F_Behavioral;
    reg X,Y,clk,rstn;
    Q28_Fig_5_17_A_Behavioral_Model M0 (F_Behavioral,X,Y,clk,rstn);
    Q28_Fig_5_17_B_Structural_Model M1 (F_Structural,X,Y,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial fork 
        #0 {X,Y,rstn} = 3'b000;
        #10 {X,Y,rstn} = 3'b001;
        #20 {X,Y,rstn} = 3'b011;
        #30 {X,Y,rstn} = 3'b111;
        #40 {X,Y,rstn} = 3'b101;
    join
    initial begin
        #50 $finish;
    end
    initial begin
        $dumpfile("5.28.vcd");
        $dumpvars(0,Q28_TB);
    end
endmodule