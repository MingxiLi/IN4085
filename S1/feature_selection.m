%%%%%% How to select features %%%%%%

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

% Classifiers
w = svc(proxm('e'));

featnum = [1:1:24];
mf = max(featnum);
[trn, tst] = gendat(img_feat, 0.2);

e0 = clevalf(trn,w,featnum,[],1,tst);
rp = randperm(size(img_feat,2));
er = clevalf(trn(:,rp),w,featnum,[],1,tst(:,rp));

[w_i,r_i] = featseli(trn,'eucl-m',mf);
e_i = clevalf(trn*w_i,w,featnum,[],1,tst*w_i);
[w_f,r_f] = featself(trn,'eucl-m',mf);
e_f = clevalf(trn*w_f,w,featnum,[],1,tst*w_f);
[w_b,r_b] = featselb(trn,'eucl-m',mf);
e_b = clevalf(trn*w_b,w,featnum,[],1,tst*w_b);

figure
plote({e_i,e_f,e_b})
legend({'individual_train','individual_test', 'forward_train' , 'forward_test','backward_train' , 'backward_test'})