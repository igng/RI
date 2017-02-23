function S = antisimmetric(v)

    if (length(v) ~= 3)
        fprintf('ERROR: Vector needs to be tridimensional');
        S = eye(3);
    else
        S = [[0, -v(3), v(2)];
             [v(3), 0, -v(1)];
             [-v(2), v(1), 0]];
    end    

end