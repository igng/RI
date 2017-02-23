function Q = SCARA()

    table = [[q1, L1, 0, L2];
             [q2, L3, pi, L4];
             [0, q3, 0, 0]];

    Q = DH_full(table);

end