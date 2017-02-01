clearvars;
close all;
clc;
cd /home/igng/Università/'1° Anno'/'1° Semestre'/'Robotica Industriale'/MATLAB/Computer_vision/
set(0, 'DefaultFigureWindowStyle', 'docked');
%% Acquisition and noise reduction

orig = imread('./pock_1.jpg');
imgsize = size(orig);
orig_gray = rgb2gray(orig);
fin_img = imbinarize(orig_gray, 0.45);
com_img = imcomplement(fin_img);
figure(1)
imshow(orig)
figure(2)
imshow(com_img)
clc

%% Image processing and pixel count
% fin_img = zeros(100, 100);
% fin_img(25:75, 25:75) = 1;
res = 36;
d_angle = 180/res;
theta = 0:d_angle:180;
[R, xp] = radon(com_img, theta);
% for i = 1:res + 1
%     figure(i+10);
%     plot(xp, R(:,i));
%     grid on;
%     str = sprintf('%d degree', theta(i));
%     title(str);
% end
col = zeros(1, 2);
for i = 1:2
    [num, idx] = max(R(:));
    [x, y] = ind2sub(size(R), idx);
    col(1, i) = y;
    R(:, y) = 0;
end
col*d_angle