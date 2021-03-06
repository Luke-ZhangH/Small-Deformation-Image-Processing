f1 = imread('./crop_Without_Ultrasound.png');
f2 = imread('./crop_With_Ultrasound.png');
figure; subplot(121); imshow(f1); subplot(122); imshow(f2);
h = imhist(f1);
figure; plot(h);
S = 117;
N = 5;
[g, NR, SI, TI] = regiongrow(f1, S, N);
% figure; imshow(g);
% figure; imshow(NR);
% figure; imshow(SI);
figure; imshow(TI);

splitmerge_g = splitmerge(f1, 1024, @predicate);
figure; imshow(splitmerge_g);