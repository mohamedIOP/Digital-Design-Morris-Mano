module Q37_FIG_5_25(
    output reg y_out,
    input x,clk,rstn
);
    reg [2:0] state;
    parameter 
                [2:0] a = 3'b000,b = 3'b001,c = 3'b010,
                d = 3'b011,e = 3'b100,f = 3'b101,g = 3'b110;
    // Change State
    always @(posedge clk or negedge rstn) begin
        if(!rstn) state <= a;
        else
            case (state)
                a: 
                if(x) state <= b;
                else state <= a;
                b: 
                if(x) state <= d;
                else state <= c;
                c: 
                if(x) state <= d;
                else state <= a;
                d: 
                if(x) state <= f;
                else state <= e;
                e: 
                if(x) state <= f;
                else state <= a;
                f: 
                if(x) state <= f;
                else state <= g;
                g: 
                if(x) state <= f;
                else state <= a;
            endcase
    end
    // Output
    always @(state,x) begin
        case (state)
            a,b,c:y_out = 0;
            d,e,f,g: 
            if(x) y_out = 1;
            else y_out = 0;
        endcase
    end
endmodule

module Q37_FIG_5_26(
    output reg y_out,
    input x,clk,rstn
);
    reg [2:0] state,next_state;
    parameter 
                [2:0] a = 3'b000,b = 3'b001,c = 3'b010,
                d = 3'b011,e = 3'b100;
    // Next State Producer
    always @(x,state) begin
        case (state)
            a: if(x) next_state <= b;
                else next_state <= a;
            b: if(x) next_state <= d;
                else next_state <= c;
            c: if(x) next_state <= d;
                else next_state <= a;
            d: if(x) next_state <= d;
                else next_state <= e;
            e: if(x) next_state <= d;
                else next_state <= a;
        endcase
    end
    // Change Current State 
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            state <= a;
        end
        else begin 
            state <= next_state;
        end
    end
    // Output
    always @(state,x) begin
        case (state)
            a,b: y_out = 0;
            c,d,e: 
                if(x) y_out = 1;
                else y_out = 0;
        endcase
    end
endmodule
`timescale 1ps/1ps
module Q37_TB;
    wire y_out_Fig_25,y_out_Fig_26;
    reg x,clk,rstn;
    Q37_FIG_5_25 M0 (y_out_Fig_25,x,clk,rstn);
    Q37_FIG_5_26 M1 (y_out_Fig_26,x,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    initial fork 
        #0 {rstn,x} = 2'b0x;
        #10 {rstn,x} = 2'b10;
        #20 {rstn,x} = 2'b11;
        #30 {rstn,x} = 2'b11;
        #40 {rstn,x} = 2'b11;
        #50 {rstn,x} = 2'b10;
        #60 {rstn,x} = 2'b11;
        #70 {rstn,x} = 2'b10;
        #80 {rstn,x} = 2'b11;
    join
    initial begin
        #100 $finish;
    end
    initial begin
        $dumpfile("5.37.vcd");
        $dumpvars(0,Q37_TB);
    end
endmodule