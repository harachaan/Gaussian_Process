% ガウス過程回帰 (ハイパーパラメータ最適化なし)
clc
clear
close all
% -------------------------------------------------------------------------


% GP kernel parameters
eta = 0.1; % 誤差考慮？
theta_1 = 1;
theta_2 = 1;
params = [theta_1 theta_2];

% 学習データ読み込み
data = readmatrix('gpr.dat');
xtrain = zeros(length(data), 1); ytrain = zeros(length(data), 1);
for i = 1:1:length(data)
    xtrain(i,1) = data(i,1);
    ytrain(i,1) = data(i,2);
end

% 無名関数
kgauss = @(x,y) theta_1 * exp(-(x - y)^2 / (2 * theta_2));

% ここでとりあえず回帰はできた？
xx = (-1:0.1:4)';
regression = gpr(xx, xtrain, ytrain, kgauss, eta); % 1列目が期待値，２列目が分散
mu = regression(:,1);
var = regression(:,2);
two_sigma1 = mu - 2 * sqrt(var); two_sigma2 = mu + 2 * sqrt(var); 

% プロット
f1 = figure;
figure(f1)
patch([xx', fliplr(xx')], [two_sigma1', fliplr(two_sigma2')], 'c');
hold on;
plot(xtrain, ytrain, 'bx', MarkerSize=20);
hold on;
plot(xx, mu, 'b-', LineWidth=2);
title("Simple Gaussian Process Regression");
% xlabel("");
% ylabel("");
save_name = "simple_gpr.png";
saveas(gcf, save_name);






% 列がxtrainで，行に入力xx(一次元の入力であれば横軸)
function kv = kv(x, xtrain, kernel)
kv = zeros(length(xtrain), 1);
for i = 1:1:length(xtrain) % x(ある一つの数字)行，xtrain(入力複数個)列にkernel関数から出るスカラーを要素とする１行ベクトルを出力→やっぱ縦ベクトル？verticalのv説
    kv(i,1) = kernel(x, xtrain(i))
end
end

% カーネル行列Kを作る関数
function K = kernel_matrix(xx, kernel, eta)
N = length(xx);
K = zeros(N, N);
for i = 1:1:N
    for j = 1:1:N
        K(i,j) = kernel(xx(i,1), xx(j,1));
    end
end
K = K + eta * eye(N); % ノイズ考慮
end

% ここで回帰してる？
function y = gpr(xx, xtrain, ytrain, kernel, eta)
K = kernel_matrix(xtrain, kernel, eta); % 学習データのカーネル行列？
Kinv = inv(K);
N = length(xx);
ypr = zeros(N, 1); spr = zeros(N, 1);
for i = 1:1:N
    s = kernel(xx(i,1), xx(i,1)) + eta; 
    k = kv(xx(i,1), xtrain, kernel); % 縦ベクトル？
%     ypr(1,i) = dot(dot(k', Kinv), ytrain); % 期待値？
    ypr(i,1) = k' * Kinv * ytrain;
%     spr(1,i) = s - dot(dot(k', Kinv), k); % 分散？
    spr(i,1) = s - k' * Kinv * k;
end
y = [ypr spr];
end



