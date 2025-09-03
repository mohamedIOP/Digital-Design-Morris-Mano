module Q39(input [3:0] A,B, output reg [5:0] Y);
    always @(A,B) begin
        if (A > B) Y = 6'b011010;
        if (A < B) Y = 6'b010101;
        if (A == B) Y = 6'b100011;
    end
endmodule