%%%%%% im_features %%%%%%

close all
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

%%%%%% im_features: Different Classifiers %%%%%%
% SVM
[e_svm,std_svm] = prcrossval(img_feat,svc,10,10);

% Knn classifiers(N = 8)
%[e_knn,std_knn] = prcrossval(img_feat,knnc([],8),10,10);

% Parzen classifier, optimal window size (h = 0.4)
%[e_parz,std_parz] = prcrossval(img_feat,parzenc([],0.4),10,10);

% LDC classifier
[e_ldc,stdldc]=prcrossval(img_feat,ldc,10,10);

% LOGLC classifier
[e_loglc, srd_loglc] = prcrossval(img_feat,loglc,10,10);

% FISHERC classifier
[e_fisher, std_fisher] = prcrossval(img_feat,fisherc,10,10);

% NMC classifier
[e_nmc, std_nmc] = prcrossval(img_feat,nmc,10,10);

% QDC classifier
[e_qdc, std_qdc] = prcrossval(img_feat,qdc,10,10);

%Forward neural network by Levenberg-Marquardt rule
[e_lmnc,stdlmnc] = prcrossval(img_feat,lmnc,10,10);

%Forward neural network classifier by backpropagation
[e_bpxnc,stdbpxnc] = prcrossval(img_feat,bpxnc,10,10);



