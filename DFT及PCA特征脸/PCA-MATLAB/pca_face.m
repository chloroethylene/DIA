function eigenface = pca_face(data, img_dim, img_num, eigenface)
data = data-mean(data,2);                                   %数据零均值化
Dx = data*data'/img_num;                                    %求协方差矩阵
[P,Lambda] = eig(Dx);                                       %求特征值及特征向量
Lambda = diag(Lambda);
[~, index] = sort(Lambda,'descend');                        %将特征值降序排列
dim = size(eigenface);
for i = 1:dim(3)
    eigenface(:,:,i) = reshape(P(:,index(i)),dim([1,2]));   %求出对应最大的几个特征值的特征向量并reshape
end
end