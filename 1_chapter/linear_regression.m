% linear regression をmatlabでしたい！

clc
clear
close all

% サンプルデータの読み込み
data = load('nonlinear.dat');
x = zeros(length(data), 1); y = zeros(length(data), 1);
for i = 1:1:length(data)
    x(i,1) = data(i,1);
    y(i,1) = data(i,2);
end

% linear regression
% w:parameter, x,y: vector of data
    % w = dot(phi(x), phi(x)).^(-1) * dot(phi(x), y);
phi = zeros(length(x), 5);
for i = 1:1:length(x)
    phi(i,:) = feature_vector(x(i,1));
end
w = (phi' * phi)^(-1) * phi' * y;
xx = -7:0.1:4; xx = xx';
phiphi = zeros(length(xx), 5);
for i = 1:1:length(xx)
    phiphi(i,:) = feature_vector(xx(i,1));
end
yy = phiphi * w;
% plot
f1 = figure;
figure(f1);
plot(x, y, 'bo', xx, yy, 'g-')

% 特徴ベクトル，基底関数
function feature_vector = feature_vector(x)
feature_vector = [1 x x^2 sin(x) cos(x)];
end