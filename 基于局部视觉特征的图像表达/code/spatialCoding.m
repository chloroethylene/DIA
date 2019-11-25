%% Display SIFT features of two images
clear; 
close all;
clc;

%% Load two images and their SIFT features
src_1 = './test images/Disney-00524.jpg';
src_2 = './test images/Mona-Lisa-452.jpg';
ext1 = '.sift';  % extension name of SIFT file
ext2 = '.sift';  % extension name of SIFT file
siftDim = 128;

%% load image 
im_1 = imread(src_1);
im_2 = imread(src_2);

%% load SIFT feature
% SIFT
% feature文件格式：binary格式，开头四个字节（int）为特征数目，后面逐个为SIFT特征结构体，每个SIFT特征包含128D的描述子（128个字节）
% 和 [x, y, scale, orientation]的16字节的位置、尺度和主方向信息（float）

featPath_1 = [src_1, ext1];
featPath_2 = [src_2, ext2];

fid_1 = fopen(featPath_1, 'rb');
featNum_1 = fread(fid_1, 1, 'int32'); % 文件中SIFT特征的数目
SiftFeat_1 = zeros(siftDim, featNum_1); 
paraFeat_1 = zeros(4, featNum_1);
for i = 1 : featNum_1 % 逐个读取SIFT特征
    SiftFeat_1(:, i) = fread(fid_1, siftDim, 'uchar'); %先读入128维描述子
    paraFeat_1(:, i) = fread(fid_1, 4, 'float32');     %再读入[x, y, scale, orientation]信息
end
fclose(fid_1);

fid_2 = fopen(featPath_2, 'rb');
featNum_2 = fread(fid_2, 1, 'int32'); % 文件中SIFT特征的数目
SiftFeat_2 = zeros(siftDim, featNum_2);
paraFeat_2 = zeros(4, featNum_2);
for i = 1 : featNum_2 % 逐个读取SIFT特征
    SiftFeat_2(:, i) = fread(fid_2, siftDim, 'uchar'); %先读入128维描述子
    paraFeat_2(:, i) = fread(fid_2, 4, 'float32');     %再读入[x, y, scale, orientation]信息
end
fclose(fid_2);

%% normalization
SiftFeat_1 = SiftFeat_1 ./ repmat(sqrt(sum(SiftFeat_1.^2)), size(SiftFeat_1, 1), 1);
SiftFeat_2 = SiftFeat_2 ./ repmat(sqrt(sum(SiftFeat_2.^2)), size(SiftFeat_2, 1), 1);

%% Display SIFT feature matching on RGB image
[row, col, cn] = size(im_1);
[r2, c2, n2] = size(im_2);
imgBig = 255 * ones(max(row, r2), col + c2, 3);
imgBig(1 : row, 1 : col, :) = im_1;
imgBig(1 : r2, col + 1 : end, :) = im_2; %% 将两幅图像拼成了一副大图像，左右排列

paraFeat_2(1, :) = paraFeat_2(1, :) + col; % 第二幅图像中的SIFT feature的列坐标要修改

mtchdPnt1=[];
mtchdPnt2=[];
for i = 1 : featNum_1
    feat = sqrt(sum((SiftFeat_2 - SiftFeat_1(:, i)).^2));
    [B, I] = sort(feat);
    if B(1)/B(2) < 0.8
        mtchdPnt1 = [mtchdPnt1; i];
        mtchdPnt2 = [mtchdPnt2; I(1)];
    end
end
hold off;
GX1 = zeros(size(mtchdPnt1,1),size(mtchdPnt1,1));
GY1 = zeros(size(mtchdPnt1,1),size(mtchdPnt1,1));
for i = 1 : size(mtchdPnt1, 1)
    for j = i+1 : size(mtchdPnt1, 1)  %根据几何关系，GX和GY均为反对称，因此只需计算一半
        if paraFeat_1(1, mtchdPnt1(i))>=paraFeat_1(1, mtchdPnt1(j))
            GX1(i,j) = 1;
        else
            GX1(j,i) = 1;
        end
        if paraFeat_1(2, mtchdPnt1(i))>=paraFeat_1(2, mtchdPnt1(j))
            GY1(i,j) = 1;
        else
            GY1(j,i) = 1;
        end
    end
end
GX2 = zeros(size(mtchdPnt2,1),size(mtchdPnt2,1));
GY2 = zeros(size(mtchdPnt2,1),size(mtchdPnt2,1));
for i = 1 : size(mtchdPnt2, 1)
    for j = i+1 : size(mtchdPnt2, 1)  %根据几何关系，GX和GY均为反对称，因此只需计算一半
        if paraFeat_2(1, mtchdPnt2(i))>=paraFeat_2(1, mtchdPnt2(j))
            GX2(i,j) = 1;
        else
            GX2(j,i) = 1;
        end
        if paraFeat_2(2, mtchdPnt2(i))>=paraFeat_2(2, mtchdPnt2(j))
            GY2(i,j) = 1;
        else
            GY2(j,i) = 1;
        end
    end
end
VX = xor(GX1,GX2);
VY = xor(GY1,GY2);
SX = sum(VX,2);
SY = sum(VY,2);
unmtchdPnt1 = [];
unmtchdPnt2 = [];
tag = 0;
while sum(SX)~=0 || sum(SY)~=0
    if tag
        [M, I] = max(SX);
    else
        [M, I] = max(SY);
    end
    VX(I,:) = [];
    VX(:,I) = [];
    VY(I,:) = [];
    VY(:,I) = [];
    unmtchdPnt1 = [unmtchdPnt1; mtchdPnt1(I)];
    unmtchdPnt2 = [unmtchdPnt2; mtchdPnt2(I)];
    mtchdPnt1(I) = [];
    mtchdPnt2(I) = [];
    SX = sum(VX,2);
    SY = sum(VY,2);
    tag=~tag;
end
figure(1); imshow(uint8(imgBig)); axis on;
hold on;
for i = 1 : size(mtchdPnt1,1)
    figure(1);
    hold on;
    plot([paraFeat_1(1, mtchdPnt1(i)), paraFeat_2(1, mtchdPnt2(i))], [paraFeat_1(2, mtchdPnt1(i)), paraFeat_2(2, mtchdPnt2(i))], 'g');
end
for i = 1 : size(unmtchdPnt1,1)
    figure(1);
    hold on;
    plot([paraFeat_1(1, unmtchdPnt1(i)), paraFeat_2(1, unmtchdPnt2(i))], [paraFeat_1(2, unmtchdPnt1(i)), paraFeat_2(2, unmtchdPnt2(i))], 'r');
end
hold off;