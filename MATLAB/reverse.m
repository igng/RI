function q_curr = reverse(F, L1, L2, X, Y)
    F_plot = zeros(length(X), 2);
    for i = 1:length(X)
        c2 = (X(i).^2 + Y(i).^2 - L1.^2 - L2.^2)/(2*L1*L2);
        s2 = sqrt(1 - c2.^2);
        q_curr(2) = atan2(s2, c2);
        c2 = cos(q_curr(2));
        s2 = sin(q_curr(2));
        R = [c2 s2; -s2 c2];
        temp = R*[L2; 0] + [L1; 0];
        alpha = temp(1);
        beta = temp(2);
        temp = 1/(alpha.^2 + beta.^2) * [alpha beta; -beta alpha]*[X(i); Y(i)];
        c1 = temp(1);
        s1 = temp(2);
        q_curr(1) = atan2(s1, c1);
        F_plot(i,:) = F(q_curr(1), q_curr(2));
        fprintf('(q1: %f, q2: %f) => (x: %f, y: %f)\n', ...
                    q_curr(1), q_curr(2), F_plot(i, 1), F_plot(i, 2));
    end
    figure(14);
    plot(F_plot(:,1), F_plot(:,2), 'green', 'lineWidth', 2);
    grid on;
    legend('Reverse');
    
end