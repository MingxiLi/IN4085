function liveset =  img_to_pr(a) 

dataset = zeros(100, 256);

img_0 = imcrop(a, [10, 10, 810, 90]);
dataset(1:10,:) = img_to_data(img_0);
%figure
%imshow(img_0)

img_1 = imcrop(a, [10, 90, 810, 70]);
dataset(11:20,:) = img_to_data(img_1);
%figure
%imshow(img_1)

img_2 = imcrop(a, [10, 160, 810, 70]);
dataset(21:30,:) = img_to_data(img_2);
%figure
%imshow(img_2)

img_3 = imcrop(a, [10, 230, 810, 70]);
dataset(31:40,:) = img_to_data(img_3);
%figure
%imshow(img_3)

img_4 = imcrop(a, [10, 300, 810, 85]);
dataset(41:50,:) = img_to_data(img_4);
%figure
%imshow(img_4)

img_5 = imcrop(a, [10, 395, 810, 85]);
dataset(51:60,:) = img_to_data(img_5);
%figure
%imshow(img_5)

img_6 = imcrop(a, [10, 480, 810, 85]);
dataset(61:70,:) = img_to_data(img_6);
%figure
%imshow(img_6)

img_7 = imcrop(a, [10, 570, 810, 85]);
dataset(71:80,:) = img_to_data(img_7);
%figure
%imshow(img_7)

img_8 = imcrop(a, [10, 676, 810, 85]);
dataset(81:90,:) = img_to_data(img_8);
%figure
%imshow(img_8)

img_9 = imcrop(a, [10, 780, 810, 85]);
dataset(91:100,:) = img_to_data(img_9);
%figure
%imshow(img_9)

labs = genlab([10 10 10 10 10 10 10 10 10 10],['digit_0'; 'digit_1'; 'digit_2'; 'digit_3'; 'digit_4'; 'digit_5'; 'digit_6'; 'digit_7'; 'digit_8'; 'digit_9']); 
liveset = prdataset(dataset, labs)

end