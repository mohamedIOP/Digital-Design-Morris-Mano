`timescale 1ps/1ps
module Q29_Fig_P5_19_Behavioral(
    output reg y_out,
    input x_in,clk,rstn
);
    reg [2:0] state;
    parameter   S0 = 3'b000,S1 = 3'b001,
                S2 = 3'b010,S3 = 3'b011,
                S4 = 3'b100;
    always @(posedge clk,negedge rstn) begin
        if(!rstn) state <= S0;
        else begin
            case (state)
                S0: if(x_in) begin 
                        state <= S4;
                    end 
                    else begin
                        state <= S3;
                    end
                S1: if(x_in) begin 
                        state <= S4;
                    end 
                    else begin
                        state <= S1;
                    end
                S2: if(x_in) begin 
                        state <= S0;
                    end 
                    else begin
                        state <= S2;
                    end
                S3: if(x_in) begin 
                        state <= S2;
                    end 
                    else begin
                        state <= S1;
                    end
                S4: if(x_in) begin 
                        state <= S3;
                    end 
                    else begin
                        state <= S2;
                    end
            endcase
        end 
    end
    always @(state,x_in) begin
        case (state)
            S0,S1,S2,S3: y_out = x_in;
            S4: y_out = 0;
        endcase
    end
endmodule

module Q29_TB;
    wire y_out;
    reg x_in,clk,rstn;
    Q29_Fig_P5_19_Behavioral M0 (y_out,x_in,clk,rstn);
    initial begin
        #120 $finish;
    end
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial fork 
        #0 {x_in,rstn} = 2'bx0;
        #10 {x_in,rstn} = 2'b01;
        #20 {x_in,rstn} = 2'b01;
        #30 {x_in,rstn} = 2'b01;
        #40 {x_in,rstn} = 2'b01;
        #50 {x_in,rstn} = 2'b11;
        #60 {x_in,rstn} = 2'b01;
        #70 {x_in,rstn} = 2'b11;
        #80 {x_in,rstn} = 2'b01;
        #90 {x_in,rstn} = 2'b01;
        #100 {x_in,rstn} = 2'b11;
        #110 {x_in,rstn} = 2'b01;
    join
    initial begin
        $dumpfile("5.29.vcd");
        $dumpvars(0,Q29_TB);
    end
endmodule