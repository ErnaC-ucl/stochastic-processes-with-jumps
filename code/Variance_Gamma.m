%% Simulate a time-changed arithmetic Brownian motion: the variance gamma process
% dX(t) = mu*dG(t) + sigma*dW(G(t))

% Define parameters and time grid
clear all % clear all variables from memory
npaths = 20000; % number of paths
T = 1; % time horizon
nsteps = 200; % number of time steps
dt = T/nsteps; % time step
t = 0:dt:T; % observation times
mu = 0.2; sigma = 0.3; % model parameters of the ABM
kappa = 0.05; % scale parameter of the gamma process = 1/beta = 1/rate

%% Monte Carlo

%Compute the increments of the gamma process
dG = gamrnd(dt/kappa,kappa,[nsteps,npaths]);

% Compute the increments of the ABM on the gamma random clock
dX = mu*dG + sigma*randn(nsteps,npaths).*sqrt(dG);

% Accumulate the increments
X = [zeros(1,npaths); cumsum(dX)];

%% Expected, mean and sample path
figure(1)
close all
EX = mu*t; % expected path
plot(t,EX,'k',t,mean(X,2),':k',t,X(:,1:1000:end),t,EX,'k',t,mean(X,2),':k')
legend('Expected path','Mean path')
xlabel('t')
ylabel('X')
ylim([-0.8,1.2])
title('Paths of a variance Gamma process dX(t) = \mudG(t) + \sigmadW(G(t))')
print('-dpng','vgpaths.png')

% Probability density function at different times
figure(2)

[h,x] = hist(X(40,:),100);
f = h/(sum(h)*(x(2)-x(1)));
subplot(3,1,1)
bar(x,f)
ylabel('f_X(x,0.2)')
xlim([-0.8,1.2])
ylim([0,6])
title('Probability density function of a variance Gamma process at different times')

[h,x] = hist(X(100,:),100);
f = h/(sum(h)*(x(2)-x(1)));
subplot(3,1,2)
bar(x,f)
xlim([-0.8,1.2])
ylim([0,3])
ylabel('f_X(x,0.5)')

[h,x] = hist(X(end,:),100);
f = h/(sum(h)*(x(2)-x(1)));
subplot(3,1,3)
bar(x,f)
xlim([-0.8,1.2])
ylim([0,3])
xlabel('x')
ylabel('f_X(x,1)')

print('-dpng','vgdensities.png')