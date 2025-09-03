module Q59_BCD_To_Decimal_Decoder(
    input [3:0] BCD_Input,
    output [9:0] Decimal
);
    assign Decimal = 
                    {
                        BCD_Input[3] && BCD_Input[0],
                        BCD_Input[3] && !BCD_Input[0],
                        BCD_Input[2] && BCD_Input[1] && BCD_Input[0],
                        BCD_Input[2] && BCD_Input[1] && !BCD_Input[0],
                        BCD_Input[2] && !BCD_Input[1] && BCD_Input[0],
                        BCD_Input[2] && !BCD_Input[1] && !BCD_Input[0],
                        !BCD_Input[2] && BCD_Input[1] && BCD_Input[0],
                        !BCD_Input[2] && BCD_Input[1] && !BCD_Input[0],
                        !BCD_Input[3] && !BCD_Input[2] && !BCD_Input[1] && BCD_Input[0],
                        !BCD_Input[3] && !BCD_Input[2] && !BCD_Input[1] && !BCD_Input[0]
                    };
endmodule