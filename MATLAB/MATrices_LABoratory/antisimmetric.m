function S = antisimmetric(v)

    if (length(v) ~= 3)
        fprintf('==> ERROR: Vector needs to be tridimensional\n');
        fprintf('  => Returning zero matrix\n');
        S = zeros(3);
        return;
    else
        S = [[0, -v(3), v(2)];
             [v(3), 0, -v(1)];
             [-v(2), v(1), 0]];
    end    

end