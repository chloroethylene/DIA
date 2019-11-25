function F_result = fft_implementation(image)
N = length(image);                              %图片尺寸
A = 1/sqrt(N)*exp(-2*pi*j*[0:N-1]'*[0:N-1]/N);  %根据定义，得到变换矩阵A
F = A*image*A;                                  %图像变换
P = [zeros(N/2),eye(N/2);eye(N/2),zeros(N/2)];  %行交换矩阵，要求N为偶数
Q = P;                                          %列交换矩阵
F_result = abs(P*F*Q);                          %行列变换，将低频成分移至中心
end