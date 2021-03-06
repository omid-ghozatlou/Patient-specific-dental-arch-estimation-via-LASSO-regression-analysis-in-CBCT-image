clc;clear ;close all

% prepare_housing

X=(1.5).*ones(21,30);
X(1:end,1:8)=3;
addpath 'sub'
addpath 'lassoomid'

X(1:end,13:end)=0.001;
y=(3).*ones(21,1);
y_low=(2).*ones(21,1);
% X=X';
% y=y';
% Scaled Norm Solvers
lambda =2;
% [LassoBlockCoordinate(X,y,lambda) ...
%     LassoConstrained(X,y,lambda,'mode',2) ...
%     LassoGaussSeidel(X,y,lambda) ...
%     LassoGrafting(X,y,lambda) ...
  W =  LassoIteratedRidge(X,y,lambda);
  est=zeros(size(y));
  est = (X)*(W);
  save('W')
%     LassoNonNegativeSquared(X,y,lambda) ...
%     LassoPrimalDualLogBarrier(X,y,lambda) ...
%     LassoProjection(X,y,lambda) ...
%     LassoShooting(X,y,lambda) ...
%     LassoSubGradient(X,y,lambda) ...
%     LassoUnconstrainedApx(X,y,lambda) ...
%     LassoUnconstrainedApx(X,y,lambda,'mode2',1)]
% % pause;
% % 

% Constrained Norm Solvers
% t = sum(abs(ans(:,end)));
% if exist('LassoLARS')
%     [LassoActiveSet(X,y,t) ...
%         LassoConstrained(X,y,t) ...
%         LassoLARS(X,y,t) ...
%         LassoSignConstraints(X,y,t)]
% else
%     [LassoActiveSet(X,y,t) ...
%         LassoConstrained(X,y,t) ...
%         LassoSignConstraints(X,y,t)]
% end