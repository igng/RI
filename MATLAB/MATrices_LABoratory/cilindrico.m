function Q = cilindrico(q, L)

    table = [[q(1), L(1), 0, 0];
             [0, q(2), -pi/2, 0];
             [0, q(3), 0, 0]];

    Q = DH_full(table, L);

end