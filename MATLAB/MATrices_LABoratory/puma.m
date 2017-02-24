function Q = puma(q, L)

    table = [[q(1), L(1), pi/2, 0];
             [q(2), 0, 0, L(2)];
             [q(3), 0, pi/2, 0]
             [q(4), L(4), pi/2, 0]
             [q(5), 0, -pi/2, 0]
             [q(6), L(6), 0, 0]];

    Q = DH_full(table, L);
%     fprintf('Forward position kinematic\n');
%     Q(1:3, 4)

end