close all;
clear all;
I=imread('original.bmp');
subplot(211);
imshow(I);
title('original');
noise=imnoise(I,'salt & pepper',0.04); %���뽷������
subplot(212);
imshow(noise); %%���뽷����������ʾͼ��
title('salt & pepper noise');
imwrite(noise,'noise.bmp');