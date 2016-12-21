function q_curr = gradient(T, lambda, q_start, F, J, X, Y)
    q_curr = q_start;
    F_plot = zeros(1/T, 2);
    i = 1;
    for j = linspace(1, 2, 1/T)
        F_eval = F(q_curr(1), q_curr(2));
        J_eval = J(q_curr(1), q_curr(2));
        F_plot(i,:) = F_eval;
        J_gra = transpose(J_eval);
        q_curr = q_curr + T*lambda*J_gra*(([X(i); Y(i)] - F_eval));
        figure(20);
        scatter(X(i), Y(i), 'filled', 'red');
        hold on;
        scatter(F_plot(i,1), F_plot(i,2), 'filled', 'blue');
        i = i+1;
    end
    figure(20);
    axis tight equal;
%     plot(F_plot(:,1), F_plot(:,2), 'b', 'lineWidth', 2);
    grid on;
    hold on;
    %     scatter(F_plot(1,1), F_plot(1,2), 'filled', 'black');
    legend('Gradient');
end
% function q_curr = gradient(T, lambda, q_start, F, J, x, y)
%     q_curr = q_start;
%     F_plot = zeros(1/T, 2);
%     i = 1;
%     for j = 1:T:2
%         F_eval = F(q_curr(1), q_curr(2));
%         F_plot(i,:) = F_eval;
%         J_gra = transpose(J(q_curr(1), q_curr(2)));
%         q_curr = q_curr + T*lambda*J_gra*(([x; y] - F_eval));
%         i = i+1;
%     end
%     figure(20);
%     plot(F_plot(:,1), F_plot(:,2), 'b', 'lineWidth', 2);
%     grid on;
%     hold on;
%     scatter(F_plot(1,1), F_plot(1,2), 'filled', 'black');
%     legend('Gradient');
% end