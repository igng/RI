function Qs = sferico(q, L)

    table = [[q(1), L(1), pi/2, 0];
             [q(2), 0, pi/2, L(2)];
             [0, q(3), 0, 0]];

    Qs = to_barycenters(table, L);

end