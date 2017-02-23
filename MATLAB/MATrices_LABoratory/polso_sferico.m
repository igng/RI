function Q = polso_sferico()

    table = [[q1, 0, -pi/2, 0];
             [q2, 0, pi/2, 0];
             [q3, 0, 0, 0]];

    Q = DH_full(table);

end