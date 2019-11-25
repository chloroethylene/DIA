function [positions] = CFtracker(img_path, img_files, pos, target_sz)
 
% Preparation Work
lambda = 1e-4; % lambda in the ridge regression
padding = 1.5; % we crop (1+1.5) times of target size to include background context
output_sigma_factor = 0.1; % for computing the Gaussian label
%window size, taking padding into account
window_sz = floor(target_sz * (1 + padding));

%create regression labels, gaussian shaped, with a bandwidth proportional to target size
output_sigma = sqrt(prod(target_sz)) * output_sigma_factor*2 ;
y = gaussian_shaped_labels(output_sigma, window_sz);

%store pre-computed cosine window. This helps reduce the boundary effect
cos_window = hann(size(y,1)) * hann(size(y,2))';	

positions = zeros(numel(img_files), 4);  %to calculate precision

%% First frame: learn a correlation filter
im = imread([img_path img_files{1}]);

% obtain the initial subwindow for CF learning 
patch = get_subwindow(im, pos, window_sz);
x = get_features(patch, cos_window);
      
% Kernel Ridge Regression, calculate alphas (in Fourier domain)
model_wf = learn_CF(x, y, lambda);

%% Tracking process
for frame = 1 : numel(img_files)
    % load image
    im = imread([img_path img_files{frame}]);
    
    % tracking process 
    if frame > 1
        patch = get_subwindow(im, pos, window_sz);
        z = get_features(patch, cos_window);
        zf = fft2(z);
        
        %  #######################  CF detection  ######################################
        % calculate response of the classifier at all shifts
        response = real(ifft2(model_wf .* zf));

        [vert_delta, horiz_delta] = find(response == max(response(:)), 1);

        if vert_delta > size(zf,1) / 2  %wrap around to negative half-space of vertical axis
            vert_delta = vert_delta - size(zf,1);
        end
        if horiz_delta > size(zf,2) / 2  %same for horizontal axis
            horiz_delta = horiz_delta - size(zf,2);
        end
        pos = pos + [vert_delta - 1, horiz_delta - 1] ;    
     
    end

    %save position and timing
    rect_position = [pos([2,1]) - target_sz([2,1])/2, target_sz([2,1])];
    positions(frame,:) = rect_position;
    
    % visualization
    if frame == 1  %first frame, create GUI
        im_handle = imshow(uint8(im), 'Border','tight', 'InitialMag', 100 + 100 * (length(im) < 500));
        rect_handle = rectangle('Position', rect_position, 'LineWidth', 2, 'EdgeColor','r');
        text_handle = text(10, 10, int2str(frame));
        set(text_handle, 'color', [1 0 1]);
    else
        try  % subsequent frames, update GUI
            set(im_handle, 'CData', im)
            set(rect_handle, 'Position', rect_position)
            set(text_handle, 'string', int2str(frame));
        catch
            return
        end
    end
    drawnow
    pause(0.03);
end

