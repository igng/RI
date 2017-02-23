function Q = odof(q, L)

    table = [q(1), 0, 0, L(1)];
    Q = DH_full(table);

end