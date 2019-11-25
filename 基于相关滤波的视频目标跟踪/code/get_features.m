function x = get_features(im, cos_window)

%gray-level (scalar feature)
if size(im,3) > 1
    im = rgb2gray(im);
end
x = double(im) / 255;
x = x - mean(x(:));

%process with cosine window if needed
if ~isempty(cos_window)
    x = bsxfun(@times, x, cos_window);
end