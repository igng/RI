function [t, q, qp, qv, qvp, L, M, I] = initiate()

    syms t
    
    [q, qp, qv, qvp] = initiate_vars();
    L = initiate_length();
    M = initiate_mass();
    I = initiate_inertia();
    
    fprintf('\n------------------------------------');
    fprintf('\n----- Initialization completed -----\n');
    fprintf('------------------------------------\n\n');
    
end