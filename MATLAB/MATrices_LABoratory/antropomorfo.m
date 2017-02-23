function Q = antropomorfo()

    table = [[q1, L1, pi/2, 0];
             [q2, 0, 0, L2];
             [q3, 0, 0, L3]];

    Q = DH_full(table);

end