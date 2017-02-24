function Q = antropomorfo(q, L)

    table = [[q(1), L(1), pi/2, 0];
             [q(2), 0, 0, L(2)];
             [q(3), 0, 0, L(3)]];

    Q = DH_full(table, L);

end