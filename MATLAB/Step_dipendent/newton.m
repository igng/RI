function q_curr = newton(T, lambda, q_start, F, J, X, Y)
    q_curr = q_start;
    F_plot = zeros(1/T, 2);
    i = 1;
    for j = linspace(1, 2, 1/T)
        F_eval = F(q_curr(1), q_curr(2));
        J_eval = J(q_curr(1), q_curr(2));
        F_plot(i,:) = F_eval;
        J_inv = J_eval^-1;
        q_curr = q_curr + T*lambda*J_inv*(([X(i); Y(i)] - F_eval));
        i = i+1;
    end
    figure(10);
    plot(F_plot(:,1), F_plot(:,2), 'm', 'lineWidth', 2);
    grid on;
    hold on;
    scatter(F_plot(1,1), F_plot(1,2), 'filled', 'black');
    legend('Newton');
end
% function q_curr = newton(T, lambda, q_start, F, J, x, y)
%     q_curr = q_start;
%     F_plot = zeros(1/T, 2);
%     i = 1;
%     for j = 1:T:2
%         F_eval = F(q_curr(1), q_curr(2));
%         F_plot(i,:) = F_eval;
%         J_inv = J(q_curr(1), q_curr(2))^-1;
%         q_curr = q_curr + T*lambda*J_inv*(([x; y] - F_eval));
%         i = i+1;
%     end
%     figure(10);
%     plot(F_plot(:,1), F_plot(:,2), 'm', 'lineWidth', 2);
%     grid on;
%     hold on;
%     scatter(F_plot(1,1), F_plot(1,2), 'filled', 'black');
%     legend('Newton');
% end