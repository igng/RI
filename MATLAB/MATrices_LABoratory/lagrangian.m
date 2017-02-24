function L = lagrangian(Q, q, M, I, t, i)

    d = Q(1:3, 4);
    R = Q(1:3, 1:3);
    qp = diff(q, t);
    dp = diff(d, t);
    Jt = subs(dp, qp, ones(1, 2));
    Bt = simplify(M(1:i)*(transpose(Jt)*Jt));
    Tt = (qp(1:i)*Bt*transpose(qp(1:i)))/2;
    Rp = diff(R, t);
    Sw = simplify(Rp*transpose(R));
    w = [Sw(3,2), Sw(1,3), Sw(2,1)];
    Jw = subs(w, qp, ones(1,2));
    Bw = simplify((Jw)*R*I(1:3, 3*(i-1) + 1:3*(i))*transpose(R)*transpose(Jw));
    Tw = (qp(1:i)*Bw*transpose(qp(1:i)))/2;
    Ttot = Tt + Tw;
    Utot = M(1:i)*[0, 0, 9.8]*d;
    L = Ttot - Utot;
    
end