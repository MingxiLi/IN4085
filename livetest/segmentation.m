function segnew_i=segmentation(seg_i)

% ���ó�ʼ��ֵ��ȥ���ֵ����Сֵ���м�ֵ  
zmax=max(max(seg_i));  
zmin=min(min(seg_i));  
tk=(zmax+zmin)/2;

% ������ֵ��ͼ����зָ�Ϊǰ���ͱ������ֱ�������ߵ�ƽ���Ҷ�
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
                    fnum=fnum+double(tmp);      % ǰ�����صĸ����Լ�����ֵ���ܺ�  
                else  
                    ibg=ibg+1;  
                    bnum=bnum+double(tmp);      % �������صĸ����Լ�����ֵ���ܺ�  
                end  
            end  
        end  
        % ����ǰ���ͱ�����ƽ��ֵ  
        zo=fnum/ifg;  
        zb=bnum/ibg;  
        if(tk==(uint8((zo+zb)/2)))      % ����ֵ���任ʱ���˳�����  
            b=0;  
        else  
            tk=uint8((zo+zb)/2);        % ����Ļ��ı���ֵ
        end  
end   
segnew_i=im2bw(seg_i,double(tk)/255);   % ��ֵ��ͼ��