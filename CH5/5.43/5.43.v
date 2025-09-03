module Q43_Three_Bit_Binary_Counter_Behavioral(
    input clk,rstn
);
    reg [2:0] state,next_state;
    parameter   [2:0] 
                S0 = 3'b000,
                S1 = 3'b001,
                S2 = 3'b010,
                S3 = 3'b011,
                S4 = 3'b100,
                S5 = 3'b101,
                S6 = 3'b110,
                S7 = 3'b111;
    //  Change The State
    always @(posedge clk or negedge rstn) begin
        if (!rstn) state <= S0;
        else state <= next_state; 
    end
    // Obtaining the next state
    always @(state) begin
        if(state == S7) next_state = S0;
        else next_state = state + 3'b001;
    end
endmodule //5.43

module Q43_Three_Bit_Binary_Counter_Behavioral_TB;
    reg clk,rstn;
    Q43_Three_Bit_Binary_Counter_Behavioral M0 (clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #120 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #20 rstn = 1;
        #100 rstn = 0;
    join
    initial begin
        $dumpfile("5.43.vcd");
        $dumpvars(0,Q43_Three_Bit_Binary_Counter_Behavioral_TB);
    end
endmodule //5.43