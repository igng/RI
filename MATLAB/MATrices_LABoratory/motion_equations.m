function m_eq = motion_equations(Lag, q, qp, qv, qvp, t)

    syms u1 u2 u3 u4 u5 u6
    u = [u1, u2, u3, u4, u5, u6];
    
    Lagv = subs(Lag, [q, qp], [qv, qvp]);
    dLdq = jacobian(Lagv, qv);
    dLdqp = jacobian(Lagv, qvp);
    
    dLdq = subs(dLdq, [qv, qvp], [q, qp]);
    dLdqp = subs(dLdqp, [qv, qvp], [q, qp]);
    
    m_eq = simplify((diff(dLdqp, t) - dLdq == u));
    
end