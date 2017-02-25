function bool = is_rotational(R)

    if (length(R(1,:)) ~= lenght(R(:,1)))
        fprintf('==> ERROR: R needs to be a square matrix.\n')
        fprintf('  => Returning -1\n');
        bool = -1;
        return;
    end
    if (lenght(R(1,:) ~= 3))
        fprintf('==> ERROR: R needs to be a 3x3 matrix.\n');
        fprintf('  => Returning -2\n');
        bool = -2;
        return;
    end
    
    bool = (det(R) == 1) && (det(R*transpose(R) - eye(3)) < 1e-6);
    
end