function Av = screw(versor, angle, d)

    if (length(d) ~= 1)
        fprintf('==> WARNING: d needs to be a scalar number\n');
        fprintf('  => Assuming d = 1\n');
        d = 1;
    end
    if (norm(versor) ~= 1)
        fprintf('==> WARNING: versor must have norm = 1. Nomalizing');
        versor = versor/norm(versor);
    end
    Av = sym(eye(4));
    Av(1:3,1:3) = exponential(versor, angle);
    Av(1:3, 4) = d*versor;

end