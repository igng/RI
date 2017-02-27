function Q = sferico_con_polso(q, L)

    table = [[q(1), L(1), pi/2, 0];
             [q(2), 0, pi/2, L(2)];
             [0, q(3), 0, 0]
             [q(4), L(4), pi/2, 0]
             [q(5), 0, -pi/2, 0]
             [q(6), L(6), 0, 0]];
         
    Q = simplify(DH_full(table));

end