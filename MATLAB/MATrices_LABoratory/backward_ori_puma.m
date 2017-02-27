function [R36, R36s] = backward_ori_puma(q, L)
    
    table = [[q(1), L(1), pi/2, 0];
             [q(2), 0, 0, L(2)];
             [q(3), 0, pi/2, 0]
             [q(4), L(4), pi/2, 0]
             [q(5), 0, -pi/2, 0]
             [q(6), L(6), 0, 0]];
         
    syms Rx1d Rx2d Rx3d Ry1d Ry2d Ry3d Rz1d Rz2d Rz3d
    syms c23 s23;
    [~, c, s, ~, ~] = symplify();
    R06 = [[Rx1d Rx2d Rx3d]; [Ry1d, Ry2d, Ry3d]; [Rz1d Rz2d Rz3d]];   % Desired orientation
    Q03 = DH_full(table(1:3, 1:end));
    Q36 = DH_full(table(4:end, 1:end));
    R03 = subs(Q03(1:3, 1:3), [cos(q), sin(q), cos(q(2) + q(3)), sin(q(2) + q(3))], [c, s, c23, s23]);
    R36 = subs(Q36(1:3, 1:3), [cos(q), sin(q)], [c, s]);
    R36s = R03.'*R06;

end