module Q38 (output [3:0] Y,input [3:0] A, B, input S,E);
    wire [3:0] A_Selected,B_Selected;
    assign 
            A_Selected[0] = A[0] && (!S) && (!E),
            A_Selected[1] = A[1] && (!S) && (!E),
            A_Selected[2] = A[2] && (!S) && (!E),
            A_Selected[3] = A[3] && (!S) && (!E);
    assign 
            B_Selected[0] = B[0] && (S) && (!E),
            B_Selected[1] = B[1] && (S) && (!E),
            B_Selected[2] = B[2] && (S) && (!E),
            B_Selected[3] = B[3] && (S) && (!E);
    assign Y = A_Selected | B_Selected;
endmodule