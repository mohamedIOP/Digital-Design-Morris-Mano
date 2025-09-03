module Q35_Behavioral (
    output reg z,
    input x,y,clk,rstn
);
    reg [1:0] state;
    parameter S0 = 2'b00,S1 = 2'b01,S2 = 2'b10,S3 = 2'b11;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) state <= S0;
        else case (state)
            S0: 
            case ({x,y}) 
                S0,S1:state <= S0;
                S2:state <= S3;
                S3:state <= S1;
            endcase
            S1:
            case ({x,y}) 
                S0,S1:state <= S0;
                S2,S3:state <= S2;
            endcase
            S2:
            case ({x,y}) 
                S0,S1:state <= S0;
                S2,S3:state <= S3;
            endcase
            S3:
            case ({x,y}) 
                S0,S1:state <= S0;
                S2,S3:state <= S3;
            endcase
        endcase
    end
    always @(state) begin
        case (state)
            S0,S1: z <= 0;
            S2,S3: z <= 1;
        endcase
    end
endmodule

module Q35_Behavioral_TB;
    wire z;
    reg x,y,clk,rstn;
    Q35_Behavioral M0 (z,x,y,clk,rstn);
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
        #0 {x,y,rstn} = 3'bxx0;
        #10 {x,y,rstn} = 3'b001;
        #20 {x,y,rstn} = 3'b011;
        #30 {x,y,rstn} = 3'b101;
        #40 {x,y,rstn} = 3'b111;
        #50 {x,y,rstn} = 3'b001;
        #60 {x,y,rstn} = 3'b011;
        #70 {x,y,rstn} = 3'b111;
        #80 {x,y,rstn} = 3'b001;
        #90 {x,y,rstn} = 3'b101;
        #100 {x,y,rstn} = 3'b111;
        #110 {x,y,rstn} = 3'b011;
    join
    initial begin
        $dumpfile("5.35.vcd");
        $dumpvars(0,Q35_Behavioral_TB);
    end
endmodule