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
    
    Lags = lagrangian(Qs, qp, qvp, M, I, t);
%     m_eqs = motion_equations(Lags, q, qp, qv, qvp, t);
%         
%     fprintf('\n');
%     for i = 1:6
%        fprintf('#%d:\t %s\n', i, m_eqs(i));
%     end

end