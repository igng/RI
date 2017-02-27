function bool = is_rotational(R)

    [rows, cols] = size(R);
    if (rows ~= cols)
        fprintf('==> ERROR: matrix needs to be a square matrix.\n')
        fprintf('  => Returning -1\n');
        bool = -1;
        return;
    end
    if (rows ~= 3)
        fprintf('==> ERROR: matrix needs to be a 3x3 matrix.\n');
        fprintf('  => Returning -2\n');
        bool = -2;
        return;
    end
    
    bool = ((det(R) - 1) < 1e-10) && (det(R*R.' - eye(3)) < 1e-10);
    
end