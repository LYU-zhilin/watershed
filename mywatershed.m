function water_line=mywatershed(img)
%% 分水岭算法
% img 梯度图像 最大梯度<255
% water_line 输出的分水岭图像  分水岭值为threshold  其余为0

threshold=255;  


img_min=min(min(img));
img_max=max(max(img));
C=zeros(size(img));
C1=zeros(size(img));
water_line=zeros(size(img));

for mm=1:img_max-img_min+1   
    
%% 获取两幅二值图像进行比较
[indexx indexy]=find(img<img_min+mm);  
for j=1:length(indexx)
    C(indexx(j),indexy(j))=1;
end
[Label num]=bwlabel(C,8);

[indexx indexy]=find(img<img_min+mm+1);
for j=1:length(indexx)
    C1(indexx(j),indexy(j))=1;
end
[Label1 num1]=bwlabel(C1,8);

if num==num1
    continue
end
for i=1:num
    subimg(:,:,i)=(Label==i);
end
for i=1:num1
    subimg1(:,:,i)=(Label1==i);
end


%% 检测两幅图像之间的包含关系，分割连通区域，建立分水岭
include_img=zeros(1,num1);

% new_basin=zeros(size(img));
sub_img_before=zeros([size(img) num1]);
for k=1:num
    for kk=1:num1
        is_equ=isequal(subimg(:,:,k)&subimg1(:,:,kk),subimg(:,:,k));
        if is_equ
            include_img(kk)=include_img(kk)+1;
            sub_img_before(:,:,kk)=sub_img_before(:,:,kk)+subimg(:,:,k);
            break
        end
%         if is_equ==0 & kk==num1
%             new_basin=new_basin+subimg(:,:,k)
%         end
    end
end

for m=1:num1
    if include_img(m)>1
        [Label_exam num_exam]=bwlabel(sub_img_before(:,:,m),8);
        water_line=water_line+sepcor(Label_exam,subimg1(:,:,m),threshold);  %sepcor 特殊膨胀函数
    end
end

img_add_temp=(water_line~=0);
img_add_temp=uint8(~img_add_temp);
img=img.*img_add_temp+uint8(water_line);
end


