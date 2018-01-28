%%%%%% Stacked Combine %%%%%%

close all
clear all
clc

img = prnist([0:9],[1:100:1000]);

%%%%%% image preprocess %%%%%%
img = preproc(img);
prwaitbar off;

%%%%%% Creates a PRdataset from the nist with features %%%%%%
img_data = prdataset(img);

%%%%%% Representation %%%%%%
% Features
img_feat = im_features(img_data, img_data, 'all');
% Dissimilarity
img_Euclidean = img_data * proxm(img_data);  % Euclidean

w_ldc = pcam(img_Euclidean,25) * ldc;
w_fisherc = pcam(img_Euclidean,99) * fisherc;
W = [w_ldc, w_fisherc];

Cmax = W * maxc;            % max combiner
Cmin = W * minc;            % min combiner
Cmean = W * meanc;          % mean combiner
Cprod = W * prodc;          % product combiner

[err,std] = prcrossval(img_Euclidean,{Cmax,Cmin,Cmean,Cprod},10,10)