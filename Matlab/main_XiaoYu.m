clc;
clear;
%% ��Ƶ֡����ȡ
obj = VideoReader('D:\Desktop\0��Ŀ\פ��ǻ\��ҵ���\��ҵ����\������\ʵ������\20210118�α�ʵ��\210118105058\210118105058.mp4');
numFrames = obj.NumberOfFrames;% ֡������
Ultra_former = read(obj,10);
% imwrite(Ultra_former,strcat('D:\Desktop\0��Ŀ\פ��ǻ\��ҵ���\��ҵ����\������\ʵ������\20210118�α�ʵ��\210118105058\Ultra_former.jpg'),'jpg');
Ultra_after = read(obj,180);
% imwrite(Ultra_after,strcat('D:\Desktop\0��Ŀ\פ��ǻ\��ҵ���\��ҵ����\������\ʵ������\20210118�α�ʵ��\210118105058\Ultra_after.jpg'),'jpg');
figure
imshow(Ultra_former);title('Uǰ');
figure
imshow(Ultra_after);title('U��');
%% 1.��ȡ�ֲ�ͼ��
P10 = imcrop(Ultra_former,[1500 500 200 200]);%����������[a b c d]���a,b��ʾ���е�xy��㣬������Ϊ������c,dΪ����xy�Ĵ�С����x��y��
P11 = imcrop(Ultra_after,[1500 500 200 200]);
figure
subplot(121);imshow(P10);title('ԭ-Uǰ');
subplot(122);imshow(P11);title('ԭ-U��');
%% 2.תΪ�Ҷ�ͼ��
P20=rgb2gray(P10);
P21=rgb2gray(P11);
%% 3.ͼ���˲�
P30=medfilt2(P20,[9,9]);%������ֵ�˲�;
P31=medfilt2(P21,[9,9]);%������ֵ�˲�;
figure
subplot(121);imshow(P30);title('�˲�-Uǰ');
subplot(122);imshow(P31);title('�˲�-U��');
%% 4.�˲����ͼ���ֵ��
% �Ҷ�����
% G30 = P30(:,65);%��һ�е���������
% G31 = P31(:,65);%��һ�е���������
% G32=G31-G30;
% figure
% subplot(311);plot(G30,'-');%����ͼ������
% subplot(312);plot(G31,'-');%����ͼ������
% subplot(313);plot(G32,'-');%����ͼ������
% ��ֵ��
thresh40 = 130/256;%ȷ����ֵ����ֵ
P40 = im2bw(P30,thresh40);%��ͼ���ֵ��
thresh41 = 130/256;%ȷ����ֵ����ֵ
P41 = im2bw(P31,thresh41);%��ͼ���ֵ��
figure
subplot(121);imshow(P40);title('��ֵ��-Uǰ');
subplot(122);imshow(P41);title('��ֵ��-U��');
%% 5.�����㷨 

str50=strel('disk',4);
P50=imdilate(P40,str50);%ͼ������
% str60=strel('disk',2);
% P60=imerode(P40,str60);%ͼ��ʴ
% P70=xor(P40,P60);%���
% P70=P40&P50;%��
figure
% subplot(221);imshow(P40);title('ԭͼ');
subplot(222);imshow(P50);title('����');
% subplot(223);imshow(P60);title('��ʴ');
% subplot(224);imshow(P70);title('���ͺ���ԭͼ���');
%�ȱ����� �ٿ�����
% se=strel('disk',5);
% P50 = imclose(P40,se);
% P50 = imopen(P50,se);
% figure
% subplot(121);imshow(P40);title('��ֵ��-Uǰ');
% subplot(122);imshow(P50);title('��ֵ��-U��');