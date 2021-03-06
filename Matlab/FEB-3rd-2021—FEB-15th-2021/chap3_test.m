clc;
clear;
%% 提取图像 对数变换压缩动态范围
crop_With_Ultrasound_0 = imread('./crop_With_Ultrasound.png');

crop_Without_Ultrasound_0 = imread('crop_Without_Ultrasound.png');
g_neg = intrans(crop_Without_Ultrasound_0, 'neg'); %负片
g_log = intrans(crop_Without_Ultrasound_0, 'log'); %对数变换
g_gamma = intrans(crop_Without_Ultrasound_0, 'gamma', 1); %gamma 变换
g_stretch = intrans(crop_Without_Ultrasound_0, 'stretch', mean2(im2double(crop_Without_Ultrasound_0)), 0.8); %对比度变换
figure
subplot(121); imshow(g_neg)
subplot(122); imshow(g_log)
figure
subplot(121); imshow(g_gamma)
subplot(122); imshow(g_stretch)
%% 线性空间滤波器拉普拉斯滤波器的比较
w4 = fspecial('laplacian', 0);
w8 = [1 1 1; 1 -8 1; 1 1 1];
g4 = g_log - imfilter(g_log, w4, 'replicate');
g8 = g_log - imfilter(g_log, w8, 'replicate');
figure
subplot(121), imshow(g4)
subplot(122), imshow(g8)
%% 非线性空间滤波器（统计排序滤波器）有效滤除椒盐噪声 中值滤波器的比较
gm = medfilt2(g_log, 'symmetric');
figure, imshow(gm)


