%% 请大家完成人脸PCA算法函数：pca_face.m 。运行main.m，即可得到特征脸图象。

clear; close all;

img_num = 400; %人脸图像数量
img_dim = 112 * 92; %图像大小为(112, 92)，拉成列向量后的维度为(112 * 92, 1)
filetype = char('*.pgm');
filedir = 'face_img\';
data = loaddata(img_num, img_dim, filetype, filedir); %读取人脸图象
fprintf('Load data done');

eigenface = zeros(112, 92, 8); 
%将特征脸保存在eigenface中，eigenface的大小为(112, 92, 8)，共8层，每层大小为(112，92)，
%每层保存一个特征脸。保留前 8 个特征脸。

eigenface = pca_face(data, img_dim, img_num, eigenface); %请大家完成该函数

figure(1); %展示特征脸图象
for i = 1 : 8;
    subplot(2, 4, i);
    imshow(eigenface(:, :, i), []);
end



