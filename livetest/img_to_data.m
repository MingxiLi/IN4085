function dataset = img_to_data(a)
img=rgb2gray(a);
new_i_s = ~segmentation(img);     % image segmentation
figure
imshow(new_i_s)
[l,m]=bwlabel(new_i_s,8);
status1=regionprops(l,'BoundingBox');

[mnew_i_s,nnew_i_s] = size(new_i_s);
target_img1=zeros(mnew_i_s,nnew_i_s,m);
vir_r=0;        % target number
target=zeros(); 
for i=1:m
    x_y_l_w_0=status1(i).BoundingBox;
    if((x_y_l_w_0(3)<=22)&&(x_y_l_w_0(4)<=22))      % if the target size is not satisfied
        new_i_s(find(l==i))=0;
    else
        rectangle('position',status1(i).BoundingBox,'edgecolor','r');       % mark target zone
        vir_r=vir_r+1;
        bw=zeros(mnew_i_s,nnew_i_s);        
        bw(find(l==i))=255;     % show taget zone
        target_img1(1:size(bw,1),1:size(bw,2),vir_r)=bw;    
        target(vir_r)=i;        
    end
end

dataset=zeros(vir_r, 256);
for i=1:vir_r
    bw=target_img1(:,:,i);
    [l2,m2]=bwlabel(bw,8);      
    status=regionprops(l2,'BoundingBox');
    x_y_l_w=status.BoundingBox;    
    bw1=imcrop(bw,[x_y_l_w(1)-10 x_y_l_w(2)-10 x_y_l_w(3)+20 x_y_l_w(4)+20]); 
    bw1 = preproc(bw1);
    if(rem(i, 10) == 0)
        figure
        imshow(bw1)
    end
    for m = 1: 16
        for n = 1: 16
            dataset(i, (m - 1) * 16 + n) = img(m, n);
        end
    end
end
end
