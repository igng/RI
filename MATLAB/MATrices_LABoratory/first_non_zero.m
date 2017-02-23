function [flag, index] = first_non_zero(S, L, i)
    flag = 0;
    for j = 1:3
        if (S(i, j) && L(i,j))
            flag = 1;
            index = j;
            break
        end
    end
end