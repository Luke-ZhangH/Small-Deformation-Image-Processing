clc;
clear;
%% ��ȡͼ�� �����任ѹ����̬��Χ
crop_With_Ultrasound_0 = imread('./crop_With_Ultrasound.png');

crop_Without_Ultrasound_0 = imread('crop_Without_Ultrasound.png');
g_neg = intrans(crop_Without_Ultrasound_0, 'neg'); %��Ƭ
g_log = intrans(crop_Without_Ultrasound_0, 'log'); %�����任
g_gamma = intrans(crop_Without_Ultrasound_0, 'gamma', 1); %gamma �任
g_stretch = intrans(crop_Without_Ultrasound_0, 'stretch', mean2(im2double(crop_Without_Ultrasound_0)), 0.8); %�Աȶȱ任
figure
subplot(121); imshow(g_neg)
subplot(122); imshow(g_log)
figure
subplot(121); imshow(g_gamma)
subplot(122); imshow(g_stretch)
%% ���Կռ��˲���������˹�˲����ıȽ�
w4 = fspecial('laplacian', 0);
w8 = [1 1 1; 1 -8 1; 1 1 1];
g4 = g_log - imfilter(g_log, w4, 'replicate');
g8 = g_log - imfilter(g_log, w8, 'replicate');
figure
subplot(121), imshow(g4)
subplot(122), imshow(g8)
%% �����Կռ��˲�����ͳ�������˲�������Ч�˳��������� ��ֵ�˲����ıȽ�
gm = medfilt2(g_log, 'symmetric');
figure, imshow(gm)


