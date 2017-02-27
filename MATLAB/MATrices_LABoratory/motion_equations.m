function m_eq = motion_equations(Lag, q, qp, qv, qvp, t)
    
    Lagv = subs(Lag, [q, qp], [qv, qvp]);
    dLdq = jacobian(Lagv, qv);
    dLdqp = jacobian(Lagv, qvp);
    
    dLdq = subs(dLdq, [qv, qvp], [q, qp]);
    dLdqp = subs(dLdqp, [qv, qvp], [q, qp]);
    
    m_eq = simplify((diff(dLdqp, t) - dLdq));
    
end