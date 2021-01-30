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
P1 = imcrop(Without_Ultrasound,[1400 330 500 500]);%����������[a b c d]���a,b��ʾ���е�xy��㣬������Ϊ������c,dΪ����xy�Ĵ�С����x��y��
P2 = imcrop(With_Ultrasound,[1400 330 500 500]);
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
BW = edge(Without_Ultrasound_1);
figure
imshow(BW)
