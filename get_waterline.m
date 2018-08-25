%%% ��ȡ��ˮ�룬����ʱ��ϳ�
clear;clc;close all;


img=imread('gecko.bmp');


img_gray=myrgb2gray(img);
img_gray__=img_gray;

%% ���ݶ�
img_gray_=double(img_gray);
[GX,GY]=mygradient(img_gray_);  
img_grad=sqrt(GX.*GX+GY.*GY);                
% img_grad=uint8(img_grad);
% imshow(img_grad)
%% ����Ԥ����  ƽ��  ��ʴ����
img_blur=myblur(img_grad);
img_blur=uint8(img_blur);

%% ��ʴ����
se = strel('disk',2);
Ie = imerode(img_gray, se);
Iobr = imreconstruct(Ie, img_gray);
Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
bw = im2bw(Iobrcbr, graythresh(Iobrcbr));
D = bwdist(bw);
D=uint8(D);
% imshow(D,[])
%% ��ȡ��ˮ�� ������  ����ʱ��ϳ�
water_line=mywatershed(D);
water_line=(water_line~=0);
save('water_line.mat','water_line')

% water_line__=watershed(D);           %��ϵͳ�����Ա�
% water_line_=(water_line__==0)
% imshow(water_line_,[])



