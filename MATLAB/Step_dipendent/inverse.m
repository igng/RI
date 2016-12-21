function q_curr = inverse(T, F, L1, L2, X, Y)
    i = 1;
    F_plot = zeros(1/T, 2);
    for j = linspace(1, 2, 1/T)
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
        F_plot(i,:) = F(q_curr(1), q_curr(2));
        i = i+1;
    end
    figure(40);
    plot(F_plot(:,1), F_plot(:,2), 'g', 'lineWidth', 2);
    grid on;
    hold on;
    scatter(F_plot(1,1), F_plot(1,2), 'filled', 'black');
    legend('Inverse');
end