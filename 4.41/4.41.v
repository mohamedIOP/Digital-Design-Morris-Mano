module Q41 
(
    input [3:0] A,B,
    input M,
    output reg [3:0] S,
    output reg C
);
    always @(A,B,M) begin
        {C,S} = (M) ? (A - B) : (A + B);
    end
endmodule