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

w_nmc = pcam(img_data,31) * nmc;
w_ldc_f = pcam(img_feat,13) * ldc;
w_ldc_d = pcam(img_Euclidean,25) * ldc;
W = [w_nmc; w_ldc_f; w_ldc_d];
dataset = [img_data img_feat img_Euclidean];

Cmax = W * maxc;            % max combiner
Cmin = W * minc;            % min combiner
Cmean = W * meanc;          % mean combiner
Cprod = W * prodc;          % product combiner

[err,std] = prcrossval(dataset,{Cmax,Cmin,Cmean,Cprod},10,10)