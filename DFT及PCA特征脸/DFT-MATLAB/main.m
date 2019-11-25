%% �������FFT���� fft_implementation.m������ main.m ���ɵõ����н����

clear; close all;
N = 120;     % ͼƬ�ߴ�
image = zeros(N, N);

R = 10; %�ı�R����ֵ���۲���
theta = 30; %�ı�theta����ֵ���۲�����

u = R * cos(theta * pi / 180);
v = R * sin(theta * pi / 180);
for x = 1 : N
    for y = 1 : N
        image(x, y) = cos(pi / N * (u * x + v * y));
    end
end

figure(1);
subplot(1, 2, 1);
imshow(image); 
title('ԭͼ');

F_result = fft_implementation(image); % ������ɸú��� 

subplot(1, 2, 2);
imshow(F_result,[]); 
title({ '����Ҷ�任', ['R = ', num2str(R),' ', 'theta = ',num2str(theta)]});

