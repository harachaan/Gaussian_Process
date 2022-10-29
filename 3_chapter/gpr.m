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

% ハイパーパラメータに対する，式(3.92)の勾配？
function kgrad = kgauss_grad(xi, xj, d, kernel, params)
    if d == 0;
        kernel(xi, xj, params)
    end
end




