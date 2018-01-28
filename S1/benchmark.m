%%%%%% Benchmark %%%%%%

close all
clc

img = prnist([0:9],[1:2:1000]);
a = my_rep(img);
w_parzen = pcam(img_data,34) * parzenc([], 0.25);
w_KNN = pcam(img_data,30) * knnc([], 1);
w_combine = [w_parzen, w_KNN];
w_c = a * w_combine * maxc;
w_p = a * w_parzen;
w_k = a * w_KNN;
e_combine = nist_eval('my_rep', w_c)
e_parzen = nist_eval('my_rep', w_p)
e_KNN = nist_eval('my_rep', w_k)
