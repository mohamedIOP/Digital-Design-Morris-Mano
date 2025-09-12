module Q8_System(
    output [15:0] Result_Reg,
    output done,
    input [15:0] data_AR,data_BR,
    input start,reset_b,clock
);
    wire Ld_AR_BR,Div_AR_2x_CR,Mul_BR_x2_CR,Clr_CR,AR_eq_0,AR_gt_0,AR_lt_0;
    Q8_System_Controller Controller_Unit 
    (Ld_AR_BR,Div_AR_2x_CR,Mul_BR_x2_CR,Clr_CR,done,start,AR_eq_0,AR_gt_0,AR_lt_0,reset_b,clock);
    Q8_System_Datapath Datapath_Unit
    (Result_Reg,AR_eq_0,AR_gt_0,AR_lt_0,data_AR,data_BR,Ld_AR_BR,Div_AR_2x_CR,Mul_BR_x2_CR,Clr_CR,reset_b,clock);
endmodule

module Q8_System_Controller (
    output reg Ld_AR_BR,Div_AR_2x_CR,Mul_BR_x2_CR,Clr_CR,done,
    input start,AR_eq_0,AR_gt_0,AR_lt_0,reset_b,clock
);
    parameter S_Idel = 1'b0,S_Loaded = 1'b1;
    reg state,next_state;
    always @(posedge clock or negedge reset_b) begin
        if(!reset_b) state <= S_Idel;
        else state <= next_state;
    end
    always @(state,AR_eq_0,AR_gt_0,AR_lt_0,start) begin
        Ld_AR_BR = 0;
        Div_AR_2x_CR = 0;
        Mul_BR_x2_CR = 0;
        Clr_CR = 0;
        done = 0;
        case (state)
            S_Idel: begin
                done = 1;
                if(start) begin Ld_AR_BR = 1;next_state = S_Loaded; end
                else next_state = S_Idel;
            end
            S_Loaded: begin
                if (AR_lt_0) Div_AR_2x_CR = 1;
                else if (AR_gt_0) Mul_BR_x2_CR = 1;
                else Clr_CR = 1;
                next_state = S_Idel;
            end
            default : next_state = S_Idel;
        endcase
    end
endmodule

module Q8_System_Datapath (
    output reg [15:0] CR,
    output reg AR_eq_0,AR_gt_0,AR_lt_0,
    input [15:0] data_AR,data_BR,
    input Ld_AR_BR,Div_AR_2x_CR,Mul_BR_x2_CR,Clr_CR,reset_b,clock
);
    reg [15:0] AR,BR;
    always @(posedge clock or negedge reset_b) begin
        if(!reset_b) begin
            AR <= 15'b0;
            BR <= 15'b0;
            CR <= 15'b0;
        end
        else if (Ld_AR_BR) begin
            AR <= data_AR;
            BR <= data_BR;
        end
        else if (Div_AR_2x_CR) CR <= {AR[15],AR[15:1]};
        else if (Mul_BR_x2_CR) CR <= BR << 1;
        else if (Clr_CR) CR <= 0;
    end
    always @(AR) begin
        AR_eq_0 = 0;
        AR_gt_0 = 0;
        AR_lt_0 = 0;
        if(AR[15]) AR_lt_0 = 1;
        else if (AR == 15'b0) AR_eq_0 = 1;
        else AR_gt_0 = 1;
    end
endmodule 

module Q8_System_TB;
    wire [15:0] Result_Reg;
    wire done;
    reg [15:0] data_AR,data_BR;
    reg start,reset_b,clock;
    Q8_System System (Result_Reg,done,data_AR,data_BR,start,reset_b,clock);
    initial begin
        clock = 0;
        forever begin
            #5 clock = ~clock;
        end
    end
    initial begin
        #110 $finish;
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
        #0 data_AR = 16'b0000_0000_1111_1111;
        #50 data_AR = 16'b0000_0000_0000_0000;
        #70 data_AR = 16'b1000_1111_1111_1111;
        #0 data_BR =16'b0000_1111_1111_1111;
    join
    initial begin
        $dumpfile("8.8.vcd");
        $dumpvars(0,Q8_System_TB);
    end
endmodule