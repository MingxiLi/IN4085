%%%%%% PCA %%%%%%

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

%{
%%%%%% PCA(pixel) %%%%%%
e_KNN = zeros(1, 128);
std_KNN = zeros(1, 128);
e_nmc = zeros(1, 128);
std_nmc = zeros(1, 128);
e_parzen = zeros(1, 128);
std_parzen = zeros(1, 128);
for n = 1: 128
    pca_pixel = pcam(img_data, n);
    [e_KNN(n), std_KNN(n)] = prcrossval(img_data,pca_pixel*knnc([], 1),10,10);
    [e_nmc(n), std_nmc(n)] = prcrossval(img_data,pca_pixel*nmc,10,10);
    [e_parzen(n), std_parzen(n)] = prcrossval(img_data,pca_pixel*parzenc([], 1.95),10,10);
end
figure
plot(e_KNN, 'rd')
hold on
plot(e_nmc, 'g*')
hold on
plot(e_parzen, 'bs')
hold on
legend('KNN(1)', 'nmc', 'Parzen')
xlabel('N'), ylabel('error rate')
title('PCA(Pixel)')
%}


%%%%%% PCA(pixel) %%%%%%
e_ldc = zeros(1, 24);
std_ldc = zeros(1, 24);
e_fisherc = zeros(1, 24);
std_fisherc = zeros(1, 24);
e_svc = zeros(1, 24);
std_svc = zeros(1, 24);
for n = 1: 24
    pca_pixel = pcam(img_feat, n);
    [e_ldc(n), std_ldc(n)] = prcrossval(img_feat,pca_pixel*ldc,10,10);
    [e_fisherc(n), std_fisherc(n)] = prcrossval(img_feat,pca_pixel*fisherc,10,10);
    [e_svc(n), std_svc(n)] = prcrossval(img_feat,pca_pixel*svc,10,10);
end
figure
plot(e_ldc, 'rd')
hold on
plot(e_fisherc, 'g*')
hold on
plot(e_svc, 'bs')
hold on
legend('ldc', 'fisherc', 'svc')
xlabel('N'), ylabel('error rate')
title('PCA(Features)')

%{
%%%%%% PCA(dissimilarity) %%%%%%
e_ldc = zeros(1, 100);
std_ldc = zeros(1, 100);
e_fisherc = zeros(1, 100);
std_fisherc = zeros(1, 100);
e_loglc = zeros(1, 100);
std_loglc = zeros(1, 100);
for n = 1: 100
    pca_pixel = pcam(img_Euclidean, n);
    [e_ldc(n), std_ldc(n)] = prcrossval(img_Euclidean,pca_pixel*ldc,10,10);
    [e_fisherc(n), std_fisherc(n)] = prcrossval(img_Euclidean,pca_pixel*fisherc,10,10);
    [e_loglc(n), std_loglc(n)] = prcrossval(img_Euclidean,pca_pixel*loglc,10,10);
end
figure
plot(e_ldc, 'rd')
hold on
plot(e_fisherc, 'g*')
hold on
plot(e_loglc, 'bs')
hold on
legend('ldc', 'fisherc', 'loglc')
xlabel('N'), ylabel('error rate')
title('PCA(Dissimilarity)')
%}