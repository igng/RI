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
%       reverse         = 4
algorithm = 1;
draw = 1;       % draw the path
T = 0.1;
res = 1/T;      % resolution
max_iter = 100;
tollerance = 1e-3;
error = zeros(1, max_iter*8);   % 8 paths
q = zeros(2, max_iter*8);       
L1 = 1*res;
L2 = 2*L1;
re = L2+L1;
ri = L2-L1;

% Direct kinematic
%  ------------------------------
% x = L1*cos(q1) + L2*cos(q1+q2);
% x = L1*sin(q1) + L2*sin(q1+q2);

gc = 0;  % global counter
lc = 0;  % local counter
%%
p1 = [zeros(1, L2+1); (ri : re)];                           % PI/2
p2 = [re*cos(pi/2:-pi/180:0); re*sin(pi/2:-pi/180:0)];      % ext1             % ext1
p3 = [(ri : re); zeros(1, L2+1)];                           % 0
p4 = [ri*cos(0:-pi/180:-pi/2); ri*sin(0:-pi/180:-pi/2)];    % int1
p5 = [zeros(1, L2+1); -(ri : re)];                          % -PI/2
p6 = [re*cos(-pi/2:-pi/180:-pi); re*sin(-pi/2:-pi/180:-pi)];% ext2
p7 = [-(ri : re); -zeros(1, L2+1)];                         % PI
p8 = [ri*cos(pi:-pi/180:pi/2); ri*sin(pi:-pi/180:pi/2)];    % int2
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
    hold off;
end
%%
clc;
q_curr = [pi/2; 0];

syms q1 q2
F = ([L1*cos(q1) + L2*cos(q1+q2); L1*sin(q1) + L2*sin(q1+q2)]);
J = matlabFunction(jacobian(F, [q1 q2]));
F = matlabFunction(F);

switch (algorithm)
    case 0,
        fprintf('!!! WARNING: algorithm not selected\n\n');
    % Newton
    case 1,
        q_curr = newton(tollerance, q_curr, F, J, p1(1,:), p1(2,:));
        q_curr = newton(tollerance, q_curr, F, J, p2(1,:), p2(2,:));
        q_curr = newton(tollerance, q_curr, F, J, p3(1,:), p3(2,:));
        q_curr = newton(tollerance, q_curr, F, J, p4(1,:), p4(2,:));
        q_curr = newton(tollerance, q_curr, F, J, p5(1,:), p5(2,:));
        q_curr = newton(tollerance, q_curr, F, J, p6(1,:), p6(2,:));
        q_curr = newton(tollerance, q_curr, F, J, p7(1,:), p7(2,:));
        newton(tollerance, q_curr, F, J, p8(1,:), p8(2,:));
    % Gradient
    case 2,
        q_curr = gradient(tollerance, q_curr, F, J, p1(1,:), p1(2,:));
    % Hybrid
    case 3,
    % Reverse
    case 4,
        reverse(F, L1, L2, p1(1,:), p1(2,:));
        reverse(F, L1, L2, p2(1,:), p2(2,:));
        reverse(F, L1, L2, p3(1,:), p3(2,:));
        reverse(F, L1, L2, p4(1,:), p4(2,:));
        reverse(F, L1, L2, p5(1,:), p5(2,:));
        reverse(F, L1, L2, p6(1,:), p6(2,:));
        reverse(F, L1, L2, p7(1,:), p7(2,:));
        reverse(F, L1, L2, p8(1,:), p8(2,:));
end