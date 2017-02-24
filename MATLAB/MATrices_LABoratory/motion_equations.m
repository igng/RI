function eqs = motion_equations(L, q, t)

    qp = diff(q, t);
    dL = diff(L, q)
    
end