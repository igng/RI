function Av = screw(versor, angle, d)

    if (length(d) ~= 1)
        fprintf('==> ERROR: d needs to be a scalar number\n');
        fprintf('  => Assuming d = 1\n');
        d = 1;
    end
    Av = sym(eye(4));
    Av(1:3,1:3) = exponential(versor, angle);
    Av(1:3, 4) = d*versor;

end