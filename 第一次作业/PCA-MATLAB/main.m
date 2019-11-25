%% �����������PCA�㷨������pca_face.m ������main.m�����ɵõ�������ͼ��

clear; close all;

img_num = 400; %����ͼ������
img_dim = 112 * 92; %ͼ���СΪ(112, 92)���������������ά��Ϊ(112 * 92, 1)
filetype = char('*.pgm');
filedir = 'face_img\';
data = loaddata(img_num, img_dim, filetype, filedir); %��ȡ����ͼ��
fprintf('Load data done');

eigenface = zeros(112, 92, 8); 
%��������������eigenface�У�eigenface�Ĵ�СΪ(112, 92, 8)����8�㣬ÿ���СΪ(112��92)��
%ÿ�㱣��һ��������������ǰ 8 ����������

eigenface = pca_face(data, img_dim, img_num, eigenface); %������ɸú���

figure(1); %չʾ������ͼ��
for i = 1 : 8;
    subplot(2, 4, i);
    imshow(eigenface(:, :, i), []);
end



