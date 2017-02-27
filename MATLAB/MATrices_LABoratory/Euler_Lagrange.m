function m_eqs = Euler_Lagrange(n)
    
    fprintf('\n');
    [t, q, qp, qv, qvp, L, M, I] = initiate();
    
    switch (n)
        case 1
            fprintf('==> SELEZIONATO: ODOF\n\n');
            Qs = odof(q, L);
        case 2
            fprintf('==> SELEZIONATO: TDOF\n\n');
            Qs = tdof(q, L);
        case 3
            fprintf('==> SELEZIONATO: Cartesiano\n\n');
            Qs = cartesiano(q, L);
        case 4
            fprintf('==> SELEZIONATO: Cilindrico\n\n');
            Qs = cilindrico(q, L);
        case 5
            fprintf('==> SELEZIONATO: Sferico\n\n');
            Qs = sferico(q, L);
        case 6
            fprintf('==> SELEZIONATO: Stanford\n\n');
            Qs = stanford(q, L);
        case 7
            fprintf('==> SELEZIONATO: Antropomorfo\n\n');
            Qs = antropomorfo(q, L);
        case 8
            fprintf('==> SELEZIONATO: Polso sferico\n\n');
            Qs = polso_sferico(q, L);
        case 9
            fprintf('==> SELEZIONATO: puma\n\n');
            Qs = puma(q, L);
    end
    
    Lag = lagrangian(Qs, qp, qvp, M, I, t);
    m_eqs = motion_equations(Lag, q, qp, qv, qvp, t);
    syms a1 a2 a3 a4 a5 a6 v1 v2 v3 v4 v5 v6;
    syms c1 c2 c3 c4 c5 c6 s1 s2 s3 s4 s5 s6;
    syms q1 q2 q3 q4 q5 q6 u1 u2 u3 u4 u5 u6;
    a = [a1, a2, a3, a4, a5, a6];
    v = [v1, v2, v3, v4, v5, v6];
    c = [c1, c2, c3, c4, c5, c6];
    s = [s1, s2, s3, s4, s5, s6];
    qq = [q1, q2, q3, q4, q5, q6];
    u = [u1, u2, u3, u4, u5, u6];
    m_eqs = (subs(m_eqs, [cos(q), sin(q), q, qp, diff(qp, t)], [c, s, qq, v, a]));
        
    fprintf('\n');
    for i = 1:6
        fprintf('#%d:\t %s == %s\n', i, m_eqs(i), u(i));
%         pretty(m_eqs(i));
    end

end