% ハイパーパラメータ推定ありのガウス過程回帰．
clc
clear
close all 

% kernel parameters
tau = log(1);
sigma = log(1);
% eta = log(1);
eta = log(0.1);

params = [tau sigma eta];

% 学習データ読み込み
data = readmatrix('gpr.dat');
xtrain = zeros(length(data), 1); ytrain = zeros(length(data), 1);
for i = 1:1:length(data)
    xtrain(i,1) = data(i,1);
    ytrain(i,1) = data(i,2);
end



% 確め計算ゾーン
gaussian_kernel(xtrain(3,1), ytrain(3,1), params);
kv(xtrain(i,1), xtrain, params);

% 回帰の計算
xx = (-1:0.1:4)';
regression = gpr(xx, xtrain, ytrain, params);
mu = regression(:,1); var = regression(:,2);
two_sigma1 = mu - 2 * sqrt(var); two_sigma2 = mu + 2 * sqrt(var);

% plot
f1 = figure;
figure(f1)
patch([xx', fliplr(xx')], [two_sigma1', fliplr(two_sigma2')], 'c');
hold on;
plot(xtrain, ytrain, 'bx', MarkerSize=20);
hold on;
plot(xx, mu, 'b-', LineWidth=2);
title("Gaussian Process Regression with parameters estimation");
save_name = "gpr_with_params_estimation.png";
saveas(gcf, save_name);

% -------------------------------------------------------------------------
% kgauss(x, y);
function delta = delta(x, y)
    if x == y
        delta = 1;
    else
        delta = 0;
    end
end

% デルタ関数考慮のガウスカーネル生成
function gaussian_kernel = gaussian_kernel(x, y, params)
    tau = params(1,1); sigma = params(1,2); eta = params(1,3);
    % 無名関数
    kgauss = @(x, y) exp(tau) * exp(-(x - y)^2 / exp(sigma))...
        + exp(eta) * delta(x, y);
    gaussian_kernel = kgauss(x, y);
end

% ハイパーパラメータに対する，式(3.92)の勾配？dって何？
function kgrad = kgauss_grad(xi, xj, d, kernel, params)
    if d == 1
        kgrad = exp(params(1,d)) * kernel(xi, xj, params);
    elseif d == 2
        kgrad = kernel(xi, xj, params) * (xi - xj) * (xi - xj) / exp(params(1, d));
    elseif d == 3
        if xi == xj
            kgrad = exp(1, d);
        else
            kgrad = 0;
        end
    end
end

% 一つの入力xに対するxtrainの列ベクトル．すなわち列が入力x (１次元の入力ならx軸(横軸))，行がxtrainの学習カーネル行列？？
% xtrainは列ベクトル（縦）
function kv = kv(x, xtrain, params) % kernelを無名関数で作ってないから，kernelとして引数で与えられないことに注意．
    kv = zeros(length(xtrain), 1);
    for i = 1:1:length(xtrain)
        kv(i,1) = gaussian_kernel(x, xtrain(i,1), params) ...
            - exp(params(1,3)) * delta(x, xtrain(i,1)); % kvを作るときになんかしてる．．．
    end    
end

% カーネル行列を作る関数
function K = kernel_matrix(xx, params)
    N = length(xx);
    K = zeros(N, N);
    for i = 1:1:N
        for j = 1:1:N
            K(i,j) = gaussian_kernel(xx(i,1), xx(j,1), params);
        end
    end
end

% ガウス過程回帰
function y = gpr(xx, xtrain, ytrain, params)
    K = kernel_matrix(xtrain, params); % 学習データのカーネル行列
    Kinv = inv(K);
    N = length(xx);
    mu = zeros(N, 1); var = zeros(N, 1);
    for i = 1:1:N
        s = gaussian_kernel(xx(i,1), xx(i,1), params); % カーネル行列 k_** を作ってる．
        k = kv(xx(i,1), xtrain, params); % 縦ベクトル (回帰する点のカーネル行列k^*?)
        mu(i,1) = k' * Kinv * ytrain;
        var(i,1) = s - k' * Kinv * k;
    end
    y = [mu var]; % 回帰した平均と分散？
end

% trace (対角和)
function trace = tr(A, B)
    trace = 
end



% function ans = main()
% end


