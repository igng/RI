function q_curr = reverse(F, L1, L2, X, Y)
    F_plot = zeros(length(X), 2);
    for i = 1:length(X)
        c2 = (X(i).^2 + Y(i).^2 - L1.^2 - L2.^2)/(2*L1*L2);
        if (abs(c2) > 1)
           fprintf('!!! WARNING: point outside the working space. Aborting\n');
           return;
        end
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
%         fprintf('(q1: %f, q2: %f)\n\t(x: %f, y: %f)\t(X: %f, Y: %f)\n\n', ...
%                     q_curr(1), q_curr(2), F_plot(i, 1), F_plot(i, 2), X(i), Y(i));
    end
%     figure(30);
%     plot(X, Y, 'cyan');
%     grid on;
%     legend('Real');
    figure(31);
    plot(F_plot(:,1), F_plot(:,2), 'green', 'lineWidth', 2);
%     F_plot
    grid on;
    legend('Reverse');
    
end