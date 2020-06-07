% we need to convert files with dicom format to jpg
% creat your dataset in folder according to below path
% devide your images to two folder for maxillary and mandibular

% Omid Ghozatlou 2018 University of Tehran
%%
clc; close all;clear
%% Dicom to image
 addpath 'test images'
 cd 'E:\Documents\MSc. Thesis\Thesis\DATA\DATA Landmark\Normal slices\normals\other normals'
 Mandi = 'E:\Documents\MSc. Thesis\Thesis\DATA\DATA Landmark\Normal slices\normals\other normals';% change the last word Maxil OR Mandi
 filePattern = fullfile(Mandi, '*.dcm');
 jpegFiles = dir(filePattern); 
numfiles = length(jpegFiles);
mydata = cell(1, numfiles);

for k = 1:numfiles 
  mydata{k} = dicomread(jpegFiles(k).name); 
  myfilename = sprintf('Mandil_%d.jpg', k);% name of images as .jpg Maxil OR Mandi
  a=double(mydata{k});
  a = (a-min(a(:))) ./ (max(a(:))-min(a(:)));
  imwrite(a , myfilename);
end