function q_curr = backward(disc, F, L1, L2, X, Y)
    i = 1;
    F_plot = zeros(disc, 2);
    figure(40);
    for j = linspace(1, 2, disc)
        c2 = (X(i).^2 + Y(i).^2 - L1.^2 - L2.^2)/(2*L1*L2);
        s2 = sqrt(abs(1 - c2.^2));
        q_curr(2) = atan2(s2, c2);
        R = [c2 -s2; s2 c2];
        temp = [L1; 0] + R*[L2; 0];
        alpha = temp(1);
        beta = temp(2);
        temp = ([alpha beta; -beta alpha]*[X(i); Y(i)])/(alpha.^2 + beta.^2);
        c1 = temp(1);
        s1 = temp(2);
        q_curr(1) = atan2(s1, c1);
        F_eval = F(q_curr(1), q_curr(2));
        F_plot(i,:) = F_eval;
        i = i+1;
    end
    scatter(F_plot(:,1), F_plot(:,2), 50, 'green', 's');
    hold on;
    scatter(X, Y, 50, 'red', '*');
    grid on;
    legend('Backward');
    axis([-30 30 -30 30]);
end