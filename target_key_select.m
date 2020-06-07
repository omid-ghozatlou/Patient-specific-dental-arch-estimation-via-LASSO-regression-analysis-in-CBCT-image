% this script is last  
% we read anormal both maxillary and mandibular images
%   call symmetry function and then scatter landmarks by mouse for maxillary image
%   call symmetry function and then scatter landmarks by mouse for mandibulr image
% then implement LASSO function and obtain sparse coefficients
% estimation of distances and find location of estimated landmarks
% 
%  finally show estimated landmarks and interpolation of them to show dental arch

% Omid Ghozatlou 2018 University of Tehran
%%
clc; close all;clear
%% Dicom to image
%  addpath 'test images'
%  cd 'E:\Documents\MSc. Thesis\Thesis\Thesis\test images';
%  info = dicominfo('maxi.dcm');
% [a,map] = dicomread(info);
% a=double(a);
% a = (a-min(a(:))) ./ (max(a(:)-min(a(:))));
% imwrite(a,'maxi.jpg');

im_target_mandi=(imread('test images\abnormal\Mandil_13.jpg'));
im_target_maxi=(imread('test images\abnormal\Maxil_13.jpg'));
%% target Maxilla symmetry detection & keypoint selection 
% cd 'E:\Documents\MSc. Thesis\Thesis\Thesis';
 n = 10; % number of key-points
 
[C] =  symmetry(im_target_maxi,'mirror results');
x_sym_target_maxi = C(1:20,1) ; y_sym_target_maxi = C(1:20,2) ; 
 [x,y]=ginput(n);
 scatter(x,y,'r')
 x_input_target_maxi = x ; y_input_target_maxi = y ;

%% target Mandibul symmetry detection & keypoint selection

[C] =  symmetry(im_target_mandi,'mirror results');
x_sym_target_mandi = C(1:20,1) ; y_sym_target_mandi = C(1:20,2) ; 
 [x,y]=ginput(n);
 scatter(x,y,'r')
 x_input_target_mandi = x ; y_input_target_mandi = y ;
% load y_input_target_maxi
% load x_input_target_maxi
 %% Target Maxil Distance

   x0 = x_input_target_maxi; y0 = y_input_target_maxi;
   x1=x_sym_target_maxi(1);  x2=x_sym_target_maxi(end);  y1=y_sym_target_maxi(1); y2=y_sym_target_maxi(end);
   v1=[x1,y1]; v2=[x2,y2];
     for i=1:n 
       Distance_target_Maxi(i,1) = abs((y2-y1)*x0(i,1) - (x2-x1)*y0(i,1) +x2*y1 - y2*x1)/norm(v1-v2);
     end 
    normaliz_maxi = Distance_target_Maxi(end);
%     Distance_target_Maxi=Distance_target_Maxi/normaliz_maxi;
 %% Target Mandil Distance

   x0 = x_input_target_mandi; y0 = y_input_target_mandi;
   x1=x_sym_target_mandi(1);  x2=x_sym_target_mandi(end);  y1=y_sym_target_mandi(1); y2=y_sym_target_mandi(end);
   v1=[x1,y1]; v2=[x2,y2];
     for i=1:n 
       Distance_target_Mandi(i,1) = abs((y2-y1)*x0(i,1) - (x2-x1)*y0(i,1) +x2*y1 - y2*x1)/norm(v1-v2);
     end 
     normaliz_mandi = Distance_target_Mandi(end);
%      Distance_target_Mandi=Distance_target_Mandi/Distance_target_Mandi(end);
 %% LASSO normal data with normal part of patient(target)
 load Distance_Maxi
 load Distance_Mandi
 addpath 'lassoomid'
lambda =3.5;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Mandi is abnormal
%   Trans_function =  LassoUnconstrainedApx(Distance_Maxi,Distance_target_Maxi,lambda);%normal parts trained & target
%   estimate = zeros(size(Distance_target_Mandi));% anormal part target
%   estimate = (Distance_Mandi)*(Trans_function);% anormal part trained
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Maxi is abnormal
Trans_function =  LassoUnconstrainedApx(Distance_Mandi,Distance_target_Mandi,lambda);%normal parts trained & target
  estimate = zeros(size(Distance_target_Maxi));% anormal part target
  estimate = (Distance_Maxi)*(Trans_function);% anormal part trained

 %% show result 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% mandi anormal image
