function Qs = odof(q, L)

    table = [q(1), 0, 0, L(1)];
    Qs = to_barycenters(table, L);

end