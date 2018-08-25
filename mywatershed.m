function water_line=mywatershed(img)
%% ��ˮ���㷨
% img �ݶ�ͼ�� ����ݶ�<255
% water_line ����ķ�ˮ��ͼ��  ��ˮ��ֵΪthreshold  ����Ϊ0

threshold=255;  


img_min=min(min(img));
img_max=max(max(img));
C=zeros(size(img));
C1=zeros(size(img));
water_line=zeros(size(img));

for mm=1:img_max-img_min+1   
    
%% ��ȡ������ֵͼ����бȽ�
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


%% �������ͼ��֮��İ�����ϵ���ָ���ͨ���򣬽�����ˮ��
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
        water_line=water_line+sepcor(Label_exam,subimg1(:,:,m),threshold);  %sepcor �������ͺ���
    end
end

img_add_temp=(water_line~=0);
img_add_temp=uint8(~img_add_temp);
img=img.*img_add_temp+uint8(water_line);
end

