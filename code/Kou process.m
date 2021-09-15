%% Asymmetric double-sided exponential distribution
% As used in S. G. Kou, A jump diffusion model for option pricing,
% Management Science 48, 1086-1101, 2002, https://doi.org/10.1287/mnsc.48.8.1086.166
% See also Ballotta and Fusai (2018), Section 6.2.2

% Parameters
clear all % clear all variables from memory
eta1 = 4;
eta2 = 3;
p = 0.4;
xmax = 2; % truncation
deltax = 0.01; % grid step
binw = 0.1; % bin width
n = 10^6; % number of random samples

%% Compute the PDF and sample the distribution
x = -xmax:deltax:xmax; % grid
fX = p*eta1*exp(-eta1*x).*(x>=0) + (1-p)*eta2*exp(eta2*x).*(x<0); % PDF

U = rand(1,n); % standard uniform random variable
X = -1/eta1*log((1-U)/p).*(U>=1-p)+1/eta2*log(U/(1-p)).*(U<1-p); % bilateral exp. r.v.

%% Plot
close all;
figure(1)
x2 = -xmax:binw:xmax; % bin edges
histogram(X,x2,'normalization','pdf');
hold on
plot(x,fX,'linewidth',2)
xlabel('x')
ylabel('f_X')
legend('Sampled','Theory')
title('Asymmetric double-sided distribution')