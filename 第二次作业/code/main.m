%% 设置i代表不同的图片，运行main.m

clear; close all;
filename = char('lenna.jpg','chip.tif','cameraman.jpg','airport.tif');
filedir = '../test images/';
for i=1:4
    image = imread([filedir filename(i,:)]);
    if size(image,3)~=1
        image = rgb2gray(image);
    end
    [G,fai] = smooth_diff(image);
    result = NMS(G,fai);
    edge = doubleth(result);
    
    figure(i)
    subplot(2,2,1);
    imshow(image,[]);
    subplot(2,2,2);
    imshow(G,[]);
    subplot(2,2,3);
    imshow(result,[]);
    subplot(2,2,4);
    imshow(edge,[]);
end