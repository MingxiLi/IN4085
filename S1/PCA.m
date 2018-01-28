%%%%%% PCA %%%%%%

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

%{
%%%%%% PCA(pixel) %%%%%%
e_KNN1 = zeros(1, 128);
std_KNN1 = zeros(1, 128);
e_KNN3 = zeros(1, 128);
std_KNN3 = zeros(1, 128);
e_parzen = zeros(1, 128);
std_parzen = zeros(1, 128);
for n = 1: 128
    pca_pixel = pcam(img_data, n);
    [e_KNN1(n), std_KNN1(n)] = prcrossval(img_data,pca_pixel*knnc([], 1),10,10);
    [e_KNN3(n), std_KNN3(n)] = prcrossval(img_data,pca_pixel*knnc([], 3),10,10);
    [e_parzen(n), std_parzen(n)] = prcrossval(img_data,pca_pixel*parzenc([], 0.25),10,10);
end
figure
plot(e_KNN1, 'rd')
hold on
plot(e_KNN3, 'g*')
hold on
plot(e_parzen, 'bs')
hold on
legend('KNN(1)', 'KNN(3)', 'Parzen')
xlabel('N'), ylabel('error rate')
title('PCA(Pixel)')
%}