%  figure
% [C] =  symmetry(im_target_mandi,'mirror results');
% ang=atan((C(end,2)-C(1,2))/(C(end,1)-C(1,1))); %*(180/pi);
%   hold on 
%   plot((x_input_target_mandi),(y_input_target_mandi),'g.','LineWidth',1)
% %% prependicular poit on symmettry axis finden
% x0=x_input_target_mandi; y0=y_input_target_mandi;%y_p(:,1)=y0(:,1);
% for j=1:n
% for i=1:size(C,1)   
%    A(i)=sqrt((x0(j,1)-C(i,1))^2+((y0(j,1)-C(i,2))^2));     
% end
% H=((min(A)));
% index=find(A==H);
% x_p(j,1)=C(index,1);%x_p(j,1)=xq(index);
% y_p(j,1)=C(index,2);%y_p(j,1)=vq(index);
% 
% est(j,:)=[x_p(j)+(estimate(j)*cos((pi/2)-ang)) , y_p(j)-(estimate(j)*sin((pi/2)-ang))];
% mir_est(j,:)=[x_p(j)-(estimate(j)*cos((pi/2)-ang)) , y_p(j)+(estimate(j)*sin((pi/2)-ang))];
% 
% plot(x_p(j),y_p(j),'r*')
% line([est(j,1),mir_est(j,1)],[est(j,2),mir_est(j,2)])
% plot(est(j,1),est(j,2),'ro',mir_est(j,1),mir_est(j,2),'ro')
% legend('target mandil 11','Landmark','perpendicular to axis','Perpendicular lines','estimated Landmark')
% end
%    sse = sum((estimate - Distance_target_Mandi).^2)/normaliz_mandi;  
% %% interpolate curve show
%  figure
% symmetry(im_target_maxi,'mirror results');
% hold on
% curve = zeros(20,2);
% for q=1:10
% curve(q,:) = est(11-q,:);
% end
% curve(11:20,:) = mir_est(:,:);
% 
% curve_xq=[curve(1,1):1:curve(end,1)];
%  curve_vq = interp1(curve(:,1),curve(:,2),curve_xq,'spline');
%  plot(curve_xq,curve_vq,'-c','LineWidth',2.1)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Maxi abnormal
 figure
[C] =  symmetry(im_target_maxi,'mirror results');
ang=atan((C(end,2)-C(1,2))/(C(end,1)-C(1,1))); %*(180/pi);
  hold on 
  plot((x_input_target_maxi),(y_input_target_maxi),'g.','LineWidth',1)
%% prependicular poit on symmettry axis finden
x0=x_input_target_maxi; y0=y_input_target_maxi;%y_p(:,1)=y0(:,1);
for j=1:n
for i=1:size(C,1)   
   A(i)=sqrt((x0(j,1)-C(i,1))^2+((y0(j,1)-C(i,2))^2));     
end
H=((min(A)));
index=find(A==H);
x_p(j,1)=C(index,1);%x_p(j,1)=xq(index);
y_p(j,1)=C(index,2);%y_p(j,1)=vq(index);

est(j,:)=[x_p(j)+(estimate(j)*cos((pi/2)-ang)) , y_p(j)-(estimate(j)*sin((pi/2)-ang))];
mir_est(j,:)=[x_p(j)-(estimate(j)*cos((pi/2)-ang)) , y_p(j)+(estimate(j)*sin((pi/2)-ang))];

plot(x_p(j),y_p(j),'r*')
line([est(j,1),mir_est(j,1)],[est(j,2),mir_est(j,2)])
plot(est(j,1),est(j,2),'ro',mir_est(j,1),mir_est(j,2),'ro')
legend('target maxil 13','Landmark','perpendicular to axis','Perpendicular lines','estimated Landmark')
end
   sse = sum((estimate - Distance_target_Maxi).^2)/normaliz_maxi;  
%% interpolate curve show
 figure
symmetry(im_target_maxi,'mirror results');
hold on
curve = zeros(20,2);
for q=1:10
curve(q,:) = est(11-q,:);
end
curve(11:20,:) = mir_est(:,:);

curve_xq=[curve(1,1):1:curve(end,1)];
 curve_vq = interp1(curve(:,1),curve(:,2),curve_xq);
 plot(curve_xq,curve_vq,'-c','LineWidth',2.1)
% %  
% 
