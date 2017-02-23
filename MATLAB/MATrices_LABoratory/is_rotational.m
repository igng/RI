function bool = is_rotational(R)

    bool = (det(R) == 1) && (det(R*transpose(R) - eye(3)) < 1e-6);
    
end