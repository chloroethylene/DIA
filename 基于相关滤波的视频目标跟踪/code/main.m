clc;
clear all;

% load video info
% We provide two videos: 'BlurCar1' and 'Girl'
%video_name = 'BlurCar1'; 
video_name = 'Girl';
base_path = './';

% The following function helps load the video information. You can ignore its details
% ima_files: videos frames
% pos: initial target position 
% target_sz: initial target size
% ground_truth: ground_truth label per frame
[img_files, pos, target_sz, ground_truth, video_path] = load_video_info(base_path, video_name);

% Correlation Filter (CF) tracker
positions = CFtracker(video_path, img_files, pos, target_sz);








