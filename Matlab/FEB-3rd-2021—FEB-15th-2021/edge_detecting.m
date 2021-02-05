clc;
clear;
%% 提取图像
With_Ultrasound_origin1 = imread('./With_Ultrasound.png');
With_Ultrasound = rgb2gray(With_Ultrasound_origin1);
Without_Ultrasound_origin2 = imread('./Without_Ultrasound.png');
Without_Ultrasound = rgb2gray(Without_Ultrasound_origin2);
crop_With_Ultrasound = imread('./crop_With_Ultrasound.png');
crop_Without_Ultrasound = imread('crop_Without_Ultrasound.png');
%改进：可以在修改对比度后的原始大小图像上绘制出crop图像的位置框，便于直观了解研究的感兴趣位置
figure 
subplot(221); imshow(Without_Ultrasound); title('Without_Ultrasound');
subplot(222); imshow(With_Ultrasound); title('With_Ultrasound');
subplot(223); imshow(crop_With_Ultrasound); title('crop_With_Ultrasound');
subplot(224); imshow(crop_Without_Ultrasound); title('crop_Without_Ultrasound');

%% 边缘检测
%Laplacian of Gaussian（LoG检测器）标准差为7.闭合曲线检测，
BW1 = edge(Without_Ultrasound, 'log', 0, 7);
BW2 = edge(With_Ultrasound, 'log', 0, 7);

BWi_1 = imcomplement(BW1);
BW_UINT8_1 = im2uint8(BWi_1)./4;
BW_Last_1 = imadd(BW_UINT8_1, Without_Ultrasound);
BW_1 = imadjust(BW_Last_1);

BWi_2 = imcomplement(BW2);
BW_UINT8_2 = im2uint8(BWi_2)./4;
BW_Last_2 = imadd(BW_UINT8_2, With_Ultrasound);
BW_2 = imadjust(BW_Last_2);

figure
subplot(121); imshow(BW_1); title("未加超声");
subplot(122); imshow(BW_2); title("加上超声");
% imwrite(BW_1, '未加超声边缘检测（LoG）.png');
% imwrite(BW_2, '加上超声边缘检测（LoG）.png');

%canny边缘检测器
BW3 = edge(Without_Ultrasound, 'canny', 0, 6.5);
BW4 = edge(With_Ultrasound, 'canny', 0, 6.5);

BWi_3 = imcomplement(BW3);
BW_UINT8_3 = im2uint8(BWi_3)./4;
BW_Last_3 = imadd(BW_UINT8_3, Without_Ultrasound);
BW_3 = imadjust(BW_Last_3);

BWi_4 = imcomplement(BW4);
BW_UINT8_4 = im2uint8(BWi_4)./4;
BW_Last_4 = imadd(BW_UINT8_4, With_Ultrasound);
BW_4 = imadjust(BW_Last_4);

figure
subplot(121); imshow(BW_3); title("未加超声");
subplot(122); imshow(BW_4); title("加上超声");
% imwrite(BW_3, '未加超声边缘检测（LoG）.png');
% imwrite(BW_4, '加上超声边缘检测（LoG）.png');

