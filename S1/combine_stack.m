%%%%%% Stacked Combine %%%%%%

close all
clear all
clc

img = prnist([0:9],[1:2:1000]);

%%%%%% image preprocess %%%%%%
img = preproc(img);
prwaitbar off;

%%%%%% Creates a PRdataset from the nist with features %%%%%%
img_data = prdataset(img);

%%%%%% Representation %%%%%%
% Features
img_feat = im_features(img_data, img_data, 'all');

w_parzen = pcam(img_data,34) * parzenc([], 0.25);
w_KNN = pcam(img_data,30) * knnc([], 1);
W = [w_parzen, w_KNN];

Cmax = W * maxc;            % max combiner
Cmin = W * minc;            % min combiner
Cmean = W * meanc;          % mean combiner
Cprod = W * prodc;          % product combiner

[err,std] = prcrossval(img_data,{Cmax,Cmin,Cmean,Cprod},10,2)