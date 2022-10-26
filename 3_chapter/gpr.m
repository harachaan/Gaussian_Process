% ハイパーパラメータ推定ありのガウス過程回帰．


% 無名関数
kgauss = @(x, y) theta_1 * exp(-(x - y)^2 / (2 * theta_2 * theta_2));




