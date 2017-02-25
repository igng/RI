function [q, qp, qv, qvp] = initiate_vars()

    syms q1(t) q2(t) q3(t) q4(t) q5(t) q6(t);
    syms q1v q2v q3v q4v q5v q6v;
    syms q1vp q2vp q3vp q4vp q5vp q6vp;
    fprintf('==> Initializing variables...\n');
    q = [q1(t), q2(t), q3(t), q4(t), q5(t), q6(t)];
    qp = diff(q, t);
    qv = [q1v, q2v, q3v, q4v, q5v, q6v];
    qvp = [q1vp, q2vp, q3vp, q4vp, q5vp, q6vp];

end