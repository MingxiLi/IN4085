%%%%%% How to select KNN numbers %%%%%%

close all
clear all
clc

img = prnist([0:9],[1:4:1000]);

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

%%%%%% pixel: Different Classifiers %%%%%%
e_pixel = zeros(1, 8);
std_pixel = zeros(1, 8);
% Knn classifiers
for n = 1:8
    [e_pixel(n), std_pixel(n)] = prcrossval(img_data,knnc([],n),10,10);
end
figure
plot(e_pixel)
xlabel('N'), ylabel('error rate')
title('Pixel')

%%%%%% im_features: Different Classifiers %%%%%%
e_im_features = zeros(1, 16);
std_im_features = zeros(1, 16);
% Knn classifiers
for n = 1:16
    [e_im_features(n), std_im_features(n)] = prcrossval(img_feat,knnc([],n),10,10);
end
figure
plot(e_im_features)
xlabel('N'), ylabel('Error Rate')
title('Feature(im\_feature)')

%%%%%% Dissimilarity(Euclidean): Different Classifiers %%%%%%
e_distance = zeros(1, 8);
std_distance = zeros(1, 8);
% Knn classifiers
for n = 1:8
    [e_distance(n), std_distance(n)] = prcrossval(img_Euclidean,knnc([],n),10,10);
end
figure
plot(e_distance)
xlabel('N'), ylabel('Error Rate')
title('Dissimilarity(Euclidean)')
