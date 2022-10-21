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

% 無名関数
kgauss = @(x,y) theta_1 * exp(-(x - y)^2 / (2 * theta_2 * theta_2));

% 列がxtrainで，行に入力xx(一次元の入力であれば横軸)
function kv = kv(x, xtrain, kernel)
for i = 
end

% 予測値を求める関数？これが線になる説
