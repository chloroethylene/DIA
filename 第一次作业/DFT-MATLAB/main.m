%% 请大家完成FFT函数 fft_implementation.m。运行 main.m 即可得到运行结果。

clear; close all;
N = 120;     % 图片尺寸
image = zeros(N, N);

R = 10; %改变R的数值，观察结果
theta = 30; %改变theta的数值，观察结果。

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
title('原图');

F_result = fft_implementation(image); % 请大家完成该函数 

subplot(1, 2, 2);
imshow(F_result,[]); 
title({ '傅里叶变换', ['R = ', num2str(R),' ', 'theta = ',num2str(theta)]});

