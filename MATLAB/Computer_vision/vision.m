clearvars;
close all;
clc;
cd /home/igng/Università/'1° Anno'/'1° Semestre'/'Robotica Industriale'/MATLAB/Computer_vision/
set(0, 'DefaultFigureWindowStyle', 'docked');
%% Acquisition and noise reduction
tic
orig = imread('./pock_1.jpg');
imgsize = size(orig);
orig_gray = rgb2gray(orig);
fin_img = imbinarize(orig_gray, 0.43);
fin_img = imcomplement(fin_img);
SE = [[0, 1, 0]; [1, 1, 1]; [0, 1, 0]];
ero_img = imerode(fin_img, SE);
ero_area = bwarea(ero_img);
mat_area = bwarea(fin_img);
mat_perim = mat_area - ero_area;
figure(1)
imshow(orig)
figure(2)
imshow(fin_img)
center = floor((size(fin_img)+1)/2);
clc

%% Image processing and pixel count

res = 36;
max_grid = 4;
max_num = max_grid^2;
offset = 3;
n_subplot = 0;
d_angle = 180/res;
theta = 0:d_angle:180;
[R, xp] = radon(fin_img, theta);
% for i = 1:res
%     m = mod(i, max_num);
%     if (m == 0)
%         n_subplot = max_num;
%         figure(i/max_num + offset - 1);
%     else
%         n_subplot = m;
%         figure(floor(i/max_num) + offset);
%     end
%     s = subplot(max_grid, max_grid, n_subplot);
%     plot(xp, R(:, i));
%     axis(s, [-1000 1000 0 700]);
%     grid on;
%     str = sprintf('%.2f', theta(i));
%     title(str);
% end
%% Diagonals and center search

col = zeros(1, 2);
p = zeros(2, 2*center(2) + 1);
angle = 0;
mid_angle = 0;
for i = 1:2
    [num, idx] = max(R(:));
    [x, y] = ind2sub(size(R), idx);
    L = xp(x);
    col(1, i) = y;
    angle = -(y - 1)*d_angle;
    mid_angle = mid_angle + angle;
    x_start = center(2) + L*cos(angle*pi/180);
    y_start = center(1) + L*sin(angle*pi/180);
    x_end = x_start + 20*L*cos(angle*pi/180 + pi/2);
    y_end = y_start + 20*L*sin(angle*pi/180 + pi/2);
    figure(2);
    hold on;
    x_line = [x_start, x_end];
    y_line = [y_start, y_end];
    coeffs = polyfit(x_line, y_line, 1);
    x_pol = 0:2*center(2);
    y_pol = polyval(coeffs, x_pol);
    p(i, :) = y_pol;
    plot(x_pol, p(i, :), 'r--');
    max(R(:, y));
    R(:, y) = 0;
    hold off;
end
tollerance = 0;
c = abs(p(1, :) - p(2, :));
x_center = find(c < tollerance);
while (isempty(x_center))
    tollerance = tollerance + 0.1;
    x_center = find(c < tollerance);
end
x_center = x_center(1);
y_center = y_pol(x_center);
figure(2);
hold on;
scatter(x_center, y_center, 'filled', 'red');
hold off;
mid_angle = -floor((mid_angle + d_angle)/2);
angle_index = floor(mid_angle/d_angle) + 1;
%% Draw rectangle approximation

alpha = mid_angle*pi/180;
w = length(find(R(:, angle_index) > 0));
h = max(R(:, angle_index));
x_ver = x_center - cos(-alpha)*w/2 + sin(-alpha)*h/2;
y_ver = y_center - sin(-alpha)*w/2 - cos(-alpha)*h/2;
figure(2);
hold on;
hold off;
xv = [0, w, w, 0, 0];
yv = [0 0 h h 0];
Q(1, :) = xv;
Q(2, :) = yv;
Rm = [cos(-alpha) -sin(-alpha); sin(-alpha) cos(-alpha)];
XY = Rm*Q;
figure(2);
hold on;
plot(XY(1, :) + x_ver, XY(2, :) + y_ver, 'b');
hold off;
toc
%% Area and perimeter calculation
% fprintf('MATLAB area: %f\n', mat_area);
% fprintf('MATLAB peri: %f\n', mat_perim);
% fprintf('My area: %f\n', w*h);
% fprintf('My peri : %f\n', (w+h)*2);