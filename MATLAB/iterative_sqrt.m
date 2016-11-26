clearvars;
close all;
clc;

set(0, 'DefaultFigureWindowStyle', 'docked');
%%
p = 10;
T = 0.1;            % sampling time (0.1 ~ 0.01)
min_start_point = 1e-3;
tollerance = 1e-6;  % tollerance to stop the algorithm
lambda = 1/(10*T);  % eigenvalue for faster convergence
max_iter = 1000;    % max number of possible iteration
error = zeros(1, max_iter);
convergence = 0;    % convergence flag
i = 1;              % counter
q = zeros(1, max_iter);
q(1) = 1e-2;
if (abs(q(1)) <= min_start_point)
    fprintf('!!! WARNING: starting point too close to zero. Aborting.\n\n');
    return;
end
while (convergence == 0 && i <= max_iter)
    i = i + 1;
    J = 2*q(i-1);
    q(i) = q(i-1) + T*lambda*J^-1*(p - q(i-1)^2);
    error(1, i) = q(i) - q(i-1);
    if (abs(error(i)) <= tollerance)
        convergence = 1;
    end
end
figure(1);
plot(q(1:i));
grid on;
hold on;
if (q(1) > 0)
    plot(1:i, sqrt(p)*ones(i, 1));
else
    plot(1:i, -sqrt(p)*ones(i, 1));
end
legend({'$\hat{q}$', '$q$'},'Interpreter','latex', 'FontSize', 13);
hold off;
figure(2);
plot(2:i, error(2:i));
grid on;
legend({'Error'}, 'Interpreter','latex', 'FontSize', 12);
fprintf('Square root of %f: %f\n\n', p, q(i));
fprintf(['\tSampling time:\t%f\n\tLambda:\t\t%f\n\tStart point:\t%f\n', ...
        '\tIterations:\t%d/%d\n\tTollerance:\t%f\n'], ...
        T, lambda, q(1), i, max_iter, tollerance);