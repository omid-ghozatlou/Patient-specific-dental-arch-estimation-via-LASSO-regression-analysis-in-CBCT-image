% in this script at first we load 13 maxillary and 13 mandibular image
% second by calling symmetry function wecan obtain symmetry axis
% finaly we scatter the 10 landmarks by mouse and save symmetry axis and save input landmarks 
%   sym_mandi: 30 points on the symmetry axis for all mandibular data (13)
%   sym_maxi: 30 points on the symmetry axis for all maxillary data (13)
%   input_mandi: 10 points as cordinates scattered by mouse for all data (13)
%   input_maxi: 10 points as cordinates scattered by mouse for all data (13)

% Omid Ghozatlou 2018 University of Tehran
%%
clc; close all;clear
 addpath 'test images'
 %% loading Images Maxil
cd 'E:\Documents\MSc. Thesis\Thesis\Thesis\test images\Maxil';% change the folder path
 numfiles = 13;
mydata = cell(1, numfiles);

for k = 1:numfiles
  myfilename = sprintf('Maxil_%d.jpg', k);% open files Maxil
  mydata{k} = importdata(myfilename);
end
 
 %% symmetry detection : first Maxil , second Mandi
 cd 'E:\Documents\MSc. Thesis\Thesis\Thesis';
 n = 10; % number of key-points
 sym_maxi = zeros(30,2,numfiles);% Maxilla symmetry axis 
 input_maxi = zeros(n,2,numfiles);% Maxilla keypoint selection
 for k = 1:numfiles
     figure
    [C] =  symmetry(mydata{k},'mirror results');
imshow(mydata{k});hold on;plot(X,Y,'w','LineWidth',4)

   sym_maxi(:,1,k) = C(1:30,1); sym_maxi(:,2,k)=C(1:30,2);
 [x,y]=ginput(n);
 scatter(x,y,'r')

 input_maxi(:,1,k) = [x]; input_maxi(:,2,k) = [y];
 end
 
 save input_maxi % save key points
 save sym_maxi % save symmetry axis

 %% loading Images Mandibular & key-points and symmetry axis
 cd 'E:\Documents\MSc. Thesis\Thesis\Thesis\test images\Mandi';% Maxil OR Mandi
 numfiles = 13; n=10;
mydata = cell(1, numfiles);

for q = 1:numfiles
  myfilename = sprintf('Mandil_%d.jpg', q);% open files Mandi OR Maxil
  mydata{q} = importdata(myfilename);
end
 cd 'E:\Documents\MSc. Thesis\Thesis\Thesis';
sym_mandi = zeros(30,2,numfiles);% symmetry axis
input_mandi = zeros(n,2,numfiles);% keypoint selection
 for q = 1:numfiles
     figure
    [C] =  symmetry(mydata{q},'mirror results');
imshow(mydata{k});hold on;plot(X,Y,'w','LineWidth',4)
   sym_mandi(:,1,q) = C(1:30,1); sym_mandi(:,2,q)=C(1:30,2);
 [x,y]=ginput(n);
 scatter(x,y,'r')
 input_mandi(:,1,q) = [x]; input_mandi(:,2,q) = [y];
 end

save input_mandi % save key points
save sym_mandi % save symmetry axis
