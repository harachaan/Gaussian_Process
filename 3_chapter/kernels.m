% さまざまなカーネルによるガウス過程からのサンプル
clc
clear
close all

curdir = pwd;

% 入力は１次元？
x = (-5:0.1:5)';
% y = (-5:0.1:5)';

% ガウス分布からのサンプル生成のための共分散行列??
% sigma = eye(2);
% -------------------------------------------------------------------------

% 無名関数に使われるparameters??
params = [log(2) log(2)];
theta_1 = params(1,1); theta_2 = params(1,2);

theta = rand * 10;

% 無名関数たち
% linear kernel
b = randn(1, 1); b = abs(b .* 10);
klinear = @(x,y)  b + x * y; % なんでこれで線形回帰の平均が０じゃなくなって，しかも全部違うくなるのか

% Gaussian kernel
kgauss = @(x,y) exp(theta_1) * exp(-(x - y)^2 / exp(theta_2));

% Exponential kernel
kexp = @(x, y) exp(-abs(x - y) / theta);

% Periodic kernel
kperiodic = @(x, y) exp(theta_1 * cos((x - y) / theta));

% Matern3 kernel
% kmatern_3 = % ちょっとわからんかった

% -------------------------------------------------------------------------

% kernel_matrix(x, klinear);

savedir = strcat(curdir, '/../../temporary/');

f1 = figure;
figure(f1);
for i = 1:1:5
y = gaussian_process(x, klinear);
plot(x, y, '-')
hold on;
end
filename = "GP-LinearKernel"; savename = strcat(savedir, filename, ".png");
title(filename);
saveas(gcf, savename);

f2 = figure;
figure(f2);
for i = 1:1:5
y = gaussian_process(x, kgauss);
plot(x, y, '-')
hold on;
end
filename = "GP-GaussianKernel"; savename = strcat(savedir, filename, ".png");
title(filename);
saveas(gcf, savename);

f3 = figure;
figure(f3);
for i = 1:1:5
y = gaussian_process(x, kexp);
plot(x, y, '-')
hold on;
end
filename = "GP-ExponentialKernel"; savename = strcat(savedir, filename, ".png");
title(filename);
saveas(gcf, savename);

f4 = figure;
figure(f4);
for i = 1:1:5
y = gaussian_process(x, kperiodic);
plot(x, y, '-')
hold on;
end
filename = "GP-PeriodicKernel"; savename = strcat(savedir, filename, ".png");
title(filename);
saveas(gcf, savename);

% xx = gauss2_gen(eye(2));
% plot(xx(1,:), xx(2,:), 'o')

% -------------------------------------------------------------------------------
% 2次元??標準正規分布からのサンプルの生成(共分散行列sigmaは2次元だけど，N行N列？)
function mvnrnd = gauss2_gen(sigma)
% x1 = randn(1000, 1);
% x2 = randn(1000, 1);
% x = [x1'
%      x2'];
N = length(sigma);
num_sumple = 1; % 1000じゃダメ．？
% x = zeros(N, num_sumple);
x = randn(N, num_sumple);
L = chol(sigma)';
mvnrnd = zeros(N, num_sumple);
for i = 1:1:num_sumple
    mvnrnd(:,i) = L * x(:,i);
end

end

% Kernel CoV matrix
function K = kernel_matrix(xx, kernel)
N = length(xx);
eta = 1e-6;
K = zeros(N,N);
for i = 1:1:N
    for j = 1:1:N
        K(i,j) = kernel(xx(i,:), xx(j,:));
    end
end
K = K + eta * eye(N); % ちょっと何してるかわからない→もしかしてノイズを合わせてる？
end

% fgpとは
function fgp = gaussian_process(xx, kernel)
K = kernel_matrix(xx, kernel);
fgp = gauss2_gen(K);
end


% 無名関数を使うための関数？
function y = let(val, func)
y = func(val);
end
% 
% 
% function kernel = klinear(x, y)
% b = randn(length(x));
% kernel = b + x * y;
% end
% % Gaussian kernel
% function kernel = kgauss(params, x, y)
% [tau, sigma] = params;
%     % なんでtauとsigmaのexpをとってるん？
% kernel = exp(tau) * exp(-abs(x - y)^2 / exp(sigma));
% end
% 
% function K = kernel_matrix
% 
% end