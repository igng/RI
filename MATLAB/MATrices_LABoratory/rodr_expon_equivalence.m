function bool = rodr_expon_equivalence(vector, angle)

    R = rodrigues(vector, angle);
    E = exponential(vector, angle);
    
    bool = simplify((det(R - E) <= 1e-9));

end