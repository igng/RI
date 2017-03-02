function [flag, i] = first_non_zero(S, m)
    flag = 0;
    i = 1;
    for j = 1:3
        if ((S(m, j) ~= 0))
            flag = 1;
            i = j;
        end
    end
end