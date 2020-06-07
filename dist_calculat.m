% we load the 4 array to calculate the distances
%   input_mandi, input_maxi    ==> 10 landmarks
%   sym_mandi, sym_maxi      ==> 30 points of axis
% calculate Eucliducian distances and save 2 array
%   Distance_Maxi ,Distance_Mandi

% Cross validation is implemented in line 47 for evaluation 

% Omid Ghozatlou 2018 University of Tehran

%%
clc; close all;clear
 %% Normal Mandibul Distance
load input_mandi
load sym_mandi
n = size(input_mandi,1); numimage = size(input_mandi,3);
x0 = zeros(n,1); y0 = zeros(n,1); Distance_Mandi = zeros(n,numimage);
for k=1:numimage
   x0(:,1) = input_mandi(:,1,k); y0(:,1) = input_mandi(:,2,k);
   x1=sym_mandi(1,1,k);  x2=sym_mandi(end,1,k);  y1=sym_mandi(1,2,k); y2=sym_mandi(end,2,k);
   v1=[x1,y1]; v2=[x2,y2];
     for i=1:n 
       Distance_Mandi(i,k) = abs((y2-y1)*x0(i,1) - (x2-x1)*y0(i,1) +x2*y1 - y2*x1)/norm(v1-v2);      
     end 
     Distance_Mandi(:,k) = Distance_Mandi(:,k)/Distance_Mandi(end,k);
end
% save array as distances of 10 lanmark to symmetry axis for 13 data 
save Distance_Mandi
%% Normal Manxil Distance
load input_maxi
load sym_maxi

n = size(input_maxi,1); numimage = size(input_maxi,3);
x0 = zeros(n,1); y0 = zeros(n,1); Distance_Maxi = zeros(n,numimage);
for k=1:numimage
   x0(:,1) = input_maxi(:,1,k); y0(:,1) = input_maxi(:,2,k);
   x1=sym_maxi(1,1,k);  x2=sym_maxi(end,1,k);  y1=sym_maxi(1,2,k); y2=sym_maxi(end,2,k);
   v1=[x1,y1]; v2=[x2,y2];
     for i=1:n 
       Distance_Maxi(i,k) = abs((y2-y1)*x0(i,1) - (x2-x1)*y0(i,1) +x2*y1 - y2*x1)/norm(v1-v2);
     end 
     Distance_Maxi(:,k) = Distance_Maxi(:,k)/Distance_Maxi(end,k);
end
% save array as distances of 10 lanmark to symmetry axis for 13 data 
save Distance_Maxi 

 %% Cross validation
 addpath lassoomid

x = Distance_Mandi; 
y = Distance_Maxi;
N = size(x,2);

% lambda=2;
% box=logical(ones(13,1));
%         for i = 1:N
% %     [train,test] = crossvalind('LeaveMOut',N,1);
%     box(i)=0;
%     Trans_function =  LassoIteratedRidge(x(:,box),x(:,i),lambda);%normal parts trained & target
%  	estimate = (y(:,box))*(Trans_function);
%     mse(i) =  immse(estimate ,y(:,i));
%     box=logical(ones(13,1));
%         end
%         
% bar(mse,0.4)
% xlabel('Patient number')
% ylabel('mean square error')
% % axis([1 N 0 0.1])
 
%%
lambda = [0:0.5:4.5]; % Initialize the sum of squared error.
for q=1:length(lambda)
    sse=0;
     sse_1=0;
      sse_2=0;
       sse_3=0;
        for i = 1:39
    [train,test] = crossvalind('LeaveMOut',N,1);
    Trans_function =  LassoIteratedRidge(x(:,train),x(:,test),lambda(q));%normal parts trained & target
 	estimate = (y(:,train))*(Trans_function);
    sse = sse + sum((estimate - y(test)).^2);  
    [train_1,test_1] = crossvalind('LeaveMOut',N,1);
    Trans_function_1 =  LassoNonNegativeSquared(x(:,train_1),x(:,test_1),lambda(q));%normal parts trained & target
 	estimate_1 = (y(:,train_1))*(Trans_function_1);
    sse_1 = sse_1 + sum((estimate_1 - y(test_1)).^2);  
    [train_2,test_2] = crossvalind('LeaveMOut',N,1);
    Trans_function_2 =  LassoProjection(x(:,train_2),x(:,test_2),lambda(q));%normal parts trained & target
 	estimate_2 = (y(:,train_2))*(Trans_function_2);
    sse_2 = sse_2 + sum((estimate_2 - y(test_2)).^2);  
      [train_3,test_3] = crossvalind('LeaveMOut',N,1);
    Trans_function_3 =  LassoUnconstrainedApx(x(:,train_3),x(:,test_3),lambda(q));%normal parts trained & target
 	estimate_3 = (y(:,train_3))*(Trans_function_3);
    sse_3 = sse_3 + sum((estimate_3 - y(test_3)).^2); 
    
        end
%         SD(q) = sqrt(sse/(n-1));
CVerr(q) = sse/ 39;
CVerr_1 (q) = sse_1 / 39;
CVerr_2 (q) = sse_2 / 39;
CVerr_3 (q) = sse_3 / 39;
end
figure
hold on
plot(lambda,CVerr,'c-',lambda,CVerr,'b.')
plot(lambda,CVerr_1,'c-',lambda,CVerr_1,'b.')
plot(lambda,CVerr_2,'c-',lambda,CVerr_2,'b.')
plot(lambda,CVerr_3,'c-',lambda,CVerr_3,'b.')
legend('','LassoIteratedRidge','LassoNonNegativeSquared','LassoProjection','LassoUnconstrainedApx')
title('cross-validation')
xlabel('\lambda')
ylabel('mean estimation error')
% axis([0 lambda(q) 0 5.5])