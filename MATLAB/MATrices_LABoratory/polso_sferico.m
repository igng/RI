function Q = polso_sferico(q, L)

    table = [[q(1), 0, -pi/2, 0];
             [q(2), 0, pi/2, 0];
             [q(3), 0, 0, 0]];

    Q = DH_full(table, L);

end