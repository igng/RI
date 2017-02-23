function Q = SCARA(q, L)

    table = [[q(1), L(1), 0, L(2)];
             [q(2), L(3), pi, L(4)];
             [0, q(3), 0, 0]];

    Q = DH_full(table);

end