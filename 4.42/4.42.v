`timescale 1ps/1ps

module Q42A 
(
    output W,X,Y,Z,
    input A,B,C,D
);
    wire w1,w2,w3,Not_D,Not_B,C_and_D,C_or_D,Not_C_or_D;
    not (Not_D,D),(Not_B,B);
    and (C_and_D,C,D);
    or (C_or_D,C,D);
    not (Not_C_or_D,C_or_D);
    and (w1,Not_C_or_D,B),(w2,C_or_D,Not_B),(w3,C_or_D,B);
    buf (Z,Not_D);
    or (Y,C_and_D,Not_C_or_D);
    or (X,w1,w2),(W,w3,A);
endmodule

module Q42B
(
    output W,X,Y,Z,
    input A,B,C,D
);
    assign 
            Z = !(D),
            Y = !(C ^ D),
            X = ((!B) && (C)) || ((!B) && D) || (B && (!C) && (!D)),
            W = A || (B && C) || (B && D);
endmodule

module Q42C
(
    output reg W,X,Y,Z,
    input A,B,C,D
);
    always @(A,B,C,D) begin
        W = A || (B && C) || (B && D);
        X = ((!B) && (C)) || ((!B) && D) || (B && (!C) && (!D));
        Y = !(C ^ D);
        Z = !(D);
    end
endmodule

module Q42ATB;
    reg A,B,C,D;
    wire W,X,Y,Z;
    Q42A M (W,X,Y,Z,A,B,C,D);
    initial begin

    $dumpfile("4.42A.vcd");  // Specify dump file name

    $dumpvars(0, Q42ATB);  // Dump all signals in the testbench

    end

    initial #500 $finish;
    
    initial begin
        A = 0;B = 0;C = 0;D = 0; 
        repeat(9) #50 {A,B,C,D} = {A,B,C,D} + 4'b0001;
    end


    initial begin
        $display ("time = %0d , ABCD -> WXYZ",$time);
        $monitor ("time = %0d , %d%d%d%d -> %d%d%d%d",$time,A,B,C,D,W,X,Y,Z);
    end
endmodule

module Q42BTB;
    reg A,B,C,D;
    wire W,X,Y,Z;
    Q42B M (W,X,Y,Z,A,B,C,D);

    initial begin

    $dumpfile("4.42B.vcd");  // Specify dump file name

    $dumpvars(0, Q42BTB);  // Dump all signals in the testbench

    end
    
    initial #500 $finish;

    initial begin
        {A,B,C,D} = 4'b0000;
        repeat(9) #50 {A,B,C,D} = {A,B,C,D} + 4'b0001;
    end

    initial begin
        $display ("time = %0d , ABCD -> WXYZ",$time);
        $monitor ("time = %0d , %d%d%d%d -> %d%d%d%d",$time,A,B,C,D,W,X,Y,Z);
    end
endmodule


module Q42CTB;
    reg A,B,C,D;
    wire W,X,Y,Z;
    
    Q42C M (W,X,Y,Z,A,B,C,D);

    initial #500 $finish;
    
    initial begin

    $dumpfile("4.42C.vcd");  // Specify dump file name

    $dumpvars(0, Q42CTB);  // Dump all signals in the testbench

    end

    initial begin
        {A,B,C,D} = 4'b0000;
        repeat(9) #50 {A,B,C,D} = {A,B,C,D} + 4'b0001;
    end
    
    initial begin
        $display ("time = %0d , ABCD -> WXYZ",$time);
        $monitor ("time = %0d , %d%d%d%d -> %d%d%d%d",$time,A,B,C,D,W,X,Y,Z);
    end
endmodule