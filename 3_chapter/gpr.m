% ハイパーパラメータ推定ありのガウス過程回帰．
clc
clear
close all 

% kernel parameters
tau = log(1);
sigma = log(1);
eta = log(1);
params = [tau sigma eta];

% 




x = 1; y = 2;
gaussian_kernel(x, y, params);

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

% 一つのxtrainに対する行ベクトル．すなわち行が入力xx (１次元の入力ならx軸(横軸))，列がxtrainの学習カーネル行列？？
function kv = kv(x, xtrain, kernel)
    for i = 1:1:N
end



