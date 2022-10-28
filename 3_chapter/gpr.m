% ハイパーパラメータ推定ありのガウス過程回帰．
clc
clear
close all 

% kernel parameters
tau = log(1);
sigma = log(1);
eta = log(1);
params = [tau sigma eta];




% 無名関数
kgauss = @(x, y) exp(tau) * exp(-(x - y)^2 / exp(sigma))...
    + exp(eta) * delta(x, y);

% x = 1; y = 2;
gaussian_kernel(kgauss, x, y, params)
% kgauss(x, y);
function delta = delta(x, y)
    if x == y
        delta = 1;
    else
        delta = 0;
    end
end

% なんかうまくいかなかった...
function gaussian_kernel = gaussian_kernel(kgauss, x, y, params)
    tau = params(1,1); sigma = params(1,2); eta = params(1,3);
    gaussian_kernel = kgauss(x, y);
end

