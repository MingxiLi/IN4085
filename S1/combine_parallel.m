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
% Dissimilarity
img_Euclidean = img_data * proxm(img_data);  % Euclidean

w_bpxnc = pcam(img_feat, 18) * bpxnc;
w_KNN = pcam(img_data,30) * knnc([], 1);
W = [w_KNN; w_bpxnc];
dataset = [img_data img_feat];

Cmax = W * maxc;            % max combiner
Cmin = W * minc;            % min combiner
Cmean = W * meanc;          % mean combiner
Cprod = W * prodc;          % product combiner

[err,std] = prcrossval(dataset,{Cmax,Cmin,Cmean,Cprod},10,10)