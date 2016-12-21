clearvars;
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
% Algorithm selection
% --------------------------
%       newton          = 1
%       gradient        = 2
%       hybrid          = 3
%       inverse         = 4

algorithms = [1, 2, 4];
draw = 1;       % draw the path
T = 0.01;       % sampling time
lambda = 10;     % convergence speed
fprintf('T: %f => lambda < %f\t(current: %f)\n\n', T, 1/(10*T), lambda);
disc = 20;      % value to discretize the path
L1 = 10;
L2 = 2*L1;
re = L2+L1; 
ri = L2-L1;

% Direct kinematic
%  ------------------------------
% x = L1*cos(q1) + L2*cos(q1+q2);
% x = L1*sin(q1) + L2*sin(q1+q2);

%%
p1 = [zeros(1, disc); linspace(ri, re, disc)];                                  % PI/2
p2 = [re*cos(linspace(pi/2, 0, disc)); re*sin(linspace(pi/2, 0, disc))];        % ext1
p3 = [linspace(re, ri, disc); zeros(1, disc)];                                  % 0
p4 = [ri*cos(linspace(0, -pi/2, disc)); ri*sin(linspace(0, -pi/2, disc))];      % int1
p5 = [zeros(1, disc); linspace(-ri, -re, disc)];                                % -PI/2
p6 = [re*cos(linspace(-pi/2, -pi, disc)); re*sin(linspace(-pi/2, -pi, disc))];  % ext2
p7 = [linspace(-ri, -re, disc); zeros(1, disc)];                                % PI
p8 = [ri*cos(linspace(pi, pi/2, disc)); ri*sin(linspace(pi, pi/2, disc))];      % int2

if (draw)
    close(figure(1));
    figure(1);
    plot(p1(1,:), p1(2,:), 'lineWidth', 2);       
    hold on;
    plot(p2(1,:), p2(2,:), 'lineWidth', 2);    
    plot(p3(1,:), p3(2,:), 'lineWidth', 2);    
    plot(p4(1,:), p4(2,:), 'lineWidth', 2);    
    plot(p5(1,:), p5(2,:), 'lineWidth', 2);    
    plot(p6(1,:), p6(2,:), 'lineWidth', 2);    
    plot(p7(1,:), p7(2,:), 'lineWidth', 2);    
    plot(p8(1,:), p8(2,:), 'black', 'lineWidth', 2);    
    legend('1', '2', '3', '4', '5', '6', '7', '8', 'Location', 'NorthWest');
    grid on;
    axis([-30 30 -30 30]);
    hold off;
end
%%
syms q1 q2
F = ([L1*cos(q1) + L2*cos(q1+q2); L1*sin(q1) + L2*sin(q1+q2)]);
J = matlabFunction(jacobian(F, [q1 q2]));
% J = matlabFunction([-L1*sin(q1) - L2*sin(q1 + q2), -L2*sin(q1 + q2); L1*cos(q1) + L2*cos(q1 + q2), L2*cos(q1 + q2)]);
F = matlabFunction(F);

a = 1;

for algorithm = algorithms
    q_curr = [-a*pi/2; a*pi];
    switch (algorithm)
        case 0,
            fprintf('!!! WARNING: algorithm not selected\n\n');
        % Newton
        case 1,
            q_curr = newton(disc, T, lambda, q_curr, F, J, p1(1,:), p1(2,:));
            q_curr = newton(disc, T, lambda, q_curr, F, J, p2(1,:), p2(2,:));
            q_curr = newton(disc, T, lambda, q_curr, F, J, p3(1,:), p3(2,:));
            q_curr = newton(disc, T, lambda, q_curr, F, J, p4(1,:), p4(2,:));
            q_curr = newton(disc, T, lambda, q_curr, F, J, p5(1,:), p5(2,:));
            q_curr = newton(disc, T, lambda, q_curr, F, J, p6(1,:), p6(2,:));
            q_curr = newton(disc, T, lambda, q_curr, F, J, p7(1,:), p7(2,:));
            newton(disc, T, lambda, q_curr, F, J, p8(1,:), p8(2,:));
        % Gradient
        case 2,
            q_curr = gradient(disc, T, lambda, q_curr, F, J, p1(1,:), p1(2,:));
            q_curr = gradient(disc, T, lambda, q_curr, F, J, p2(1,:), p2(2,:));
            q_curr = gradient(disc, T, lambda, q_curr, F, J, p3(1,:), p3(2,:));
            q_curr = gradient(disc, T, lambda, q_curr, F, J, p4(1,:), p4(2,:));
            q_curr = gradient(disc, T, lambda, q_curr, F, J, p5(1,:), p5(2,:));
            q_curr = gradient(disc, T, lambda, q_curr, F, J, p6(1,:), p6(2,:));
            q_curr = gradient(disc, T, lambda, q_curr, F, J, p7(1,:), p7(2,:));
            gradient(disc, T, lambda, q_curr, F, J, p8(1,:), p8(2,:));
        % Hybrid
        case 3,
        % inverse
        case 4,
            inverse(disc, F, L1, L2, p1(1,:), p1(2,:));
            inverse(disc, F, L1, L2, p2(1,:), p2(2,:));
            inverse(disc, F, L1, L2, p3(1,:), p3(2,:));
            inverse(disc, F, L1, L2, p4(1,:), p4(2,:));
            inverse(disc, F, L1, L2, p5(1,:), p5(2,:));
            inverse(disc, F, L1, L2, p6(1,:), p6(2,:));
            inverse(disc, F, L1, L2, p7(1,:), p7(2,:));
            inverse(disc, F, L1, L2, p8(1,:), p8(2,:));
    end
end