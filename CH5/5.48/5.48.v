module Q48(
    output reg y_out,
    input x_in,clk,rstn
);
    reg [1:0] state,next_state;
    parameter   [1:0] 
                a = 2'b00,
                b = 2'b01,
                c = 2'b10,
                d = 2'b11;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) state <= a;
        else state <= next_state;
    end
    always @(state,x_in) begin
        case (state)
            a: if(x_in) next_state = c;else next_state = b;  
            b: if(x_in) next_state = d;else next_state = c;  
            c: if(x_in) next_state = d;else next_state = b;  
            d: if(x_in) next_state = a;else next_state = c;  
        endcase
        if (state == a || state == d) y_out = ~x_in;
        else y_out = x_in;
    end
endmodule

module Q48_TB;
    wire y_out;
    reg x_in,clk,rstn;
    Q48 M0 (y_out,x_in,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial begin
        #110 $finish;
    end
    initial fork 
        #0 {rstn,x_in} = 2'b00;
        #10 x_in = 1;
        #20 {rstn,x_in} = 2'b10;
        #50 x_in = 1;
        #90 x_in = 0;
    join
    initial begin
        $dumpfile("5.48.vcd");
        $dumpvars(0,Q48_TB);
    end
endmodule