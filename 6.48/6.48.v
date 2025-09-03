module Q48_A(
    output reg [7:0] Counter,
    input clk,rstn
);
    reg [3:0] state_Counter;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin 
            Counter <= 8'b0000_0001;
            state_Counter <= 4'b0001;
        end
        else
            begin
                case (state_Counter)
                    4'b0001: begin Counter <= 8'b0000_0010;state_Counter <= state_Counter + 4'b0001; end
                    4'b0010: begin Counter <= 8'b0000_0001;state_Counter <= state_Counter + 4'b0001; end
                    4'b0011: begin Counter <= 8'b0000_0100;state_Counter <= state_Counter + 4'b0001; end
                    4'b0100: begin Counter <= 8'b0000_0001;state_Counter <= state_Counter + 4'b0001; end
                    4'b0101: begin Counter <= 8'b0000_1000;state_Counter <= state_Counter + 4'b0001; end
                    4'b0110: begin Counter <= 8'b0000_0001;state_Counter <= state_Counter + 4'b0001; end
                    4'b0111: begin Counter <= 8'b0001_0000;state_Counter <= state_Counter + 4'b0001; end
                    4'b1000: begin Counter <= 8'b0000_0001;state_Counter <= state_Counter + 4'b0001; end
                    4'b1001: begin Counter <= 8'b0010_0000;state_Counter <= state_Counter + 4'b0001; end
                    4'b1010: begin Counter <= 8'b0000_0001;state_Counter <= state_Counter + 4'b0001; end
                    4'b1011: begin Counter <= 8'b0100_0000;state_Counter <= state_Counter + 4'b0001; end
                    4'b1100: begin Counter <= 8'b0000_0001;state_Counter <= state_Counter + 4'b0001; end
                    4'b1101: begin Counter <= 8'b1000_0000;state_Counter <= state_Counter + 4'b0001; end
                    4'b1110: begin Counter <= 8'b0000_0001;state_Counter <= 4'b0001; end
                endcase
            end
    end
endmodule

module Q48_B (
    output reg [7:0] Counter,
    input clk,rstn
);
    reg [3:0] state_Counter;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) begin 
            Counter <= 8'b1000_0000;
            state_Counter <= 4'b0001;
        end
        else
            begin
                case (state_Counter)
                    4'b0001: begin Counter <= 8'b0100_0000;state_Counter <= state_Counter + 4'b0001; end
                    4'b0010: begin Counter <= 8'b1000_0000;state_Counter <= state_Counter + 4'b0001; end
                    4'b0011: begin Counter <= 8'b0010_0000;state_Counter <= state_Counter + 4'b0001; end
                    4'b0100: begin Counter <= 8'b1000_0000;state_Counter <= state_Counter + 4'b0001; end
                    4'b0101: begin Counter <= 8'b0001_0000;state_Counter <= state_Counter + 4'b0001; end
                    4'b0110: begin Counter <= 8'b1000_0000;state_Counter <= state_Counter + 4'b0001; end
                    4'b0111: begin Counter <= 8'b0000_1000;state_Counter <= state_Counter + 4'b0001; end
                    4'b1000: begin Counter <= 8'b1000_0000;state_Counter <= state_Counter + 4'b0001; end
                    4'b1001: begin Counter <= 8'b0000_0100;state_Counter <= state_Counter + 4'b0001; end
                    4'b1010: begin Counter <= 8'b1000_0000;state_Counter <= state_Counter + 4'b0001; end
                    4'b1011: begin Counter <= 8'b0000_0010;state_Counter <= state_Counter + 4'b0001; end
                    4'b1100: begin Counter <= 8'b1000_0000;state_Counter <= state_Counter + 4'b0001; end
                    4'b1101: begin Counter <= 8'b0000_0001;state_Counter <= state_Counter + 4'b0001; end
                    4'b1110: begin Counter <= 8'b1000_0000;state_Counter <= 4'b0001; end
                endcase
            end
    end
endmodule 
module Q48_TB;
    wire [7:0] Counter_A,Counter_B;
    reg clk,rstn;
    Q48_A M0 (Counter_A,clk,rstn);
    Q48_B M1 (Counter_B,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #230 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #10 rstn = 1;
        #180 rstn = 0;
        #190 rstn = 1;
    join
    initial begin
        $dumpfile("6.48.vcd");
        $dumpvars(0,Q48_TB);
    end
endmodule 