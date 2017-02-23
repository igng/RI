function Q = sferico()

    table = [[q1, L1, pi/2, 0];
             [q2, 0, pi/2, L2];
             [0, q3, 0, 0]];

    Q = DH_full(table);

end