function segnew_i=segmentation(seg_i)

% 设置初始阈值，去最大值和最小值的中间值  
zmax=max(max(seg_i));  
zmin=min(min(seg_i));  
tk=(zmax+zmin)/2;

% 根据阈值将图像进行分割为前景和背景，分别求出两者的平均灰度
b=1;  
[m n]=size(seg_i);  
while (b)  
        ifg=0;  
        ibg=0;  
        fnum=0;  
        bnum=0;  
        for i=1:m  
            for j=1:n  
                tmp=seg_i(i,j);  
                if(tmp>=tk)  
                    ifg=ifg+1;  
                    fnum=fnum+double(tmp);      % 前景像素的个数以及像素值的总和  
                else  
                    ibg=ibg+1;  
                    bnum=bnum+double(tmp);      % 背景像素的个数以及像素值的总和  
                end  
            end  
        end  
        % 计算前景和背景的平均值  
        zo=fnum/ifg;  
        zb=bnum/ibg;  
        if(tk==(uint8((zo+zb)/2)))      % 当阈值不变换时，退出迭代  
            b=0;  
        else  
            tk=uint8((zo+zb)/2);        % 否则的话改变阈值
        end  
end   
segnew_i=im2bw(seg_i,double(tk)/255);   % 二值化图像