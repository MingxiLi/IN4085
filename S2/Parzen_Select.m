%%%%%% How to select Parzen numbers %%%%%%

close all
clear all
clc

img = prnist([0:9],[1:100:1000]);
%%%%%% image preprocess %%%%%%
img = preproc(img);
prwaitbar off;

%%%%%% Creates a PRdataset from the nist with features %%%%%%
img_data = prdataset(img);
show(img_data)
%%%%%% Representation %%%%%%
% Features
img_feat = im_features(img_data, img_data, 'all');

% Dissimilarity
img_Euclidean = img_data * proxm(img_data);  % Euclidean

%%%%%% pixel: Different Classifiers %%%%%%
e_pixel = [];
std_pixel = [];
i = 1;
% Knn classifiers
for n = 0:0.05:2
    [e_pixel(i), std_pixel(i)] = prcrossval(img_data,parzenc([],n),10,10);
    i = i + 1;
end
figure
plot(e_pixel)
xlabel('h'), ylabel('error rate')
title('Pixel')

%%%%%% im_features: Different Classifiers %%%%%%
e_im_features = [];
std_im_features = [];
i = 1;
% Knn classifiers
for n = 0:0.05:2
    [e_im_features(i), std_im_features(i)] = prcrossval(img_feat,parzenc([],n),10,10);
    i = i + 1;
end
figure
plot(e_im_features)
xlabel('h'), ylabel('Error Rate')
title('Feature(im\_feature)')

%%%%%% Dissimilarity(Euclidean): Different Classifiers %%%%%%
e_distance = [];
std_distance = [];
i = 1;
% Knn classifiers
for n = 0:0.05:2
    [e_distance(i), std_distance(i)] = prcrossval(img_Euclidean,parzenc([],n),10,10);
    i = i + 1;
end
figure
plot(e_distance)
xlabel('h'), ylabel('Error Rate')
title('Dissimilarity(Euclidean)')