function Q = cartesiano()

    table = [[0, q1, -pi/2, 0];
             [-pi/2, q2, -pi/2, 0];
             [0, q3, 0, 0]];

    Q = DH_full(table);

end