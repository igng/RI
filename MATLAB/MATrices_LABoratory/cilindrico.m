function Q = cilindrico()

    table = [[q1, L1, 0, 0];
             [0, q2, -pi/2, 0];
             [0, q3, 0, 0]];

    Q = DH_full(table);

end