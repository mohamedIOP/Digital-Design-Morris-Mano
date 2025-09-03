module Q58_Four_Bit_Binary_Counter_With_Parallel_Load_Structural (
    output [3:0] A,
    output C_out,
    input [3:0] I,
    input Load,Count,clk,rstn
);
    wire Count_and_Not_Load,Not_Load;
    wire [3:0]  Not_I,
                J,K,
                Anding_J,Anding_K;
    wire [3:1] Anding_Count_wire_JK_Input;
    not (Not_Load,Load),
        (Not_I[0],I[0]),
        (Not_I[1],I[1]),
        (Not_I[2],I[2]),
        (Not_I[3],I[3]);
    and (Count_and_Not_Load,Count,Not_Load),
        (Anding_J[0],I[0],Load),
        (Anding_J[1],I[1],Load),
        (Anding_J[2],I[2],Load),
        (Anding_J[3],I[3],Load),
        (Anding_K[0],Not_I[0],Load),
        (Anding_K[1],Not_I[1],Load),
        (Anding_K[2],Not_I[2],Load),
        (Anding_K[3],Not_I[3],Load),
        (Anding_Count_wire_JK_Input[1],Count_and_Not_Load,A[0]),
        (Anding_Count_wire_JK_Input[2],Count_and_Not_Load,A[1],A[0]),
        (Anding_Count_wire_JK_Input[3],Count_and_Not_Load,A[2],A[1],A[0]),
        (C_out,Count,A[0],A[1],A[2],A[3]);
    or  (J[0],Anding_J[0],Count_and_Not_Load),
        (J[1],Anding_J[1],Anding_Count_wire_JK_Input[1]),
        (J[2],Anding_J[2],Anding_Count_wire_JK_Input[2]),
        (J[3],Anding_J[3],Anding_Count_wire_JK_Input[3]),
        (K[0],Anding_K[0],Count_and_Not_Load),
        (K[1],Anding_K[1],Anding_Count_wire_JK_Input[1]),
        (K[2],Anding_K[2],Anding_Count_wire_JK_Input[2]),
        (K[3],Anding_K[3],Anding_Count_wire_JK_Input[3]);
    Q58_Four_Bit_Binary_Counter_With_Parallel_Load_JKFF Stage_Zero (A[0],J[0],K[0],clk,rstn);
    Q58_Four_Bit_Binary_Counter_With_Parallel_Load_JKFF Stage_One (A[1],J[1],K[1],clk,rstn);
    Q58_Four_Bit_Binary_Counter_With_Parallel_Load_JKFF Stage_Two (A[2],J[2],K[2],clk,rstn);
    Q58_Four_Bit_Binary_Counter_With_Parallel_Load_JKFF Stage_Three (A[3],J[3],K[3],clk,rstn);
endmodule

module Q58_Four_Bit_Binary_Counter_With_Parallel_Load_JKFF(
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
                default: Q <= 0;
            endcase
    end
endmodule

module Q58_Four_Bit_Binary_Counter_With_Parallel_Load_Behavioral(
    output reg [3:0] A,
    output C_out,
    input [3:0] I,
    input Load,Count,clk,rstn
);
    assign C_out = A[3] && A[2] && A[1] && A[0] && Count;
    always @(posedge clk or negedge rstn) begin
        if(!rstn) A <= 4'b0;
        else if (Load) A <= I;
        else if (Count) A <= A + 4'b0001;
        else A <= A;
    end
endmodule

module Q58_Four_Bit_Binary_Counter_With_Parallel_Load_TB;
    wire [3:0] A_Structural,A_Behavioral;
    wire C_out_Structural,C_out_Behavioral;
    reg [3:0] I;
    reg Load,Count,clk,rstn;
    Q58_Four_Bit_Binary_Counter_With_Parallel_Load_Behavioral Behavioral_Model (A_Behavioral,C_out_Behavioral,I,Load,Count,clk,rstn);
    Q58_Four_Bit_Binary_Counter_With_Parallel_Load_Structural Structural_Model (A_Structural,C_out_Structural,I,Load,Count,clk,rstn);
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk; 
        end
    end
    initial begin
        #280 $finish;
    end
    initial fork 
        #0 rstn = 0;
        #10 rstn = 1;
        #210 rstn = 0;
        #220 rstn = 1;
        #0 {Load,Count} = 2'b11;
        #20 {Load,Count} = 2'b10;
        #30 {Load,Count} = 2'b00;
        #40 {Load,Count} = 2'b01;
        #0 I = 4'b1010;
        #20 I = 4'b0011;
    join
    initial begin
        $dumpfile("6.58.vcd");
        $dumpvars(0,Q58_Four_Bit_Binary_Counter_With_Parallel_Load_TB);
    end
endmodule 