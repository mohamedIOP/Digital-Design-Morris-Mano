primitive Q37 (F,A,B,C,D);
    output F;
    input A,B,C,D;
    table
        //  A B C D : F
            0 0 0 0 : 0;
            0 0 0 1 : 0;
            0 0 1 0 : 0;
            0 0 1 1 : 0;
            0 1 0 0 : 0;
            0 1 0 1 : 0;
            0 1 1 0 : 0;
            0 1 1 1 : 1;
            1 0 0 0 : 0;
            1 0 0 1 : 0;
            1 0 1 0 : 0;
            1 0 1 1 : 1;
            1 1 0 0 : 0;
            1 1 0 1 : 1;
            1 1 1 0 : 1;
            1 1 1 1 : 1;
    endtable
endprimitive