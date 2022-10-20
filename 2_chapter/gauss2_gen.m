% 2次元のガウス分布からのサンプルの生成
clc
clear
close all


% 標準正規分布からの乱数生成
x1 = randn(1000, 1);
x2 = randn(1000, 1);
x = [x1'
     x2'];
% 共分散行列
sigma = eye(2);
% sigma = [1 0.9
%        0.9 1];
L = chol(sigma)'; % cholだけだと上三角行列になるので転置する

% サンプルの生成
y = zeros(2, length(x));
for i = 1:1:length(x)
    y(:,i) = L * x(:,i);
end

f1 = figure;
figure(f1);
plot(y(1,:), y(2,:), 'o')