function q_curr = newton(tollerance, q_start, F, J, X, Y)
    T = 0.1;
    lambda = 1/(10*T);
    q_curr = q_start;
    q_prev = q_start;
    max_loc_iter = 100;
    max_glob_iter = min(max_loc_iter, length(X));
    F_plot = zeros(length(X), 2);
    for j = 1:max_glob_iter
        i = 1;
        convergence = 0;
        while (convergence == 0 && i < max_loc_iter)
            F_eval = F(q_prev(1), q_prev(2));
            J_inv = J(q_prev(1), q_prev(2))^-1;
            q_curr = q_prev + T*lambda*J_inv*(([X(j); Y(j)] - F_eval));
            error = norm([X(j); Y(j)] - F_eval, 2);
            q_prev = q_curr;
            if (error <= tollerance)
                convergence = 1;
            end
            i = i+1;
        end
        F_plot(j,:) = F(q_curr(1), q_curr(2));
    end
    figure(10);
    plot(X, Y, 'cyan');
    grid on;
    legend('Real');
    figure(11);
    plot(F_plot(:,1), F_plot(:,2), 'magenta', 'lineWidth', 2);
    F_plot
    grid on;
    legend('Newton');
end