clc;
clear;
%% 视频帧的提取
obj = VideoReader('D:\Desktop\0项目\驻波腔\毕业相关\毕业论文\大论文\实验数据\20210118形变实验\210118105058\210118105058.mp4');
numFrames = obj.NumberOfFrames;% 帧的总数
Ultra_former = read(obj,10);
% imwrite(Ultra_former,strcat('D:\Desktop\0项目\驻波腔\毕业相关\毕业论文\大论文\实验数据\20210118形变实验\210118105058\Ultra_former.jpg'),'jpg');
Ultra_after = read(obj,180);
% imwrite(Ultra_after,strcat('D:\Desktop\0项目\驻波腔\毕业相关\毕业论文\大论文\实验数据\20210118形变实验\210118105058\Ultra_after.jpg'),'jpg');
figure
imshow(Ultra_former);title('U前');
figure
imshow(Ultra_after);title('U后');
%% 1.提取局部图像
P10 = imcrop(Ultra_former,[1500 500 200 200]);%这里中括号[a b c d]里的a,b表示剪切的xy起点，以上面为基础，c,d为剪切xy的大小（横x竖y）
P11 = imcrop(Ultra_after,[1500 500 200 200]);
figure
subplot(121);imshow(P10);title('原-U前');
subplot(122);imshow(P11);title('原-U后');
%% 2.转为灰度图像
P20=rgb2gray(P10);
P21=rgb2gray(P11);
%% 3.图像滤波
P30=medfilt2(P20,[9,9]);%进行中值滤波;
P31=medfilt2(P21,[9,9]);%进行中值滤波;
figure
subplot(121);imshow(P30);title('滤波-U前');
subplot(122);imshow(P31);title('滤波-U后');
%% 4.滤波后的图像二值化
% 灰度曲线
% G30 = P30(:,65);%第一列的所有数据
% G31 = P31(:,65);%第一列的所有数据
% G32=G31-G30;
% figure
% subplot(311);plot(G30,'-');%画出图像数据
% subplot(312);plot(G31,'-');%画出图像数据
% subplot(313);plot(G32,'-');%画出图像数据
% 二值化
thresh40 = 130/256;%确定二值化阈值
P40 = im2bw(P30,thresh40);%对图像二值化
thresh41 = 130/256;%确定二值化阈值
P41 = im2bw(P31,thresh41);%对图像二值化
figure
subplot(121);imshow(P40);title('二值化-U前');
subplot(122);imshow(P41);title('二值化-U后');
%% 5.膨胀算法 

str50=strel('disk',4);
P50=imdilate(P40,str50);%图像膨胀
% str60=strel('disk',2);
% P60=imerode(P40,str60);%图像腐蚀
% P70=xor(P40,P60);%异或
% P70=P40&P50;%与
figure
% subplot(221);imshow(P40);title('原图');
subplot(222);imshow(P50);title('膨胀');
% subplot(223);imshow(P60);title('腐蚀');
% subplot(224);imshow(P70);title('膨胀后与原图异或');
%先闭运算 再开运算
% se=strel('disk',5);
% P50 = imclose(P40,se);
% P50 = imopen(P50,se);
% figure
% subplot(121);imshow(P40);title('二值化-U前');
% subplot(122);imshow(P50);title('二值化-U后');