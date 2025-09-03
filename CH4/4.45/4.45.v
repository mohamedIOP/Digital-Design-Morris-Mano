module Q45(
    input [3:0] D,
    output reg X,Y,V
);
    always @(D) begin
        if (D > 0) V = 1'b1; 
        else V = 1'b0;
        if (D[3]) begin
            X = 1'b1;Y = 1'b1;
        end
        else if (D[2]) begin
            X = 1'b1;Y = 1'b0;
        end
        else if (D[1]) begin
            X = 1'b0;Y = 1'b1;
        end
        else if (D[0]) begin
            X = 1'b0;Y = 1'b0;
        end
    end
endmodule