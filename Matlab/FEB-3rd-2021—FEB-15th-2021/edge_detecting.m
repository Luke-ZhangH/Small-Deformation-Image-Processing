clc;
clear;
%% ��ȡͼ��
With_Ultrasound_origin1 = imread('./With_Ultrasound.png');
With_Ultrasound = rgb2gray(With_Ultrasound_origin1);
Without_Ultrasound_origin2 = imread('./Without_Ultrasound.png');
Without_Ultrasound = rgb2gray(Without_Ultrasound_origin2);
crop_With_Ultrasound = imread('./crop_With_Ultrasound.png');
crop_Without_Ultrasound = imread('crop_Without_Ultrasound.png');
%�Ľ����������޸ĶԱȶȺ��ԭʼ��Сͼ���ϻ��Ƴ�cropͼ���λ�ÿ򣬱���ֱ���˽��о��ĸ���Ȥλ��
figure 
subplot(221); imshow(Without_Ultrasound); title('Without_Ultrasound');
subplot(222); imshow(With_Ultrasound); title('With_Ultrasound');
subplot(223); imshow(crop_With_Ultrasound); title('crop_With_Ultrasound');
subplot(224); imshow(crop_Without_Ultrasound); title('crop_Without_Ultrasound');

%% ��Ե���
%Laplacian of Gaussian��LoG���������׼��Ϊ7.�պ����߼�⣬
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
subplot(121); imshow(BW_1); title("δ�ӳ���");
subplot(122); imshow(BW_2); title("���ϳ���");
% imwrite(BW_1, 'δ�ӳ�����Ե��⣨LoG��.png');
% imwrite(BW_2, '���ϳ�����Ե��⣨LoG��.png');

%canny��Ե�����
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
subplot(121); imshow(BW_3); title("δ�ӳ���");
subplot(122); imshow(BW_4); title("���ϳ���");
% imwrite(BW_3, 'δ�ӳ�����Ե��⣨LoG��.png');
% imwrite(BW_4, '���ϳ�����Ե��⣨LoG��.png');

