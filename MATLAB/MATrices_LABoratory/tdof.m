function Q = tdof(q, L)

    table = [[q(1), 0, 0, L(1)];
             [q(2), 0, 0, L(2)]];
    Q = DH_full(table);

end