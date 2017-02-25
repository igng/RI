function Qs = tdof(q, L)

    table = [[q(1), 0, 0, L(1)];
             [q(2), 0, 0, L(2)]];
    Qs = to_barycenters(table, L);

end