function F_result = fft_implementation(image)
N = length(image);                              %ͼƬ�ߴ�
A = 1/sqrt(N)*exp(-2*pi*j*[0:N-1]'*[0:N-1]/N);  %���ݶ��壬�õ��任����A
F = A*image*A;                                  %ͼ��任
P = [zeros(N/2),eye(N/2);eye(N/2),zeros(N/2)];  %�н�������Ҫ��NΪż��
Q = P;                                          %�н�������
F_result = abs(P*F*Q);                          %���б任������Ƶ�ɷ���������
end