%% �������� �����Ĵξ��� û�б�֤������������������1��ʼ�������У�����Ҳ����Ҫ��ͳһת��Ϊuint16�Ϳ���
%img ����ͼ��  ֻ���ܶ�ֵ
% result ���������  double
%num ��ͨ������
function [result num]=regrow(img)
img=uint8(img);
sz=size(img);
img_temp=zeros(sz(1)+2,sz(2)+2);
img_temp(2:end-1,2:end-1)=img;
img=img_temp;
sz=size(img);

k=2;
for i=2:sz(1)-1
    for j=2:sz(2)-1
        if img(i,j)~=0
            if max([img(i-1,j-1) img(i-1,j) img(i-1,j+1) img(i,j) img(i,j-1) img(i,j+1) img(i+1,j-1) img(i+1,j) img(i+1,j+1)])==1
               img(i,j)=k;
               k=k+1;
            else
                img(i,j)=max([img(i-1,j-1) img(i-1,j) img(i-1,j+1) img(i,j) img(i,j-1) img(i,j+1) img(i+1,j-1) img(i+1,j) img(i+1,j+1)]);
            end
        end
    end
end

for i=sz(1)-1:-1:2
    for j=sz(2)-1:-1:2
        if img(i,j)~=0
                img(i,j)=max([img(i-1,j-1) img(i-1,j) img(i-1,j+1) img(i,j) img(i,j-1) img(i,j+1) img(i+1,j-1) img(i+1,j) img(i+1,j+1)]);
        end
    end
end

for i=2:sz(1)-1
    for j=2:sz(2)-1
        if img(i,j)~=0
                img(i,j)=max([img(i-1,j-1) img(i-1,j) img(i-1,j+1) img(i,j) img(i,j-1) img(i,j+1) img(i+1,j-1) img(i+1,j) img(i+1,j+1)]);
        end
    end
end

for i=sz(1)-1:-1:2
    for j=sz(2)-1:-1:2
        if img(i,j)~=0      
                img(i,j)=max([img(i-1,j-1) img(i-1,j) img(i-1,j+1) img(i,j) img(i,j-1) img(i,j+1) img(i+1,j-1) img(i+1,j) img(i+1,j+1)]);
        end
    end
end


result=img(2:end-1,2:end-1);
num=length(unique(result))-1;