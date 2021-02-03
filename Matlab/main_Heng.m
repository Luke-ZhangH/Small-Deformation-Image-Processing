clc;
clear;
%% 视频帧提取出超声加载前后的图像并显示
obj = VideoReader('C:\Users\98370\Dropbox\毕业设计-超声驻波场作用下材料微变形测量方法的研究\20210113材料变形视频\210113164255.mp4');
numFrames = obj.NumberOfFrames;% 帧的总数
Without_Ultrasound_0 = read(obj,10);%选择未加超声的帧
With_Ultrasound_0 = read(obj,180);%选择加载超声的帧
Without_Ultrasound = rgb2gray(Without_Ultrasound_0);
With_Ultrasound = rgb2gray(With_Ultrasound_0);%转换为灰度图像
figure
imshow(Without_Ultrasound);title('静止状态');
figure
imshow(With_Ultrasound);title('加超声后');
%% 图像滤除噪声
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
%% 提取局部图像
P1 = imcrop(A_lownoise,[1400 330 500 500]);%这里中括号[a b c d]里的a,b表示剪切的xy起点，以上面为基础，c,d为剪切xy的大小（横x竖y）
P2 = imcrop(B_lownoise,[1400 330 500 500]);
figure
subplot(121);imshow(P1);title('未加超声');
subplot(122);imshow(P2);title('加超声后');
%% 改善图像对比度
figure
imhist(P1);% Histogram of image data
figure
imhist(P2);%查看图像像素强度值的分布
%%由直方图可以观察到两张图像的强度值范围很窄，并未覆盖[0，255]的所有范围，缺少具有良好对比度效果的的高值和低值。
Without_Ultrasound_1 = imadjust(P1);
figure
imshow(Without_Ultrasound_1)
With_Ultrasound_1 = imadjust(P2);%将灰度图像 I 中的强度值映射到 J 中的新值。默认情况下，imadjust 对所有像素值中最低的 1% 和最高的 1% 进行饱和处理。此运算可提高输出图像 J 的对比度。
figure
imshow(With_Ultrasound_1)%histeq可以使用直方图均衡增强对比度
%%将改善对比度后的图像保存到本地
imwrite(Without_Ultrasound_1, 'crop_Without_Ultrasound.png');
imwrite(With_Ultrasound_1, 'crop_With_Ultrasound.png');

%% 边缘检测
%Laplacian of Gaussian（LoG检测器）标准差为7.闭合曲线检测，
BW1 = edge(Without_Ultrasound_1, 'log', 0, 7);
BW2 = edge(With_Ultrasound_1, 'log', 0, 7);

BWi_1 = imcomplement(BW1);

% [r,c] = size(BWi_1); 将二值图像的黑色边缘检测结果转换为RGB图像的红色边缘，利于观察
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
subplot(121); imshow(BW_1); title("未加超声");
subplot(122); imshow(BW_2); title("加上超声");
imwrite(BW_1, '未加超声边缘检测（LoG）.png');
imwrite(BW_2, '加上超声边缘检测（LoG）.png');

%canny边缘检测器
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
subplot(121); imshow(BW_3); title("未加超声");
subplot(122); imshow(BW_4); title("加上超声");
imwrite(BW_3, '未加超声边缘检测（LoG）.png');
imwrite(BW_4, '加上超声边缘检测（LoG）.png');

