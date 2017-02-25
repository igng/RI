function Qs = antropomorfo(q, L)

    table = [[q(1), L(1), pi/2, 0];
             [q(2), 0, 0, L(2)];
             [q(3), 0, 0, L(3)]];

    Qs = to_barycenters(table, L);
end