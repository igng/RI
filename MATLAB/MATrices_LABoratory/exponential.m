function R = exponential(versor, angle)

    if (~isnumeric(versor))
       fprintf('==> ERROR: Input vector needs to be numerical, not symbolic\n');
       fprintf('  => Returning zeros matrix\n');
       R = zeros(3);
       return;
    end
    if (~isnumeric(angle))
        fprintf('==> ERROR: Input angle needs to be numerical, not symbolic\n');
        fprintf('  => Returning zero matrix');
        R = zeros(3);
        return;
    end
    n = norm(versor);
    if (n ~= 1)
%         fprintf('==> WARNING\tNorm: %f\n   => Normalizing...\n', n);
        versor = versor/n;
    end
    S = antisimmetric(versor);
    R = (expm(S*angle));

end