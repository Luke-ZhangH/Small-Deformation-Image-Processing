clc;
clear;
%% ��Ƶ֡��ȡ����������ǰ���ͼ����ʾ
obj = VideoReader('C:\Users\98370\Dropbox\��ҵ���-����פ���������²���΢���β����������о�\20210113���ϱ�����Ƶ\210113164255.mp4');
numFrames = obj.NumberOfFrames;% ֡������
Without_Ultrasound_0 = read(obj,10);%ѡ��δ�ӳ�����֡
With_Ultrasound_0 = read(obj,180);%ѡ����س�����֡
Without_Ultrasound = rgb2gray(Without_Ultrasound_0);
With_Ultrasound = rgb2gray(With_Ultrasound_0);%ת��Ϊ�Ҷ�ͼ��
figure
imshow(Without_Ultrasound);title('��ֹ״̬');
figure
imshow(With_Ultrasound);title('�ӳ�����');
%% ͼ���˳�����
AInv = imcomplement(Without_Ultrasound);
%figure, imshow(AInv);
BInv = imreducehaze(AInv);
%figure, imshow(BInv);
A = imcomplement(BInv);
A_lownoise = imguidedfilter(A);
figure, montage({Without_Ultrasound, A_lownoise});

CInv = imcomplement(With_Ultrasound);
%figure, imshow(AInv);
DInv = imreducehaze(CInv);
%figure, imshow(BInv);
B = imcomplement(DInv);
B_lownoise = imguidedfilter(B);
figure, montage({With_Ultrasound, B_lownoise});
%% ��ȡ�ֲ�ͼ��
P1 = imcrop(A_lownoise,[1400 330 500 500]);%����������[a b c d]���a,b��ʾ���е�xy��㣬������Ϊ������c,dΪ����xy�Ĵ�С����x��y��
P2 = imcrop(B_lownoise,[1400 330 500 500]);
figure
subplot(121);imshow(P1);title('δ�ӳ���');
subplot(122);imshow(P2);title('�ӳ�����');
%% ����ͼ��Աȶ�
figure
imhist(P1);% Histogram of image data
figure
imhist(P2);%�鿴ͼ������ǿ��ֵ�ķֲ�
%%��ֱ��ͼ���Թ۲쵽����ͼ���ǿ��ֵ��Χ��խ����δ����[0��255]�����з�Χ��ȱ�پ������öԱȶ�Ч���ĵĸ�ֵ�͵�ֵ��
Without_Ultrasound_1 = imadjust(P1);
figure
imshow(Without_Ultrasound_1)
With_Ultrasound_1 = imadjust(P2);%���Ҷ�ͼ�� I �е�ǿ��ֵӳ�䵽 J �е���ֵ��Ĭ������£�imadjust ����������ֵ����͵� 1% ����ߵ� 1% ���б��ʹ����������������ͼ�� J �ĶԱȶȡ�
figure
imshow(With_Ultrasound_1)%histeq����ʹ��ֱ��ͼ������ǿ�Աȶ�
%%�����ƶԱȶȺ��ͼ�񱣴浽����
imwrite(Without_Ultrasound_1, 'crop_Without_Ultrasound.png');
imwrite(With_Ultrasound_1, 'crop_With_Ultrasound.png');

%% ��Ե���
%Laplacian of Gaussian��LoG���������׼��Ϊ7.�պ����߼�⣬
BW1 = edge(Without_Ultrasound_1, 'log', 0, 7);
BW2 = edge(With_Ultrasound_1, 'log', 0, 7);

BWi_1 = imcomplement(BW1);

% [r,c] = size(BWi_1); ����ֵͼ��ĺ�ɫ��Ե�����ת��ΪRGBͼ��ĺ�ɫ��Ե�����ڹ۲�
% image = ones(r,c,3);
% for i = 1:r
%     for j = 1:c
%         if BWi_1(i,j) == 0
%             image(i,j,1) = 255;
%             image(i,j,2) = 0;
%             image(i,j,3) = 0;
%         end
%     end
% end
% imshow(image);

BW_UINT8_1 = im2uint8(BWi_1)./4;
BW_Last_1 = imadd(BW_UINT8_1, Without_Ultrasound_1);
BW_1 = imadjust(BW_Last_1);

BWi_2 = imcomplement(BW2);
BW_UINT8_2 = im2uint8(BWi_2)./4;
BW_Last_2 = imadd(BW_UINT8_2, With_Ultrasound_1);
BW_2 = imadjust(BW_Last_2);

figure
subplot(121); imshow(BW_1); title("δ�ӳ���");
subplot(122); imshow(BW_2); title("���ϳ���");
imwrite(BW_1, 'δ�ӳ�����Ե��⣨LoG��.png');
imwrite(BW_2, '���ϳ�����Ե��⣨LoG��.png');

%canny��Ե�����
BW3 = edge(Without_Ultrasound_1, 'canny', 0, 6.5);
BW4 = edge(With_Ultrasound_1, 'canny', 0, 6.5);

BWi_3 = imcomplement(BW3);
BW_UINT8_3 = im2uint8(BWi_3)./4;
BW_Last_3 = imadd(BW_UINT8_3, Without_Ultrasound_1);
BW_3 = imadjust(BW_Last_3);

BWi_4 = imcomplement(BW4);
BW_UINT8_4 = im2uint8(BWi_4)./4;
BW_Last_4 = imadd(BW_UINT8_4, With_Ultrasound_1);
BW_4 = imadjust(BW_Last_4);

figure
subplot(121); imshow(BW_3); title("δ�ӳ���");
subplot(122); imshow(BW_4); title("���ϳ���");
imwrite(BW_3, 'δ�ӳ�����Ե��⣨LoG��.png');
imwrite(BW_4, '���ϳ�����Ե��⣨LoG��.png');

