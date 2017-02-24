function Q = SCARA(q, L)

    table = [[q(1), L(1), 0, L(2)];     % that's a problem, multiple L on same row
             [q(2), L(3), pi, L(4)];
             [0, q(3), 0, 0]];

    Q = DH_full(table, L);

end