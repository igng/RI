function [versor, angle] = reverse(R)
    if (~is_rotational(R))
        fprintf('==> ERROR: matrix is not a rotational matirx\n');
        fprintf('  => Returning zeros versor and zero angle\n');
        versor = zeros(1,3);
        angle = 0;
        return;
    end
    [versor, ~] = eigs(R, 1, 'si');
    I = eye(3);
    S = antisimmetric(versor);
    Ssquare = S^2;
    left_cosine = (R + R.' - 2*I)/2;
    for i = 1:3
        [flag, j] = first_non_zero(Ssquare, i);
        if (flag)
            break
        end
    end
    c = -left_cosine(i,j)/(Ssquare(i,j)) + 1;
    left_sine = (R - R.')/2;
    for i = 1:3
        [flag, j] = first_non_zero(S, i);
        if (flag)
            break
        end
    end
    s = left_sine(i,j)/(S(i,j));
    angle = atan2(s, c);    
end