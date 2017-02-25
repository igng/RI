function Qs = cartesiano(q, L)

    table = [[0, q(1), -pi/2, 0];
             [-pi/2, q(2), -pi/2, 0];
             [0, q(3), 0, 0]];

    Qs = to_barycenters(table, L);

end