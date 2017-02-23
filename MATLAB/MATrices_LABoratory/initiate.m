function [t, q, L, M, I] = initiate()
 
    t = initiate_time();
    q = initiate_vars();
    L = initiate_length();
    M = initiate_mass();
    I = initiate_inertia();

end