function Lag = lagrangian(Qs, qp, qvp, M, I, t)

    len = length(Qs(1,1,:));        % number of links
    B = sym(zeros(len, len, len));
    Tt_sum = 0;
    Tw_sum = 0;
    U_sum = 0;
    
    for i = 1:len
        d = Qs(1:3, 4, i);
        dp = diff(d, t);
        dpv = subs(dp, qp, qvp);
        Jt = jacobian(dpv, qvp(1:i));
        Jt = subs(Jt, qvp, qp);
        Bt = simplify(M(i)*((Jt).'*Jt));
        Tt = (qp(1:i)*Bt*(qp(1:i)).')/2;
        R = Qs(1:3, 1:3, i);
        Rp = diff(R, t);
        Sw = simplify(Rp*(R).');
        w = [Sw(3,2), Sw(1,3), Sw(2,1)];
        wv = subs(w, qp, qvp);
        Jw = jacobian(wv, qvp(1:i));
        Jw = subs(Jw, qvp, qp);
        Bw = simplify((Jw).'*R*I(1:3, 3*(i-1) + 1:3*(i))*(R).'*(Jw));
        Tw = (qp(1:i)*Bw*(qp(1:i)).')/2;
        B(:, :, i) = Bt + Bw;
        Tt_sum = Tt_sum + Tt;
        Tw_sum = Tw_sum + Tw;
        U_sum = U_sum + M(i)*[0, 0, 9.8]*d;
    end
    
    T_all = Tt_sum + Tw_sum;
    U_all = U_sum;
    Lag = T_all - U_all;

end