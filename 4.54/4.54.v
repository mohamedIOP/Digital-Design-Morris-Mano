module Q54A(
    input [3:0] BCD,
    output reg [3:0] NINE_COMPLEMENT
);
    always @(BCD) begin
        case (BCD)
            4'b0000: NINE_COMPLEMENT = 4'b1001;
            4'b0001: NINE_COMPLEMENT = 4'b1000;
            4'b0010: NINE_COMPLEMENT = 4'b0111;
            4'b0011: NINE_COMPLEMENT = 4'b0110;
            4'b0100: NINE_COMPLEMENT = 4'b0101;
            4'b0101: NINE_COMPLEMENT = 4'b0100;
            4'b0110: NINE_COMPLEMENT = 4'b0011;
            4'b0111: NINE_COMPLEMENT = 4'b0010;
            4'b1000: NINE_COMPLEMENT = 4'b0001;
            4'b1001: NINE_COMPLEMENT = 4'b0000;
        endcase
    end
endmodule
module Q54B(
    input [3:0] GRAY_CODE,
    output reg [3:0] NINE_COMPLEMENT
);
    always @(GRAY_CODE) begin
        case (GRAY_CODE)
            4'b0000: NINE_COMPLEMENT = 4'b1101;
            4'b0001: NINE_COMPLEMENT = 4'b1100;
            4'b0011: NINE_COMPLEMENT = 4'b0100;
            4'b0010: NINE_COMPLEMENT = 4'b0101;
            4'b0110: NINE_COMPLEMENT = 4'b0111;
            4'b0111: NINE_COMPLEMENT = 4'b0110;
            4'b0101: NINE_COMPLEMENT = 4'b0010;
            4'b0100: NINE_COMPLEMENT = 4'b0011;
            4'b1100: NINE_COMPLEMENT = 4'b0001;
            4'b1101: NINE_COMPLEMENT = 4'b0000;
        endcase
    end
endmodule