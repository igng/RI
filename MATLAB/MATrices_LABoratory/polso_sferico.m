function Qs = polso_sferico(q, L)

    table = [[q(1), 0, -pi/2, 0];
             [q(2), 0, pi/2, 0];
             [q(3), 0, 0, 0]];

    Qs = to_barycenters(table, L);

end