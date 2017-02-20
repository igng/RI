function q_curr = gradient(re, disc, T, lambda, q_start, F, J, X, Y)
    q_curr = q_start;
    F_plot = zeros(disc, 2);
    i = 1;
    figure(20);
    for j = linspace(1, 2, disc)
        F_eval = F(q_curr(1), q_curr(2));
        J_eval = J(q_curr(1), q_curr(2));
        F_plot(i,:) = F_eval;
        J_gra = transpose(J_eval);
        q_curr = q_curr + T*lambda*J_gra*(([X(i); Y(i)] - F_eval));
        i = i+1;
    end
    scatter(F_plot(:,1), F_plot(:,2), 50, 'blue', 's');
    hold on;
%     scatter(X, Y, 50, 'red', '*');
    grid on;
    legend('Gradient');
    axis([-re re -re re]);
end