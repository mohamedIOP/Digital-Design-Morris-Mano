module Q7_Unsigned_Subtractor (
    output [7:0] result,
    output done,
    input [7:0] data_A,data_B,
    input start,reset_b,clock
);
    wire borrow,Load_A_B,Subtract,Convert;
    Q7_Unsigned_Subtractor_Controller Controller (done,Load_A_B,Subtract,Convert,start,borrow,reset_b,clock);
    Q7_Unsigned_Subtractor_Datapath Datapath (result,borrow,data_A,data_B,Load_A_B,Subtract,Convert,clock);
endmodule

module Q7_Unsigned_Subtractor_Controller (
    output reg done,Load_A_B,Subtract,Convert,
    input start,borrow,reset_b,clock
);
    parameter [1:0] S0 = 2'b00,S1 = 2'b01,S2 = 2'b10;
    reg [1:0] state,next_state;
    always @(posedge clock or negedge reset_b) begin
        if(!reset_b) state <= S0;
        else state <= next_state;
    end
    always @(state,start,borrow) begin
        Convert <= 0;
        Subtract <= 0;
        Load_A_B <= 0;
        done <= 0;
        if(reset_b)
            case (state)
                S0: begin 
                        done <= 1;
                        if(start) begin 
                            Load_A_B <= 1;
                            next_state <= S1;
                        end 
                        else next_state <= S0;
                    end
                S1: begin
                    Subtract <= 1;
                    next_state <= S2;
                end
                S2: begin
                    if(borrow) Convert <= 1;
                    next_state <= S0;
                end
                default : next_state <= S0;
            endcase
    end
endmodule

module Q7_Unsigned_Subtractor_Datapath (
    output [7:0] result,
    output borrow,
    input [7:0] data_A,data_B,
    input Load_A_B,Subtract,Convert,clock
);
    reg [7:0] Reg_A,Reg_B;
    reg Carry;
    always @(posedge clock) begin
        if(Load_A_B) begin
            Reg_A <= data_A;
            Reg_B <= data_B;
        end
        else if (Subtract) {Carry, Reg_A} <= {1'b0, Reg_A} + {1'b0, ~Reg_B} + 9'b000000001;
        else if (Convert) Reg_A <= ~Reg_A + 1'b1;
    end
    assign result = Reg_A;
    assign borrow = ~Carry;
endmodule 

module Q7_Unsigned_Subtractor_TB;
    wire [7:0] result;
    wire done;
    reg [7:0] data_A,data_B;
    reg start,reset_b,clock;
    Q7_Unsigned_Subtractor Unsigned_Subtractor (result,done,data_A,data_B,start,reset_b,clock);
    initial begin
        clock = 0;
        forever begin
            #5 clock = ~clock;
        end
    end
    initial begin
        #130 $finish;
    end
    initial fork
        #0 reset_b = 0;
        #20 reset_b = 1;
        #90 reset_b = 0;
        #100 reset_b = 1;
        #0 start = 0;
        #10 start = 1;
        #20 start = 0;
        #30 start = 1;
        #0 {data_A,data_B} = {8'b10101010,8'b01010101};
        #60 {data_A,data_B} = {8'b01010101,8'b10101010};
        #100 {data_A,data_B} = {8'b00001111,8'b00000011};
    join
    initial begin
        $dumpfile("8.7.vcd");
        $dumpvars(0,Q7_Unsigned_Subtractor_TB);
    end
endmodule 