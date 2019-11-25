function eigenface = pca_face(data, img_dim, img_num, eigenface)
data = data-mean(data,2);                                   %�������ֵ��
Dx = data*data'/img_num;                                    %��Э�������
[P,Lambda] = eig(Dx);                                       %������ֵ����������
Lambda = diag(Lambda);
[~, index] = sort(Lambda,'descend');                        %������ֵ��������
dim = size(eigenface);
for i = 1:dim(3)
    eigenface(:,:,i) = reshape(P(:,index(i)),dim([1,2]));   %�����Ӧ���ļ�������ֵ������������reshape
end
end