function [G,fai] = smooth_diff(image)
image = im2double(image);
sigma = 1;
tempsize = 3;
[M,N] = size(image);%Í¼Æ¬³ß´ç
%²î·ÖÄ£°å
[y,x] = meshgrid(-(tempsize-1)/2:(tempsize-1)/2,-(tempsize-1)/2:(tempsize-1)/2);        
hx = 1/sqrt(2*pi*sigma)*(exp(-((x+1).^2+y.^2)/(2*sigma^2))-exp(-((x-1).^2+y.^2)/(2*sigma^2)));
hy = 1/sqrt(2*pi*sigma)*(exp(-(x.^2+(y+1).^2)/(2*sigma^2))-exp(-(x.^2+(y-1).^2)/(2*sigma^2)));
%Padding
image = [zeros(M,(tempsize-1)/2),image,zeros(M,(tempsize-1)/2)];
image = [zeros((tempsize-1)/2,N+tempsize-1);image;zeros((tempsize-1)/2,N+tempsize-1)];
hxI = zeros(M,N);
hyI = zeros(M,N);
%¾í»ý
for i=1:M
    for j=1:N
        hxI(i,j) = sum(sum(hx.*image(i:i+tempsize-1,j:j+tempsize-1)));
    end
end
for i=1:M
    for j=1:N
        hyI(i,j) = sum(sum(hy.*image(i:i+tempsize-1,j:j+tempsize-1)));
    end
end
G = sqrt((hxI).^2+(hyI).^2);
fai = atan(hyI./hxI);
end