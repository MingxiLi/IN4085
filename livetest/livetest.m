clear all;
close all;
clc;
a=imread('livetest.jpg');
dataset = img_to_pr(a);
dataset_feat = im_features(dataset, dataset, 'all');
dataset_Euclidean = dataset * proxm(dataset);


%%%%%% S1 %%%%%%
img = prnist([0:9],[1:2:1000]);
img = preproc(img);
prwaitbar off;
img_data = prdataset(img);
img_feat = im_features(img_data, img_data, 'all');
img_Euclidean = img_data * proxm(img_data);
%%%%%% parzen %%%%%%
w_parzen_pixel = pcam(img_data,34) * parzenc([], 0.25);
W_parzen_pixel = img_data * w_parzen_pixel;
e1 = testc(dataset, W_parzen_pixel)
%%%%%% KNN %%%%%%
w_knn_pixel = pcam(img_data, 30) * knnc([], 1);
W_knn_pixel = img_data * w_knn_pixel;
e2_knn_pixel = testc(dataset, W_knn_pixel)
%%%%%% loglc %%%%%%
w_loglc_feat = pcam(img_feat,19) * loglc;
W_loglc_feat = img_feat * w_loglc_feat;
e2_loglc_feat = testc(dataset_feat, W_loglc_feat)
%%%%%% bpxnc %%%%%%
w_bpxnc_feat = pcam(img_feat,18) * bpxnc;
W_bpxnc_feat = img_feat * w_bpxnc_feat;
e2_fisherc_feat = testc(dataset_feat, W_bpxnc_feat)

%{
%%%%%% S2 %%%%%%
img = prnist([0:9],[1:100:1000]);
img = preproc(img);
prwaitbar off;
img_data = prdataset(img);
img_feat = im_features(img_data, img_data, 'all');
img_Euclidean = img_data * proxm(img_data);

%%%%%% Combine Parallel %%%%%%
w_nmc = pcam(img_data,31) * nmc;
w_ldc_f = pcam(img_feat,13) * ldc;
w_ldc_d = pcam(img_Euclidean,25) * ldc;
W = [img_data img_feat img_Euclidean] * [w_nmc; w_ldc_f; w_ldc_d] * prodc;
e2_parallel = testc([dataset dataset_feat dataset_Euclidean], W)
%%%%%% ldc %%%%%%
w_ldc_feat = pcam(img_feat,13) * ldc;
W_ldc_feat = img_feat * w_ldc_feat;
e2_ldc_feat = testc(dataset_feat, W_ldc_feat)
w_ldc_Euclidean = pcam(img_Euclidean,25) * ldc;
W_ldc_Euclidean = img_Euclidean * w_ldc_Euclidean;
e2_ldc_Euclidean = testc(dataset_Euclidean, W_ldc_Euclidean)
%%%%%% fisherc %%%%%%
w_fisherc_feat = pcam(img_feat,13) * fisherc;
W_fisherc_feat = img_feat * w_fisherc_feat;
e2_fisherc_feat = testc(dataset_feat, W_fisherc_feat)
w_fisherc_Euclidean = pcam(img_Euclidean,99) * fisherc;
W_fisherc_Euclidean = img_Euclidean * w_fisherc_Euclidean;
e2_fisherc_Euclidean = testc(dataset_Euclidean, W_ldc_Euclidean)
%%%%%% KNN %%%%%%
w_knn_pixel = pcam(img_data, 9) * knnc([], 1);
W_knn_pixel = img_data * w_knn_pixel;
e2_knn_pixel = testc(dataset, W_knn_pixel)
%%%%%% nmc %%%%%%
w_nmc_pixel = pcam(img_data, 31) * nmc;
W_nmc_pixel = img_data * w_nmc_pixel;
e2_nmc_pixel = testc(dataset, W_nmc_pixel)
%%%%%% parzen %%%%%%
w_parzen_pixel = pcam(img_data, 29) * parzenc([], 1.95);
W_parzen_pixel = img_data * w_parzen_pixel;
e2_parzen_pixel = testc(dataset, W_parzen_pixel)
%%%%%% svc %%%%%%
w_svc_feat = pcam(img_feat,13) * svc;
W_svc_feat = img_feat * w_svc_feat;
e2_svc_feat = testc(dataset_feat, W_svc_feat)
%}